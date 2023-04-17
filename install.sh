#!/usr/bin/env bash

pushd $HOME

git clone https://github.com/torijcarlos/.dotfiles 

pushd $HOME/.dotfiles

make fedora
make dotfiles-setup
