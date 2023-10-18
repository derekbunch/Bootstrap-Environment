#!/usr/bin/env bash
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
    apt update
    apt install -y software-properties-common apt-transport-https ca-certificates curl gnupg lsb-release build-essential
    ;;
  *)
    __log error "Unsupported OS"
    exit 1
    ;;
  esac
}

_os_aware_install() {
  case "$OSTYPE" in
  darwin*)
    command -v $1 &>/dev/null || (__log debug "Installing $1" && brew install $1)
    ;;
  linux*)
    # command -v $1 &>/dev/null || (__log debug "Installing $1" && sudo apt install -y $1)
    command -v $1 &>/dev/null || (__log debug "Installing $1" && apt install -y $1)
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
    command -v $1 &>/dev/null && (__log debug "Uninstalling $1" && brew uninstall $1)
    ;;
  linux*)
    # command -v $1 &>/dev/null && (__log debug "Uninstalling $1" && sudo apt remove -y $1)
    command -v $1 &>/dev/null && (__log debug "Uninstalling $1" && apt remove -y $1)
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
