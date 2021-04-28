. TermColors.sh
echo; echo -e "${Blue}Checking OS version"
if [[ "$OSTYPE" == "darwin"* ]]
then
  echo; echo -e "${Yellow}OS is OS X"
  echo; echo -e "${Green}Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo; echo -e "${Green}Installing zsh"
  brew install zsh
  echo; echo -e "Changing shell"
  chsh -s $(which zsh)
  echo; echo -e "${Green}Installing exa"
  brew install exa
  echo; echo -e "${Green}Installing thefuck"
  brew install thefuck
  echo; echo -e "${Green}Installing fasd"
  brew install fasd
  echo; echo -e "${Green}Installing jq"
  brew install jq
elif [[ "$OSTYPE" == "linux-gnu"* ]]
  then
  is_amazon_linux=$(hostnamectl | grep 'Amazon' | wc -l)
  if (( $is_amazon_linux == 1 ))
    then
      echo; echo -e "${Yellow}OS is Amazon Linux"
      echo; echo -e "${Green}Installing chsh"
      sudo yum -y install util-linux-user
      echo; echo -e "${Green}Installing zsh"
      sudo yum -y install zsh
      echo; echo -e "${Green}Installing tmux"
      sudo yum -y install tmux
      echo; echo -e "${Green}Installing jq"
      sudo yum -y install jq
      echo; echo -e "${Green}Installing exa"
      curl https://sh.rustup.rs -sSf | sh -s -- -y
      wget -c https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
      unzip exa-linux-x86_64-0.9.0.zip
      sudo mv exa-linux-x86_64 /usr/local/bin/exa
      # echo; echo -e "Changing shell"
      # chsh -s $(which zsh)
    else
      echo; echo -e "${Yellow}OS is Linux"
      echo; echo -e "${Green}Installing zsh"
      sudo apt-get install zsh -y
      echo; echo -e "${Green}Installing tmux"
      sudo apt-get install tmux -y
      echo; echo -e "${Green}Installing jq"
      sudo apt-get install jq -y
      echo; echo -e "Changing shell"
      chsh -s $(which zsh)
      echo; echo -e "${Green}Installing exa"
      sudo apt install exa -y
  fi
fi

# Install OhMyZsh
echo; echo -e "${Green}Installing OhMyZsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Zsh Syntax Highlighting
echo; echo -e "${Green}Installing Syntax Highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh Autosuggestions
echo; echo -e "${Green}Installing Autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Zsh Sync
echo; echo -e "${Green}Installing Zsh Sync"
git clone https://github.com/vickyliin/zsh-sync.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-sync

# vi-mode
echo; echo -e "${Green}Installing vi-mode"
git clone --depth=1 https://github.com/woefe/vi-mode.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vi-mode.zsh

# Powerlevel10k theme
echo; echo -e "${Green}Installing Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo; echo -e "${Green}Installing Z"
curl -sSL https://raw.githubusercontent.com/rupa/z/master/z.sh > ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/z.sh

# fzf
echo; echo -e "${Green}Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-key-bindings --no-update-rc --completion

# vimrc
echo; echo -e "${Green}Installing awesome vimrc"
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

if (( $is_amazon_linux != 1 ))
then
  echo; echo -e "${Green}Installing fasd"
  git clone https://github.com/clvv/fasd.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fasd
  (cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fasd/ && make install)
fi

# Symlink .zshrc
if test -f ~/.zshrc
then
  echo; echo -e "${Blue}Renaming existing .zshrc to .zshrc.orig"
  mv ~/.zshrc ~/.zshrc.orig
fi

# read -p "Is this a work device? (y/n): " config_version
echo; echo -e "${Blue}Is this a work device?"
select yn in "Yes" "No"; do
  case $yn in
      Yes )
        echo; echo -e "${Yellow}Using work config"
        touch work
        aws s3 sync s3://vuka-ingest-manager/code/derek/ /mnt/data/input/scripts
        mkdir /mnt/data/input/new /mnt/data/input/new/csv /mnt/data/input/new/json /mnt/data/input/new/sql /mnt/data/input/new/csv/parsed /mnt/data/input/new/json/parsed /mnt/data/input/new/sql/parsed /mnt/data/input/updates /mnt/data/input/updates/parsed
        break;;
      No )
        echo; echo -e "${Yellow}Using personal config"
        touch personal
        break;;
  esac
done

echo; echo -e "${Blue}Linking zshrc"
ln .zshrc ~/.zshrc
# echo; echo -e "Linking p10k config"
# ln .p10k.zsh ~/.p10k.zsh