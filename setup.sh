#!/bin/bash

rm ~/.zshrc
rm ~/.tmux.conf
rm ~/.vimrc
rm ~/.gitconfig

ln ./zsh/zshrc      ~/.zshrc
ln ./tmux/tmux.conf ~/.tmux.conf
ln ./vim/vimrc      ~/.vimrc
ln ./git/gitconfig  ~/.gitconfig

if [ !  ~/antigen.zsh ] 
then
    curl -L git.io/antigen > ~/antigen.zsh
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
