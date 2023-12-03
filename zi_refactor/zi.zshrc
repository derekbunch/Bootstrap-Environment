#!/usr/bin/env zsh
source ~/.cache/bootstrap_env_cache
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

typeset -Ag ZI
ZI[HOME_DIR]="${HOME}/.zi"
ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"
[ ! -d ${ZI[BIN_DIR]} ] && mkdir -p "${ZI[BIN_DIR]}"
if [ ! -d ${ZI[BIN_DIR]}/.git ]; then
  source $BOOTSTRAP_ENV_PATH/.helpers.bash
  print -P "%F{33}▓▒░ %F{220}Installing ZI Initiative Plugin Manager (z-shell/zi)…%f"
  # For security reasons run function compaudit to check if the completion system would use files owned by root or by the current user, or files in directories that are world or group-writable.
  # If failed, then set the current user as the owner of directories, then remove group/others write permissions, and clone the repository:
  compaudit | xargs chown -R "$(whoami)" "$ZI[HOME_DIR]"
  compaudit | xargs chmod -R go-w "$ZI[HOME_DIR]"
  command git clone https://github.com/z-shell/zi "${ZI[BIN_DIR]}" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
    print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "${ZI[BIN_DIR]}/zi.zsh"
### End of ZI installer's chunk

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

for file in $BOOTSTRAP_ENV_PATH/zi_rcs/*.rc; do
  # [ "$file" = $BOOTSTRAP_ENV_PATH/zi_rcs/aliases.rc ] && continue
  source $file
done
# source $BOOTSTRAP_ENV_PATH/zi_rcs/annexes.zsh
# source $BOOTSTRAP_ENV_PATH/zi_rcs/tools.zsh
# source $BOOTSTRAP_ENV_PATH/zi_rcs/plugins.zsh
# for file in $BOOTSTRAP_ENV_PATH/zi_rcs/*.zsh; do
#   [ "$file" = "$BOOTSTRAP_ENV_PATH/zi_rcs/annexes.zsh" ] && continue
#   source $file
# done

for file in $BOOTSTRAP_ENV_PATH/zi_rcs/*.rc; do
  # [ "$file" = $BOOTSTRAP_ENV_PATH/zi_rcs/aliases.rc ] && continue
  source $file
done

# source $BOOTSTRAP_ENV_PATH/zi_rcs/aliases.rc
updatels



# exec zsh -il
# zi self-update