# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.zplug/init.zsh

for file in $HOME/Bootstrap-Environment/zplug_rcs/*.rc; do
  source $file
done


# Async for zsh, used by pure
zplug "mafredri/zsh-async", from:github, defer:0
# Syntax highlighting for commands, load last
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
# Theme!
zplug "romkatv/powerlevel10k", from:github, as:theme

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Actually install plugins, prompt user input
if ! zplug check --verbose; then
  printf "Install zplug plugins? [y/N]: "
  if read -q; then
    echo
    zplug install
  fi
fi

#===========================
# *      Oh My Zsh
#===========================
# Load ohmyzsh plugins
omzplugins=(
  aliases
  appup
  asdf
  autojump
  aws
  colored-man-pages
  colorize
  completion
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
  zsh-iterm-touchbar
  zsh-syntax-highlighting
  #fasd
  # globalias
  # zsh-sync
  # profiles
  # virtualenvwrapper
)
for plugin in $omzplugins; do
  zplug "lib/$plugin", from:oh-my-zsh
done
#------------------------------------------------

zplug load --verbose
