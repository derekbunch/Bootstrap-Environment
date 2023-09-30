# pyenv/pyenv
zi ice \
  atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh; PYENV_ROOT="$(pyenv root)" ./bin/pyenv-virtualenv-init - > zpyenv-virtualenv.zsh' \
  atinit'export PYENV_ROOT="$PWD"' \
  atpull"%atclone" \
  as'command' \
  pick'bin/pyenv' \
  multisrc"{zpyenv|zpyenv-virtualenv.zsh}.zsh" \
  nocompile'!' \
  for \
  light pyenv/pyenv \
  pick"bin/pyenv-virtualenv" \
  light pyenv/pyenv-virtualenv

zi ice has"pyenv" \
  atclone'PYENV_ROOT="$(pyenv root)" ./bin/pyenv-virtualenv-init - > zpyenv-virtualenv.zsh' \
  atpull"%atclone" \
  as'command' \
  pick'bin/pyenv-virtualenv' \
  src"zpyenv-virtualenv.zsh" \
  nocompile'!'

# https://zdharma-continuum.github.io/zi/wiki/Direnv-explanation/
zi as"program" \
  atclone'./direnv hook zsh > zhook.zsh' \
  atpull'%atclone' \
  make'!' \
  pick"direnv" \
  src"zhook.zsh" \
  for \
  direnv/direnv

# Highlighter
zi ice pick"h.sh"
zi light paoloantinori/hhighlighter

# FD
[ $(uname -s) = "Darwin" ] && FD_BPICK="*darwin.tar.gz" || FD_BPICK="*$(uname -m)-unknown-linux-gnu.tar.gz"
# old_value bpick="*amd64.deb" \
zi ice \
  as="command" \
  from="gh-r" \
  bpick="$FD_BPICK" \
  pick="usr/bin/fd"
zi light sharkdp/fd

# GOOGLE-CLOUD-SDK COMPLETION
if [[ -f /opt/google-cloud-sdk/completion.zsh.inc ]]; then
  zi ice as"completion"
  zi snippet /opt/google-cloud-sdk/completion.zsh.inc
fi

# ? Turbo
# rust-lang/rustup
# Installation of Rust compiler environment via the z-a-rust annex
zi lucid rustup wait"1" \
  id-as"rust" \
  as"null" \
  sbin="bin/*" \
  atload="[[ ! -f ${zi[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall -q rust; \
    export CARGO_HOME=\$PWD; export RUSTUP_HOME=\$PWD/rustup" \
  for \
  zdharma-continuum/null

# RIPGREP
[ $(uname -s) = "Darwin" ] && RIPGREP_BPICK="*darwin.tar.gz" || RIPGREP_BPICK="*linux64.tar.gz"
# old value bpick"*amd64.deb"
zi ice wait"1" \
  from"gh-r" \
  as"program" \
  bpick"$RIPGREP_BPICK" \
  pick"usr/bin/rg"
zi light BurntSushi/ripgrep

# sharkdp/bat
zi ice wait"1" \
  as"command" \
  from"gh-r" \
  mv"bat* -> bat" \
  pick"bat/bat"
zi light sharkdp/bat

# BAT-EXTRAS
zi ice lucid wait"1" as"program" pick"src/batgrep.sh"
zi ice lucid wait"1" as"program" pick"src/batdiff.sh"
zi light eth-p/bat-extras

# zsh-autopair
zi ice lucid wait"1"
zi load hlissner/zsh-autopair

# zdharma-continuum/history-search-multi-word
zstyle ":history-search-multi-word" page-size "11"
zi ice lucid wait"1"
zi load zdharma-continuum/history-search-multi-word

# NEOVIM
[ $(uname -s) = "Darwin" ] && NVIM_BPICK="*macos.tar.gz" || NVIM_BPICK="*linux64.tar.gz"
zi ice \
  from="gh-r" \
  as="program" \
  bpick="$NVIM_BPICK" \
  ver="nightly" \
  pick="nvim-linux64/bin/nvim"
zi light neovim/neovim

# LAZYDOCKER
zi ice lucid wait"1" \
  as"program" \
  from"gh-r" \
  bpick"*$(uname -s)_x86_64*" \
  pick"lazydocker"
zi light jesseduffield/lazydocker

# # eza-community/eza also uses the definitions
# zi ice wait"0c" lucid reset \
#     atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
#             \${P}sed -i \
#             '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
#             \${P}dircolors -b LS_COLORS > c.zsh" \
#     atpull'%atclone' pick"c.zsh" nocompile'!' \
#     atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
# zi light trapd00r/LS_COLORS
#
# eza-community/eza
zi ice lucid wait"2" \
  from"gh-r" \
  as"program" #mv"eza* -> eza"
zi light eza-community/eza

# Mac only
if [[ $OSTYPE == *darwin* ]]; then
  zi ice \
    as"program" \
    from"gh-r" \
    bpick"*darwin_amd64.zip" \
    pick"Flycut"
  zi light TermiT/Flycut
fi
