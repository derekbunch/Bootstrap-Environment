#!/usr/bin/env bash
source .termcolors.sh .helpers.bash

export ZI_HOME_DIR="${HOME}/.zi"
_log info "Uninstalling Zi"
rm -rf $ZI_HOME_DIR

_os_aware_uninstall eza
_os_aware_uninstall thefuck
_os_aware_uninstall rtx
_os_aware_uninstall jq
_os_aware_uninstall tmux
_uninstall_rtx

if ! _is_hardlinked ~/.zshrc "$BOOTSTRAP_ENV_PATH/.zshrc"; then
  _log attention "Restoring.zshrc.orig"
  unlink ~/.zshrc
  mv ~/.zshrc.orig ~/.zshrc
fi

source ~/.zshrc
