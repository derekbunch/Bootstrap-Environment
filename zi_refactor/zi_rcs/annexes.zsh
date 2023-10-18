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

# rust-lang/rustup
# Installation of Rust compiler environment via the z-a-rust annex
zi lucid wait'1' rustup \
  id-as'rust' \
  as'null' \
  sbin'bin/*' \
  atload="[[ ! -f ${ZI[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall rust; \
  export CARGO_HOME=\$PWD RUSTUP_HOME=\$PWD/rustup" \
  for \
  z-shell/0

# # RIPGREP
zi ice rustup \
  id-as'ripgrep' \
  cargo"!ripgrep -> rg"
zi load null

# eza
zi ice rustup \
  id-as'eza' \
  cargo"!eza"
zi load null
# atload"[[ ! -f ${ZI[COMPLETIONS_DIR]}/_eza ]] && zi creinstall eza"

#	marlonrichert/zsh-autocomplete
# z-shell/zzcomplete
zi lucid wait'1' for \
  autocomplete \
  zzcomplete
