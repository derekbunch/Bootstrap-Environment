echo; echo 'Checking OS version'
if [[ "$OSTYPE" == "darwin"* ]]
then
  echo; echo 'OS is OS X'
  echo; echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo; echo "Installing zsh"
  brew install zsh
  echo; echo "Installing thefuck"
  brew install thefuck
elif [[ "$OSTYPE" == "linux-gnu"* ]]
  then
  is_amazon_linux=$(hostnamectl | grep 'Amazon' | wc -l)
  if (( $is_amazon_linux == 1 ))
    then
      echo; echo "OS is Amazon Linux"
      echo; echo "Installing chsh"
      sudo yum -y install util-linux-user
      echo; echo "Installing zsh"
      sudo yum -y install zsh
    else
      echo; echo "OS is Linux"
      echo; echo "Installing zsh"
      sudo apt-get install zsh -y
  fi
fi

# Install OhMyZsh
echo; echo "Installing OhMyZsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Zsh Syntax Highlighting
echo; echo "Installing Syntax Highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh Autosuggestions
echo; echo "Installing Autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Zsh Sync
echo; echo "Installing Zsh Sync"
git clone https://github.com/vickyliin/zsh-sync.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-sync

# Powerlevel10k theme
echo; echo "Installing Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# vi-mode
echo; echo "Installing vi-mode"
git clone --depth=1 https://github.com/woefe/vi-mode.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vi-mode.zsh

# Symlink .zshrc
if test -f ~/.zshrc
then
  echo; echo "Renaming existing .zshrc to .zshrc.orig"
  mv ~/.zshrc ~/.zshrc.orig
fi

while true; do
    read -p "Is this a work device? (y/n): " config_version
    case $config_version in
        [Yy]* )
          echo; echo "Using work config"
          export CONFIG_VERSION='work-config';;
        * )
          echo; echo "Using personal config"
          export CONFIG_VERSION='personal-config';;
    esac
done

echo; echo "Linking zshrc"
ln .zshrc ~/.zshrc

echo; echo "Changing shell"
chsh -s $(which zsh)