#!/usr/bin/env bash
typeset -gx _BOOTSTRAP_ENV_PATH=$(dirname "$(readlink -f "$0")")
# typeset -gx SHOW_CMD_OUTPUT=true
# cat ~/.cache/bootstrap_env_cache
source $_BOOTSTRAP_ENV_PATH/.termcolors.sh
source $_BOOTSTRAP_ENV_PATH/.helpers.bash
_cache_var BOOTSTRAP_ENV_PATH $_BOOTSTRAP_ENV_PATH
_load_cache

_get_os_type
_os_aware_install git
_os_aware_install wget
_os_aware_install curl
_os_aware_install zsh
_os_aware_install thefuck
_os_aware_install jq
_os_aware_install tmux
_os_aware_install file
_os_aware_install bsdmainutils
_os_aware_install subversion
_install_rtx

if ! _is_hardlinked ~/.zshrc "$BOOTSTRAP_ENV_PATH/.zshrc"; then
  [ -f ~/.zshrc ] && __log attention "Renaming existing .zshrc to .zshrc.orig" && mv ~/.zshrc ~/.zshrc.orig || __log debug "no current zshrc"
  __log attention "Linking zshrc"
  # ln -s ~/Bootstrap-Environment/zi.zshrc ~/.zshrc
  # ln $BOOTSTRAP_ENV_PATH/zi.zshrc ~/.zshrc
  cp $BOOTSTRAP_ENV_PATH/zi.zshrc ~/.zshrc
fi

[ -f ~/.p10k.zsh ] || cp "$BOOTSTRAP_ENV_PATH/.zsh-theme-gruvbox-material-dark" ~/.p10k.zsh

if [ -z $INCLUDE_WORK_FUNCS ]; then
  echo -e "\n"
  read -n 1 -p $'\e[1m\e[34mIs this a work device?\e[0m (y/N): ' confirm
  echo -e "\n"
  if [[ $confirm == [yY] ]]; then
    _cache_var INCLUDE_WORK_FUNCS true
  else
    _cache_var INCLUDE_WORK_FUNCS false
  fi
fi

exec zsh
