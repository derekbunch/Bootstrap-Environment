#!/usr/bin/env bash
typeset -gx BOOTSTRAP_ENV_PATH=$(dirname "$(readlink -f "$0")")
source $BOOTSTRAP_ENV_PATH/.termcolors.sh
source $BOOTSTRAP_ENV_PATH/.helpers.bash

_get_os_type
_os_aware_install git
_os_aware_install wget
_os_aware_install curl
_os_aware_install zsh
_os_aware_install thefuck
_os_aware_install jq
_os_aware_install tmux
_install_rtx

if ! _is_hardlinked ~/.zshrc "$BOOTSTRAP_ENV_PATH/.zshrc"; then
  [ -f ~/.zshrc ] && __log attention "Renaming existing .zshrc to .zshrc.orig" && mv ~/.zshrc ~/.zshrc.orig || __log debug "no current zshrc"
  __log attention "Linking zshrc"
  # ln -s ~/Bootstrap-Environment/zi.zshrc ~/.zshrc
  # ln $BOOTSTRAP_ENV_PATH/zi.zshrc ~/.zshrc
  cp $BOOTSTRAP_ENV_PATH/zi.zshrc ~/.zshrc
fi

[ -f ~/.p10k.zsh ] || cp "$BOOTSTRAP_ENV_PATH/.zsh-theme-gruvbox-material-dark" ~/.p10k.zsh

echo -e "\n"
read -p $'\e[1m\e[34mIs this a work device?\e[0m(y/N) ' confirm -n 1
case $confirm in
y | Y)
  typeset -gx INCLUDE_WORK_FUNCS=true
  break
  ;;
*)
  break
  ;;
esac

exec zsh
