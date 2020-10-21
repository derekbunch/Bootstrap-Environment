# Install Homebrew if Mac
echo 'Checking OS version'
if [[ "$OSTYPE" == "darwin"* ]]
then
  echo 'OS is OS X'
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo "Installing zsh"
  brew install zsh
  echo "Installing thefuck"
  brew install thefuck
elif [[ "$OSTYPE" == "linux-gnu"* ]]
  then
  is_amazon_linux=$(hostnamectl | grep 'Amazon' | wc -l)
  if (( $is_amazon_linux == 1 ))
    then
      echo "OS is Amazon Linux"
      echo "Installing chsh"
      sudo yum -y install util-linux-user
      echo "Installing zsh"
      sudo yum -y install zsh
    else
      echo "OS is Linux"
      echo "Installing zsh"
      sudo apt-get install zsh -y
  fi
fi

# Install OhMyZsh
echo "Installing OhMyZsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Zsh Syntax Highlighting
echo "Installing Syntax Highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh Autosuggestions
echo "Installing Autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Zsh Sync
echo "Installing Zsh Sync"
git clone https://github.com/vickyliin/zsh-sync.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-sync

# Powerlevel10k theme
echo "Installing Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# vi-mode
echo "Installing vi-mode"
git clone --depth=1 https://github.com/woefe/vi-mode.zsh ~/.zsh/vi-mode.zsh

# Symlink .zshrc
if test -f ~/.zshrc
then
  echo "Renaming existing .zshrc to .zshrc.orig"
  mv ~/.zshrc ~/.zshrc.orig
fi

while true; do
    read -p "Is this a work device? (y/n): " config_version
    case $config_version in
        [Yy]* )
          echo "Using work config"
          export CONFIG_VERSION='work-config'
          exit;;
        * )
          echo "Using personal config"
          export CONFIG_VERSION='personal-config'
          exit;;
    esac
done

echo "Linking zshrc"
ln .zshrc ~/.zshrc

echo "Changing shell"
chsh -s $(which zsh)
