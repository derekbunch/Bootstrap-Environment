# Install Homebrew if Mac
if [[ "$OSTYPE" == "darwin"* ]]
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # thefuck
  brew install zsh
  brew install thefuck
elif [[ "$OSTYPE" == "linux-gnu"* ]]
  then
  is_amazon_linux=$(hostnamectl | grep 'Amazon' | wc -l)
  if (( $is_amazon_linux == 1 ))
    then
      sudo yum install zsh
    else
      sudo apt-get install zsh
  fi
fi

# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
if test -f ~/.zshrc
then
  mv ~/.zshrc ~/.zshrc.orig
fi

while true; do
    read -p "Is this a work device? (y/n): " config_version
    case $config_version in
        [Yy]* ) export CONFIG_VERSION='work-config'; exit;;
        * )  export CONFIG_VERSION='personal-config'; exit;;
    esac
done

ln .zshrc ~/.zshrc
chsh -s /bin/zsh
