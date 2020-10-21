# Install Homebrew if Mac
if [[ "$OSTYPE" == "darwin"* ]]
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # thefuck
  brew install thefuck
fi

# Install OhMyZsh
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Zsh Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Zsh Sync
git clone https://github.com/vickyliin/zsh-sync.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-sync

# Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# vi-mode
git clone --depth=1 https://github.com/woefe/vi-mode.zsh ~/.zsh/vi-mode.zsh

# Symlink .zshrc
if [ test -f ~/.zshrc ]
then
  mv ~/.zshrc ~/.zshrc.orig
fi

readonly config_version=${1:?"Is this a work device? (y/n): "}
if [ $config_version == 'y' ]
then
  export CONFIG_VERSION='work-config'
else
  export CONFIG_VERSION='personal-config'
fi

ln .zshrc ~/.zshrc
chsh -s /bin/zsh
