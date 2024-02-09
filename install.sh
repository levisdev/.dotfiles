#!/bin/env bash

DOTFILES_DIR=$HOME/.dotfiles

EXCLUDE_CONFIGS=(
    "."
    ".."
    ".git"
    ".config"
    "pacman"
    "install.sh"
    "install.ps1"

    "powershell"
    "windows-terminal"
    "scoop.json"
)

msg() {
  echo -e "\n\033[1m$1\033[0m"
}

pkg_installed() {
	local PKG=$1
	if pacman -Qi $PKG &>/dev/null; then
		return 0
	else
		return 1
	fi
}

clear
cd $DOTFILES_DIR
shopt -s dotglob

msg "Updating system..."
sudo pacman -Syu --noconfirm

if ! pkg_installed yay; then
    msg "Installing yay..."
    git clone https://aur.archlinux.org/yay.git && cd yay
    makepkg -si --noconfirm
    cd .. && rm -rf yay
fi

# msg "Installing package..."
# sudo pacman -S --needed --noconfirm - < ./pacman/pkglist-repo.txt
# for x in $(< ./pacman/pkglist-aur.txt); do yay -S $x --needed --noconfirm; done

msg "Setting system..."
sudo systemctl enable paccache.timer
sudo systemctl enable acpid
sudo envycontrol -s hybrid --rtd3
sudo auto-cpufreq --install
xdg-settings set default-web-browser thorium-browser.desktop

msg "Deleting death symlink..."
find -xtype l -delete

msg "Creating symlink..."
for file in "$DOTFILES_DIR"/*; do
    filename=$(basename "$file")
    if [[ ! "${EXCLUDE_CONFIGS[@]}" =~ "$filename" ]]; then
        rm -rf "$HOME/$filename"
        ln -sf "$file" "$HOME"
    fi
done
for file in "$DOTFILES_DIR/.config/"*; do
    filename=$(basename "$file")
    if [[ ! "${EXCLUDE_CONFIGS[@]}" =~ "$filename" ]]; then
        rm -rf "$HOME/.config/$filename"
        ln -sf "$file" "$HOME/.config/"
    fi
done
