# echo; echo "Changing shell"
# chsh -s $(which bash)

echo; echo "Checking OS version"
if [[ "$OSTYPE" == "darwin"* ]]
then
  echo; echo "OS is OS X"
  echo; echo "Removing zsh"
  brew remove zsh
  echo; echo "Removing thefuck"
  brew remove thefuck
  echo; echo "Removing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]
  then
  is_amazon_linux=$(hostnamectl | grep 'Amazon' | wc -l)
  if (( $is_amazon_linux == 1 ))
    then
      echo; echo "OS is Amazon Linux"
      echo; echo "Removing chsh"
      sudo yum -y remove util-linux-user
      echo; echo "Removing zsh"
      sudo yum -y remove zsh
    else
      echo; echo "OS is Linux"
      echo; echo "Removing zsh"
      sudo apt-get remove zsh -y
  fi
fi

# Install OhMyZsh
echo; echo "Removing OhMyZsh and plugins"
rm -rf $HOME/.oh-my-zsh

echo; echo "Removing zshrc"
rm $HOME/.zshrc
