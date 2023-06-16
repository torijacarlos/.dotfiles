#!/usr/bin/env bash

sudo dnf update -y
sudo dnf -y install greetd sway; 
sudo dnf -y install git stow make;

sudo systemctl enable greetd;
sudo systemctl set-default graphical.target;

pushd $HOME

git clone https://github.com/torijcarlos/.dotfiles 

pushd $HOME/.dotfiles

make setup
