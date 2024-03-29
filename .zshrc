# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  aliases
  appup
  asdf
  autojump
  aws
  colored-man-pages
  colorize
  direnv
  docker
  docker-compose
  fig
  fzf
  gcloud
  git
  github
  git-prompt
  golang
  helm
  iterm2
  jira
  kubectl
  kubectx
  macos
  pip
  python
  poetry
  pyenv
  ripgrep
  sudo
  terraform
  tmux
  virtualenv
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  # zsh-iterm-touchbar
  #fasd
  # globalias
  # zsh-sync
  # profiles
  # virtualenvwrapper
  )

## Source all configs
if [ -f $HOME/Bootstrap-Environment/personal ]; then
  for file in $HOME/Bootstrap-Environment/personal-config/*.rc; do
    source $file
  done
elif [ -f $HOME/Bootstrap-Environment/work ]; then
  for file in $HOME/Bootstrap-Environment/work-config/*.rc; do
    source $file
  done
fi

source "$HOME/.rye/env"

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

fpath+=~/.zfunc
autoload -Uz +X compinit compdef
compinit
_comp_options+=(globdots)
eval "$(ssh-agent -s)" &>/dev/null
eval "$(direnv hook zsh)"
eval "$(pyenv init -)"

#--Zsh Sync Config----
#ZSH_SYNC_REMOTE=
#---------------------

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# eval $(thefuck --alias)
# eval "$(fasd --init auto)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/Bootstrap-Environment/.zsh-theme-gruvbox-material-dark


[[ ! -f ~/recharge/dbt/.data_scripts.sh ]] || source "${HOME}"/recharge/dbt/.data_scripts.sh

[[ -f "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autoenv/autoenv.zsh" ]] || git clone https://github.com/Tarrasch/zsh-autoenv "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autoenv"
source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autoenv/autoenv.zsh"

[[ -f "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autopair/autopair.zsh" ]] || git clone https://github.com/hlissner/zsh-autopair "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autopair"
source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autopair/autopair.zsh"
autopair-init

updatels

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
