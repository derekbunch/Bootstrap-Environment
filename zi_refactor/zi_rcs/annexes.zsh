## ANNEXES
# z-shell/z-a-meta-plugins
zi light z-shell/z-a-meta-plugins

# https://wiki.zshell.dev/ecosystem/annexes/meta-plugins#@annexes
zi light-mode for \
  skip'submods test' @annexes+ \
  @romkatv \
  @sharkdp \
  @z-shell \
  @zsh-users+fast \
  skip'tig' @ext-git

# # rust-lang/rustup
# # Installation of Rust compiler environment via the z-a-rust annex
zi lucid wait'1' rustup \
  id-as'rust' \
  as'null' \
  sbin'bin/*' \
  atload="[[ ! -f ${ZI[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall rust; \
  export CARGO_HOME=\$PWD RUSTUP_HOME=\$PWD/rustup" \
  for \
  z-shell/0

# # RIPGREP
# This doesnt work because the shim tries to call ripgrep, which doesnt exist (rg)
# zi ice rustup \
#   id-as'ripgrep' \
#   cargo'!ripgrep -> rg'
# zi load z-shell/0
zi ice rustup \
  id-as'ripgrep' \
  cargo'!ripgrep' \
  as'command' \
  pick"bin/rg"
zi load z-shell/0

# # eza
zi ice rustup \
  id-as'eza' \
  cargo'!eza'
zi load z-shell/0
# atload"[[ ! -f ${ZI[COMPLETIONS_DIR]}/_eza ]] && zi creinstall eza"

# #	marlonrichert/zsh-autocomplete
# # z-shell/zzcomplete
zi wait'1' for \
  zzcomplete #autocomplete
