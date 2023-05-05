#!/usr/bin/env bash

sudo dnf update -y
sudo dnf -y install @base-x xterm xsetroot; # xorg
sudo dnf -y install git stow make sddm;

sudo systemctl enable sddm;
sudo systemctl set-default graphical.target;

pushd $HOME

git clone https://github.com/torijcarlos/.dotfiles 

pushd $HOME/.dotfiles

make setup
