#!/usr/bin/env bash

mkdir ~/.config

ln -sf ~/.dotfiles/.gitconfig ~
ln -sf ~/.dotfiles/.bashrc ~
ln -sf ~/.dotfiles/.config/nvim ~/.config
ln -sf ~/.dotfiles/.config/starship.toml ~/.config/
