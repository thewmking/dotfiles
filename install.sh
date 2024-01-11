#!/bin/sh
# Software for provisioning up a Macbook Pro and all that good stuff.
# Inspired by & derived from 
#  - komputer-maschine by Lauren Dorman (https://github.com/laurendorman/komputer-maschine)
#  - Iheanyi Ekechukwu (https://github.com/iheanyi/dotfiles)
#  - bradp (https://gist.github.com/bradp/bea76b16d3325f5c47d4)

brew_install() {
  echo "attempting install of $@"
  if test ! $(brew list | grep $package); then
    echo "installing $@"
    brew install "$package"
  else
    echo "$package already installed, gonna skip that."
  fi
}

cask_install() {
  echo "attempting cask install of $@"
  if test ! $(brew list --cask | grep $application); then
    echo "installing $@"
    brew install --cask "$application"
  else
    echo "$application cask already installed, gonna skip that."
  fi
}

cd

echo "Installing xcode-stuff"
xcode-select --install

# Install Homebrew
which -s brew
if [[ $? != 0 ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "homebrew already installed"
fi

# Install oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
  echo "oh-my-zsh is already installed"
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

packages=(
  bat
  wget
  curl
  git
  libyaml
  postgresql
  yarn
  font-monaspace
  tldr
)
  
for package in ${packages[@]}; do
  brew_install $package
done

# Install applications
applications=(
  1password
  arc
  raycast
  firefox
  iterm2
  slack
  pgadmin4
  spotify
  obsidian
  notion
  visual-studio-code
  zoom
  postman
)

#docker

for application in ${applications[@]}; do
  cask_install $application
done

echo 'sleeping 5'
sleep
echo 'done sleeping'


if test -d /Users/mk/.asdf; then
  echo "asdf installed, skipping config"
else
  git clone https://github.com/excid3/asdf.git ~/.asdf
  echo '. "$HOME/.asdf/asdf.sh"' >> ~/.zshrc
  echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.zshrc
  echo 'legacy_version_file = yes' >> ~/.asdfrc
  exec $SHELL

  asdf plugin add ruby
  asdf plugin add nodejs

  asdf install ruby 3.3.0
  asdf global ruby 3.3.0

  gem update --system

  which ruby
  ruby -v

  asdf install nodejs 20.10.0
  asdf global nodejs 20.10.0

  which node
  node -v
fi

echo "setting git config"
git config --global color.ui true
git config --global user.name "<your name here>"
git config --global user.email "<your email here>"
git config --list

echo "Creating an SSH key for you..."
ssh-keygen -t rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"

echo "copying zshrc config"
cp .zshrc ~

echo "setting defaults"

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

#"Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

#"Disable 'natural' (Lion-style) scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false