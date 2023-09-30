# ? From Zinit Repo Examples
# Scripts built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make'' ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only default target.
zi ice lucid \
  as"program" \
  pick"$ZPFX/bin/git-*" \
  make"PREFIX=$ZPFX"
zi light tj/git-extras

# ? Turbo
#===========================
# *      Oh My Zsh
#==========================
# Load ohmyzsh plugins

# Completions
zi lucid ice wait as"completion" for \
  OMZP::ripgrep/_ripgrep

# OMZ Lib
zi lucid wait for \
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

# OMZ Plugins
zi lucid wait atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" for \
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
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    OMZP::brew \
    OMZP::iterm2 \
    OMZP::macos \
    OMZP::zsh-iterm-touchbar
fi
#------------------------------------------------

# * Powerlevel10k
zi ice lucid wait'!' \
  nocd \
  atload'source $BOOTSTRAP_ENV_PATH/.zsh-theme-gruvbox-material-dark; _p9k_precmd'
# atload"source ~/Bootstrap_Environment/.zsh-theme-gruvbox-material-dark; _p9k_precmd"
zi light romkatv/powerlevel10k

zi lucid wait for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
  zdharma-continuum/fast-syntax-highlighting \
  blockf \
  zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions
