# pyenv/pyenv - still not working
zi ice \
  atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh; PYENV_ROOT="$(pyenv root)" ./bin/pyenv-virtualenv-init - > zpyenv-virtualenv.zsh' \
  atinit'export PYENV_ROOT="$PWD"' \
  atpull"%atclone" \
  as'command' \
  multisrc"{zpyenv|zpyenv-virtualenv.zsh}.zsh" \
  nocompile'!' \
  for \
  pick'bin/pyenv' load pyenv/pyenv \
  pick"bin/pyenv-virtualenv" load pyenv/pyenv-virtualenv

# https://wiki.zshell.dev/docs/guides/syntax/standard#direnv - not working, needs go
# zi as"program" \
#   make'!' \
#   atclone'./direnv hook zsh > zhook.zsh' \
#   atpull'%atclone' \
#   src="zhook.zsh" \
#   for \
#   direnv/direnv

# Highlighter
zi ice pick"h.sh"
zi load paoloantinori/hhighlighter

# # FD - Included in annexes.zsh, this is just for reference incase of future changes
# [ $(uname -s) = "Darwin" ] && FD_BPICK="*darwin.tar.gz" || FD_BPICK="*$(uname -m)-unknown-linux-gnu.tar.gz"
# # old_value bpick="*amd64.deb" \
# zi ice \
#   as="command" \
#   from="gh-r" \
#   bpick="$FD_BPICK" \
#   pick="usr/bin/fd"
# zi light sharkdp/fd

# GOOGLE-CLOUD-SDK COMPLETION
if [[ -f /opt/google-cloud-sdk/completion.zsh.inc ]]; then
  zi ice as"completion"
  zi snippet /opt/google-cloud-sdk/completion.zsh.inc
fi

# ? Turbo
# BAT-EXTRAS
zi ice wait"1" as"program" pick"src/batgrep.sh"
zi ice wait"1" as"program" pick"src/batdiff.sh"
zi load eth-p/bat-extras

# hlissner/zsh-autopair
zi ice wait"1"
zi load hlissner/zsh-autopair

# NEOVIM
[ $(uname -s) = "Darwin" ] && NVIM_BPICK="*macos.tar.gz" || NVIM_BPICK="*linux64.tar.gz"
zi ice \
  from="gh-r" \
  as="program" \
  bpick="$NVIM_BPICK" \
  ver="nightly" \
  pick="nvim-linux64/bin/nvim"
zi load neovim/neovim

# LAZYDOCKER
zi ice wait"1" \
  as"program" \
  from"gh-r" \
  bpick"*$(uname -s)_x86_64*" \
  pick"lazydocker"
zi load jesseduffield/lazydocker

# Mac only
if [[ $OSTYPE == *darwin* ]]; then
  zi ice \
    as"program" \
    from"gh-r" \
    bpick"*darwin_amd64.zip" \
    pick"Flycut"
  zi load TermiT/Flycut
fi
