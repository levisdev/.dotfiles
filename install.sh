#!/usr/bin/env bash

DOTFILES_DIR="$HOME/.dotfiles"

CONFIG_FILES=$(find $DOTFILES_DIR -mindepth 1 -maxdepth 2 | 
               grep -vEw ".git|install.sh|.config$" |
               sed "s|$DOTFILES_DIR/||")

find ~ -xtype l -delete

for config in $CONFIG_FILES; do
    rm -rf $HOME/$config
    ln -sf $DOTFILES_DIR/$config $HOME/$config
done
