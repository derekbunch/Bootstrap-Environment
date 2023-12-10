#!/usr/bin/env bash
typeset -gx _BOOTSTRAP_ENV_PATH=$(dirname "$(readlink -f "$0")")
typeset -gx SHOW_CMD_OUTPUT=true
source $_BOOTSTRAP_ENV_PATH/.termcolors.sh
source $_BOOTSTRAP_ENV_PATH/.helpers.bash
_cache_var BOOTSTRAP_ENV_PATH $_BOOTSTRAP_ENV_PATH
_load_cache

export ZI_HOME_DIR="${HOME}/.zi"
__log info "Uninstalling Zi"
rm -rf $ZI_HOME_DIR

_os_aware_uninstall git
_os_aware_uninstall wget
_os_aware_uninstall curl
_os_aware_uninstall zsh
_os_aware_uninstall thefuck
_os_aware_uninstall jq
_os_aware_uninstall tmux
_os_aware_uninstall file
_os_aware_uninstall bsdmainutils
_uninstall_rtx

if ! _is_hardlinked ~/.zshrc "$BOOTSTRAP_ENV_PATH/.zshrc"; then
  __log attention "Restoring.zshrc.orig"
  unlink ~/.zshrc 2>/dev/null
  mv ~/.zshrc.orig ~/.zshrc 2>/dev/null
fi

exec bash
