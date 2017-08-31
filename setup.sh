#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/" 

function updateConfigFile () {
    sourceConfigFile=$1 
    configFile=$2
    echo "Remove the file: $configFile"
    rm "$configFile"
    echo "Create link $DIR$sourceConfigFile => $configFile"
    ln -s $DIR"$sourceConfigFile" "$configFile"
}

updateConfigFile ./zsh/zshrc ~/.zshrc
updateConfigFile ./tmux/tmux.conf ~/.tmux.conf
updateConfigFile ./vim/vimrc  ~/.vimrc
updateConfigFile ./git/gitconfig ~/.gitconfig
ln -s ~/.vim ~/.config/nvim
updateConfigFile ./vim/vimrc ~/.config/nvim/init.vim

if ! [[ -r  ~/antigen.zsh ]]
then
    curl -L git.io/antigen > ~/antigen.zsh
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
