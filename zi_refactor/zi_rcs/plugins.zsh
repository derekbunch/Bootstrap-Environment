# ? Turbo
#===========================
# *      Oh My Zsh
#==========================
# Load ohmyzsh plugins

# Completions
zi silent ice wait as"completion" for \
  OMZP::ripgrep/_ripgrep

# OMZ Lib
zi silent wait for \
  OMZL::bzr.zsh \
  OMZL::cli.zsh \
  OMZL::clipboard.zsh \
  OMZL::compfix.zsh \
  OMZL::completion.zsh \
  OMZL::correction.zsh \
  OMZL::diagnostics.zsh \
  OMZL::directories.zsh \
  OMZL::functions.zsh \
  OMZL::git.zsh \
  OMZL::grep.zsh \
  OMZL::history.zsh \
  OMZL::key-bindings.zsh \
  OMZL::misc.zsh \
  OMZL::nvm.zsh \
  OMZL::prompt_info_functions.zsh \
  OMZL::spectrum.zsh \
  OMZL::termsupport.zsh \
  OMZL::theme-and-appearance.zsh \
  OMZL::vcs_info.zsh

# OMZ Subdirs
zi silent wait svn for \
  OMZP::aliases \
  OMZ::lib

# OMZ Plugins
zi silent wait atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" for \
  OMZP::aliases \
  OMZP::asdf \
  OMZP::autojump \
  OMZP::aws \
  OMZP::colored-man-pages \
  OMZP::colorize \
  OMZP::direnv \
  OMZP::docker \
  OMZP::docker-compose \
  OMZP::fzf \
  OMZP::gcloud \
  OMZP::git \
  OMZP::github \
  OMZP::git-prompt \
  OMZP::golang \
  OMZP::helm \
  OMZP::jira \
  OMZP::kubectl \
  OMZP::kubectx \
  OMZP::pip \
  OMZP::python \
  OMZP::poetry \
  OMZP::pyenv \
  OMZP::rust \
  OMZP::sudo \
  OMZP::terraform \
  OMZP::tmux \
  OMZP::virtualenv \
  OMZP::z
# OMZP::appup \

# Mac Only
if [[ $OSTYPE == *darwin* ]]; then
  zi lucid wait for \
    atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    OMZP::brew \
    OMZP::iterm2 \
    OMZP::macos \
    OMZP::zsh-iterm-touchbar
fi
#------------------------------------------------
