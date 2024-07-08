#!/usr/bin/env bash

set -eu

function msg {
  echo -e "\n$1"
}

packages=(
  build-essential gcc clang make cmake ninja-build gettext
  bash-completion curl wget unrar unzip htop eza fzf chafa ripgrep fd-find xclip
  python3 python3-dev python3-pip python3-venv python3-pynvim
  default-jdk
  rustc cargo
  ubuntu-restricted-extras
  flatpak plasma-discover-backend-flatpak
  kitty
  tlp tlp-rdw smartmontools
  tmux stow
  fcitx5-unikey
)

msg "Updating system..."
sudo apt update -y && sudo apt upgrade -y

msg "Removing snap..."
snap remove firefox
snap remove gtk-common-themes
snap remove snapd-desktop-integration
snap remove snap-store
snap remove firmware-updater
snap remove gnome-42-2204
snap remove core22
snap remove bare
snap remove snapd

sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd
sudo apt purge snapd -y
sudo apt-mark hold snapd

rm -rf ~/snap/
sudo cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

msg "Installing base packages..."
sudo apt install -y ${packages[@]}

msg "Configuring system services..."
sudo systemctl enable tlp
sudo systemctl mask power-profiles-daemon.service
sudo systemctl disable bluetooth
sudo systemctl disable cups
sudo systemctl disable NetworkManager-wait-online.service

msg "Setting up flatpak..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

msg "Creating symlinks..."
stow .

msg "Cleaning up system..."
sudo apt autoclean
sudo apt clean
sudo apt autoremove

msg "Manually install: nvm, neovim"
