. TermColors.sh
echo; echo -e "${Bold}${Blue}Checking OS version${end}"
if [[ "$OSTYPE" == "darwin"* ]]
then
  echo; echo -e "${Bold}${Yellow}OS is OS X${end}"
  echo; echo -e "${Bold}${Green}Installing Homebrew${end}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)${end}"
  echo; echo -e "${Bold}${Green}Installing zsh${end}"
  brew install zsh
  echo; echo -e "${Bold}${Green}Changing shell${end}"
  chsh -s $(which zsh)
  echo; echo -e "${Bold}${Green}Installing exa${end}"
  brew install exa
  echo; echo -e "${Bold}${Green}Installing thefuck${end}"
  brew install thefuck
  echo; echo -e "${Bold}${Green}Installing fasd${end}"
  brew install fasd
  echo; echo -e "${Bold}${Green}Installing jq${end}"
  brew install jq
elif [[ "$OSTYPE" == "linux-gnu"* ]]
  then
  is_amazon_linux=$(hostnamectl | grep 'Amazon' | wc -l)
  if (( $is_amazon_linux == 1 ))
    then
      echo; echo -e "${Bold}${Yellow}OS is Amazon Linux${end}"
      echo; echo -e "${Bold}${Green}Installing chsh${end}"
      sudo yum -y install util-linux-user
      echo; echo -e "${Bold}${Green}Installing zsh${end}"
      sudo yum -y install zsh
      echo; echo -e "${Bold}${Green}Installing tmux${end}"
      sudo yum -y install tmux
      echo; echo -e "${Bold}${Green}Installing jq${end}"
      sudo yum -y install jq
      echo; echo -e "${Bold}${Green}Installing exa${end}"
      curl https://sh.rustup.rs -sSf | sh -s -- -y
      wget -c https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
      unzip exa-linux-x86_64-0.9.0.zip
      sudo mv exa-linux-x86_64 /usr/local/bin/exa
      # echo; echo -e "${Bold}Changing shell${end}"
      # chsh -s $(which zsh)
    else
      echo; echo -e "${Bold}${Yellow}OS is Linux${end}"
      echo; echo -e "${Bold}${Green}Installing zsh${end}"
      sudo apt-get install zsh -y
      echo; echo -e "${Bold}${Green}Installing tmux${end}"
      sudo apt-get install tmux -y
      echo; echo -e "${Bold}${Green}Installing jq${end}"
      sudo apt-get install jq -y
      echo; echo -e "${Bold}Changing shell${end}"
      chsh -s $(which zsh)
      echo; echo -e "${Bold}${Green}Installing exa${end}"
      sudo apt install exa -y
  fi
fi

# Install OhMyZsh
echo; echo -e "${Bold}${Green}Installing OhMyZsh${end}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Zsh Syntax Highlighting
echo; echo -e "${Bold}${Green}Installing Syntax Highlighting${end}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh Autosuggestions
echo; echo -e "${Bold}${Green}Installing Autosuggestions${end}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Zsh Sync
echo; echo -e "${Bold}${Green}Installing Zsh Sync${end}"
git clone https://github.com/vickyliin/zsh-sync.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-sync

# vi-mode
echo; echo -e "${Bold}${Green}Installing vi-mode${end}"
git clone --depth=1 https://github.com/woefe/vi-mode.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vi-mode.zsh

# Powerlevel10k theme
echo; echo -e "${Bold}${Green}Installing Powerlevel10k${end}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo; echo -e "${Bold}${Green}Installing Z${end}"
curl -sSL https://raw.githubusercontent.com/rupa/z/master/z.sh > ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/z.sh

# fzf
echo; echo -e "${Bold}${Green}Installing fzf${end}"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-key-bindings --no-update-rc --completion

# vimrc
echo; echo -e "${Bold}${Green}Installing awesome vimrc${end}"
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

if (( $is_amazon_linux != 1 ))
then
  echo; echo -e "${Bold}${Green}Installing fasd${end}"
  git clone https://github.com/clvv/fasd.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fasd
  (cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fasd/ && make install)
fi

# Symlink .zshrc
if test -f ~/.zshrc
then
  echo; echo -e "${Bold}${Blue}Renaming existing .zshrc to .zshrc.orig${end}"
  mv ~/.zshrc ~/.zshrc.orig
fi

# read -p "Is this a work device? (y/n): " config_version
echo; echo -e "${Bold}${Blue}Is this a work device?${end}"
select yn in "Yes" "No"; do
  case $yn in
      Yes )
        echo; echo -e "${Bold}${Yellow}Using work config${end}"
        touch work
        aws s3 sync s3://vuka-ingest-manager/code/derek/ /mnt/data/input/scripts
        mkdir /mnt/data/input/new /mnt/data/input/new/csv /mnt/data/input/new/json /mnt/data/input/new/sql /mnt/data/input/new/csv/parsed /mnt/data/input/new/json/parsed /mnt/data/input/new/sql/parsed /mnt/data/input/updates /mnt/data/input/updates/parsed
        break;;
      No )
        echo; echo -e "${Bold}${Yellow}Using personal config${end}"
        touch personal
        break;;
  esac
done

echo; echo -e "${Bold}${Blue}Linking zshrc${end}"
ln .zshrc ~/.zshrc
# echo; echo -e "${Bold}Linking p10k config${end}"
# ln .p10k.zsh ~/.p10k.zsh