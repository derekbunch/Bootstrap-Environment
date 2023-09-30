#!/usr/bin/env bash
typeset -gx BOOTSTRAP_ENV_PATH=$(dirname "$(readlink -f "$0")")
source $BOOTSTRAP_ENV_PATH/.termcolors.sh
source $BOOTSTRAP_ENV_PATH/.helpers.bash

_os_aware_install git
_os_aware_install zsh
_os_aware_install thefuck
_os_aware_install jq
_os_aware_install tmux
_install_rtx

if ! _is_hardlinked ~/.zshrc "$BOOTSTRAP_ENV_PATH/.zshrc"; then
  [ -f ~/.zshrc ] && __log attention "Renaming existing .zshrc to .zshrc.orig" && mv ~/.zshrc ~/.zshrc.orig || __log debug "no current zshrc"
  __log attention "Linking zshrc"
  ln -s ~/Bootstrap-Environment/zi.zshrc ~/.zshrc
fi

echo -e "\n"
read -p "${Bold}${Blue}Is this a work device?${end}(Y/n) " confirm
if [ ${confirm,,} == 'y' ]; then
  typeset -gx INCLUDE_WORK_FUNCS=true
fi

exec zsh
