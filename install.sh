#!/bin/sh

echo "Updating packages"
sudo pacman -Syu

echo "Installing paru"
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -si && cd ..

# Make a backup of previous config(if there is one)
mkdir ~/config_backup
cp -r ~/.config ~/config_backup
cp ~/.xinitrc ~/config_backup
cp ~/.zshrc ~/config_backup
cp ~/.Xresources ~/config_backup

# Copy config files
cp --parents -r .local/bin ~
cp --parents -r .local/share/icons/dunst ~
cp -r .config ~
mkdir -p ~/Media/Images/wallpapers
mkdir ~/Media/Images/screenshots
cp wallpaper.png ~/Pictures/wallpapers/
cp .xinitrc ~
cp .zshrc ~
cp .Xresources ~

echo "Installing needed packages"
paru -S qtile alacritty rofi ranger ueberzug \
	zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting \
	picom-ibhagwan-git ttf-material-design-icons-desktop-git \
	ttf-mononoki-nerd firefox doas man htop \
	xorg-xsetroot hsetroot dunst sxiv libnotify \
	zathura mpv shotgun hacksaw brillo polkit

# Give root permisions with doas
echo "permit ${USER} as root" | sudo tee /etc/doas.conf

echo "Setting zsh as default shell"
chsh -s /usr/bin/zsh

echo "Installing starship prompt"
curl -sS https://starship.rs/install.sh | sh
