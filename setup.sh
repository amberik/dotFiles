#!/bin/bash


function updateConfigFile () {
    sourceConfigFile=$1 
    configFile=$2
    echo "Remove the file: $configFile"
    rm "$configFile"
    echo "Create link $sourceConfigFile => $configFile"
    ln "$sourceConfigFile" "$configFile"
}

updateConfigFile ./zsh/zshrc ~/.zshrc
updateConfigFile ./tmux/tmux.conf ~/.tmux.conf
updateConfigFile ./vim/vimrc  ~/.vimrc
updateConfigFile ./git/gitconfig ~/.gitconfig

if [ !  ~/antigen.zsh ] 
then
    curl -L git.io/antigen > ~/antigen.zsh
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
