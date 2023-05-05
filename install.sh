#!/usr/bin/env bash

sudo dnf update -y
sudo dnf -y install @base-x xterm xsetroot; # xorg
sudo dnf -y install git stow make sddm;

pushd $HOME

git clone https://github.com/torijcarlos/.dotfiles 

pushd $HOME/.dotfiles

make setup
