. .termcolors.sh
echo -e "\n${Bold}${Blue}Checking OS version${end}"
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo -e "\n${Bold}${Yellow}OS is OS X${end}"
  echo -e "\n${Bold}${Green}Installing Homebrew${end}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # Archived
  # echo -e "\n${Bold}${Green}Installing exa${end}"
  # brew install exa
  echo -e "\n${Bold}${Green}Installing eza${end}"
  brew install eza
  echo -e "\n${Bold}${Green}Installing thefuck${end}"
  brew install thefuck
  # Archived
  # echo -e "\n${Bold}${Green}Installing fasd${end}"
  # brew install fasd
  echo -e "\n${Bold}${Green}Installing asdf${end}"
  brew install asdf
  echo -e "\n${Bold}${Green}Installing jq${end}"
  brew install jq
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  is_amazon_linux=$(hostnamectl | grep 'Amazon' | wc -l)
  # echo -e "\n${Bold}${Green}Installing asdf${end}"
  # git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
  if (($is_amazon_linux == 1)); then
    echo -e "\n${Bold}${Yellow}OS is Amazon Linux${end}"
    echo -e "\n${Bold}${Green}Installing chsh${end}"
    sudo yum -y install util-linux-user
    echo -e "\n${Bold}${Green}Installing zsh${end}"
    sudo yum -y install zsh
    echo -e "\n${Bold}${Green}Installing tmux${end}"
    sudo yum -y install tmux
    echo -e "\n${Bold}${Green}Installing jq${end}"
    sudo yum -y install jq
    echo -e "\n${Bold}${Green}Installing exa${end}"
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    wget -c https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
    unzip exa-linux-x86_64-0.9.0.zip
    sudo mv exa-linux-x86_64 /usr/local/bin/exa
    # echo -e "\n${Bold}Changing shell${end}"
    # chsh -s $(which zsh)
  else
    echo -e "\n${Bold}${Yellow}OS is Linux${end}"
    echo -e "\n${Bold}${Green}Installing zsh${end}"
    sudo apt-get install zsh -y
    echo -e "\n${Bold}${Green}Installing tmux${end}"
    sudo apt-get install tmux -y
    echo -e "\n${Bold}${Green}Installing jq${end}"
    sudo apt-get install jq -y
    echo -e "\n${Bold}Changing shell${end}"
    chsh -s $(which zsh)
    echo -e "\n${Bold}${Green}Installing exa${end}"
    sudo apt install exa -y
  fi
fi

# Install OhMyZsh
echo -e "\n${Bold}${Green}Installing OhMyZsh${end}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Zsh Syntax Highlighting
echo -e "\n${Bold}${Green}Installing Syntax Highlighting${end}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh Autosuggestions
echo -e "\n${Bold}${Green}Installing Autosuggestions${end}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Zsh Sync
echo -e "\n${Bold}${Green}Installing Zsh Sync${end}"
git clone https://github.com/vickyliin/zsh-sync.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-sync

# zsh-autoenv
echo -e "\n${Bold}${Green}Installing zsh-autoenv${end}"
git clone https://github.com/Tarrasch/zsh-autoenv ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autoenv

echo -e "\n${Bold}${Green}Installing zsh-autopair${end}"
git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autopair

# vi-mode
echo -e "\n${Bold}${Green}Installing vi-mode${end}"
git clone --depth=1 https://github.com/woefe/vi-mode.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vi-mode.zsh

# Powerlevel10k theme
echo -e "\n${Bold}${Green}Installing Powerlevel10k${end}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Z
echo -e "\n${Bold}${Green}Installing Z${end}"
curl -sSL https://raw.githubusercontent.com/rupa/z/master/z.sh >${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/z.sh

# Tmux Plugin Manager
echo -e "\n${Bold}${Green}Installing Tmux Plugin Manager${end}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln .tmux.conf ~/.tmux.conf

# fzf
echo -e "\n${Bold}${Green}Installing fzf${end}"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-key-bindings --no-update-rc --completion

# interactive kube exec
echo -e "\n${Bold}${Green}Installing kube iexec${end}"
local TAG=$(curl -s https://api.github.com/repos/gabeduke/kubectl-iexec/releases/latest | jq -r .tag_name)
curl -LO https://github.com/gabeduke/kubectl-iexec/releases/download/${TAG}/kubectl-iexec_${TAG}_Darwin_x86_64.tar.gz
mkdir -p /tmp/kubectl-iexec
tar -xzvf kubectl-iexec_${TAG}_Darwin_x86_64.tar.gz -C /tmp/kubectl-iexec
chmod +x /tmp/kubectl-iexec/kubectl-iexec
sudo mv /tmp/kubectl-iexec/kubectl-iexec /usr/local/bin

# vimrc
echo -e "\n${Bold}${Green}Installing awesome vimrc${end}"
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# vim gruvbox
echo -e "\n${Bold}${Yellow}Changing vim theme to gruvbox${end}"
mkdir ~/.vim/colors
git clone https://github.com/morhetz/gruvbox.git ~/.vim/colors
echo "colorscheme gruvbox" >~/.vim_runtime/my_plugins/gruvbox.vim

# Install iTerm Shell Integration
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | zsh

if (($is_amazon_linux != 1)); then
  echo -e "\n${Bold}${Green}Installing fasd${end}"
  git clone https://github.com/clvv/fasd.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fasd
  (cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fasd/ && make install)
fi

# read -p "Is this a work device? (y/n): " config_version
echo -e "\n${Bold}${Blue}Is this a work device?${end}"
select yn in "Yes" "No"; do
  case $yn in
  Yes)
    echo -e "\n${Bold}${Yellow}Using work config${end}"
    touch work
    echo -e "\n${Bold}${Blue}Linking tmuxrc${end}"
    echo -e "\n${Bold}${Blue}Linking workspace config${end}"
    ln -s ~/Bootstrap-Environment/work-config/myparsing.code-workspace /mnt/data/input/
    git clone "https://derekbunch:$gh_token@github.com/derekbunch/parsing_scripts.git" /mnt/data/input/scripts
    mkdir /mnt/data/input/parsed
    break
    ;;
  No)
    echo -e "\n${Bold}${Yellow}Using personal config${end}"
    touch personal
    echo -e "\n${Bold}${Blue}Linking tmuxrc${end}"
    break
    ;;
  esac
done

# Hardlink .zshrc
if test -f ~/.zshrc; then
  echo -e "\n${Bold}${Blue}Renaming existing .zshrc to .zshrc.orig${end}"
  mv ~/.zshrc ~/.zshrc.orig
fi
echo -e "\n${Bold}${Blue}Linking zshrc${end}"
ln ~/Bootstrap-Environment/.zshrc ~/.zshrc
# echo -e "\n${Bold}Linking p10k config${end}"
# ln .p10k.zsh ~/.p10k.zsh
