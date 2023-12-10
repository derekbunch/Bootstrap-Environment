#!/usr/bin/env bash
_BOOTSTRAP_ENV_CACHE_FILE=~/.cache/bootstrap_env_cache
__log() {
  local log_type=$1
  shift
  case "$log_type" in
  attention)
    echo -e "\n${BBlue}$@${end}"
    ;;
  debug)
    [ -z $QUIET ] && echo -e "\n${BGreen}$@${end}"
    ;;
  info)
    echo -e "\n${BYellow}$@${end}"
    ;;
  error)
    echo -e "\n${BRed}$@${end}"
    ;;
  *)
    echo -e "\n${Bold}$@${end}"
    ;;
  esac
}

_get_os_type() {
  case "$OSTYPE" in
  darwin*)
    __log info "OS is OS X"
    __log debug "Installing Homebrew"
    xcode-select --install
    [ ! type brew ] && /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ;;
  linux*)
    __log info "OS is Linux"
    __log debug "Installing apt dependencies"
    sudo apt update &>/dev/null
    sudo apt install -y software-properties-common apt-transport-https ca-certificates curl gnupg lsb-release build-essential &>/dev/null
    ;;
  *)
    __log error "Unsupported OS"
    exit 1
    ;;
  esac
}

_os_aware_operation() {
  local operation=$1
  local package=$2
  local cmd=$3
  if [ -z $SHOW_CMD_OUTPUT ]; then
    output_pipe="/dev/null"
  else
    output_pipe="/dev/tty"
  fi

  case "$OSTYPE" in
  darwin* | linux*)
    if [ "$operation" = "install" ]; then
      command -v $package &>/dev/null || (__log debug "Installing $package" && $cmd $package >$output_pipe)
    elif [ "$operation" = "uninstall" ]; then
      command -v $package &>/dev/null && (__log debug "Uninstalling $package" && $cmd $package >$output_pipe)
    fi
    ;;
  *)
    __log error "Unknown OS"
    exit 1
    ;;
  esac
}

_os_aware_install() {
  case "$OSTYPE" in
  darwin*)
    _os_aware_operation "install" $1 "brew install"
    ;;
  linux*)
    _os_aware_operation "install" $1 "sudo apt install -y"
    ;;
  *)
    __log error "Unknown OS"
    exit 1
    ;;
  esac
}

_os_aware_uninstall() {
  case "$OSTYPE" in
  darwin*)
    _os_aware_operation "uninstall" $1 "brew uninstall"
    ;;
  linux*)
    _os_aware_operation "uninstall" $1 "sudo apt remove -y"
    ;;
  *)
    __log error "Unknown OS"
    exit 1
    ;;
  esac
}

_is_hardlinked() {
  local file1=$1
  local file2=$2
  [ -f $file1 ] || return 1
  [ -f $file2 ] || return 1
  [ "$(stat -c '%i' $file1)" == "$(stat -c '%i' $file2)" ]
}

_install_rtx() {
  command -v rtx &>/dev/null && return
  case "$OSTYPE" in
  darwin*)
    __log debug "Installing rtx"
    brew tap rtxtech/rtx-cli
    brew install rtx-cli
    ;;
  linux*)
    [ "$(uname -m)" = "aarch64" ] && __log error "Unsupported architecture for rtx" && return
    __log debug "Installing rtx"
    # sudo install -dm 755 /etc/apt/keyrings
    install -dm 755 /etc/apt/keyrings
    # wget -qO - https://rtx.pub/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/rtx-archive-keyring.gpg 1>/dev/null
    wget -qO - https://rtx.pub/gpg-key.pub | gpg --dearmor | tee /etc/apt/keyrings/rtx-archive-keyring.gpg 1>/dev/null
    # echo "deb [signed-by=/etc/apt/keyrings/rtx-archive-keyring.gpg arch=amd64] https://rtx.pub/deb stable main" | sudo tee /etc/apt/sources.list.d/rtx.list
    echo "deb [signed-by=/etc/apt/keyrings/rtx-archive-keyring.gpg arch=amd64] https://rtx.pub/deb stable main" | tee /etc/apt/sources.list.d/rtx.list
    # sudo apt update
    apt update
    # sudo apt install -y rtx
    apt install -y rtx
    ;;
  esac
}

_uninstall_rtx() {
  command -v rtx &>/dev/null || return
  case "$OSTYPE" in
  darwin*)
    __log debug "Uninstalling rtx"
    brew uninstall rtx-cli
    ;;
  linux*)
    [ "$(uname -m)" = "aarch64"] && __log error "Unsupported architecture for rtx" && return
    __log debug "Uninstalling rtx"
    sudo apt remove -y rtx
    ;;
  esac
}

_create_cache_if_not_exists() {
  mkdir -p ~/.cache
  [[ -f $_BOOTSTRAP_ENV_CACHE_FILE ]] || touch $_BOOTSTRAP_ENV_CACHE_FILE
}

_load_cache() {
  _create_cache_if_not_exists
  while IFS= read -r line; do
    line=$(echo "$line" | sed 's/^export //')
    __log debug "Loading cached $line"
    typeset -gx "$line"
  done <"$_BOOTSTRAP_ENV_CACHE_FILE"
}

_cache_var() {
  local var_name=$1
  local var_value=$2
  _create_cache_if_not_exists

  if grep -q "^export $var_name=" "$_BOOTSTRAP_ENV_CACHE_FILE"; then
    local cached_value=$(grep "^export $var_name=" "$_BOOTSTRAP_ENV_CACHE_FILE" | cut -d'=' -f2-)
    if [ "$cached_value" != "$var_value" ]; then
      __log debug "Updating cached $var_name=$var_value"
      sed -i "s|^export $var_name=.*|export $var_name=$var_value|" "$_BOOTSTRAP_ENV_CACHE_FILE"
    fi
  else
    __log debug "Caching $var_name=$var_value"
    echo "export $var_name=$var_value" >>"$_BOOTSTRAP_ENV_CACHE_FILE"
  fi
}

_load_var_from_cache() {
  local var_name=$1
  local default_value=$2
  _create_cache_if_not_exists

  if grep -q "^export $var_name=" "$_BOOTSTRAP_ENV_CACHE_FILE"; then
    local cached_value=$(grep "^export $var_name=" "$_BOOTSTRAP_ENV_CACHE_FILE" | cut -d'=' -f2-)
    echo "$cached_value"
  else
    _cache_var $var_name $default_value
    echo "$default_value"
  fi
}
