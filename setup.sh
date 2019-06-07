#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/" 

sudo apt -y install python python3 gcc git curl wget ipython python-pip python3-pip neovim ghc tmux zsh fonts-hack silversearcher-ag tree npm
pip2 install neovim ntfy
pip3 install neovim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
if ! [[ -r  ~/antigen.zsh ]]
then
    curl -L git.io/antigen > ~/antigen.zsh
fi

updateConfigFile () {
    sourceConfigFile=$1 
    configFile=$2
    echo "Remove the file: $configFile"
    rm "$configFile"
    echo "Create link $DIR$sourceConfigFile => $configFile"
    ln -s $DIR"$sourceConfigFile" "$configFile"
}

updateConfigFile ./zsh/zshrc ~/.zshrc
touch ~/.zshrc_custom.zsh
updateConfigFile ./tmux/tmux.conf ~/.tmux.conf
updateConfigFile ./vim/vimrc  ~/.vimrc
updateConfigFile ./git/gitconfig ~/.gitconfig
ln -s ~/.vim ~/.config/nvim
updateConfigFile ./vim/vimrc ~/.config/nvim/init.vim

# Haskel 
curl -sSL https://get.haskellstack.org/ | sh
stack install hsimport hdevtools
