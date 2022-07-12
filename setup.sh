#!/bin/bash

## This script installs and configures the packages needed for my setup.
## It does not install a bootloader.

# xorg stuff
sudo pacman -S xorg xorg-xinit xorg-backlight xf86-video-intel xorg-xfontsel xwallpaper picom

# xmonad
sudo pacman -S xmonad xmonad-contrib xmobar

# qtile
sudo pacman -S qtile

# useful
sudo pacman -S zathura zathura-pdf-poppler dmenu neovim alacritty python python-pip sxiv thunderbird cups

# browser
sudo pacman -S firefox firefox-developer-edition

# sound
sudo pacman -S alsa-utils pulseaudio pulseaudio-alsa pavucontrol pulsemixer

# latex
sudo pacman -S texlive-most pandoc

# devops tools
sudo pacman -S docker docker-compose

# useful admin tools
sudo pacman -S openssh htop lsof tmux gparted

# useful network tools
sudo pacman -S net-tools iproute2 nmap

# kernel/low-level development
sudo pacman -S gcc gdb base-devel linux-headers

# lm_sensors
sudo pacman -S lm_sensors psensor xsensors



cd ~


# install yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..




# clone my dotfiles repo
git clone https://github.com/mattjoman/dotfiles.git ~

mkdir -p /home/$USER/.config
cp -r /home/$USER/dotfiles/config /home/$USER/.config/
cp -r /home/$USER/dotfiles/local /home/$USER/.local/
cp /home/$USER/dotfiles/xinitrc /home/$USER/.xinitrc
cp /home/$USER/dotfiles/bashrc /home/$USER/.bashrc



# clone slock repo
mkdir /home/$USER/slock
git clone https://git.suckless.org/slock /home/$USER/.config/slock/



# create symlinks to the xmonad directory and xmobarrc file
cd /home/$USER/
ln -s .config/xmonad .xmonad
ln -s .config/xmonad/xmobarrc .xmobarrc




# set up packer for neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Set v-console and X11 keymaps
sudo echo "KEYMAP=uk" >> /etc/vconsole.conf
sudo localectl set-x11-keymap gb

# Set up lm_sensors
sudo sensors-detect

clear
echo ""
echo "Edit slock so it locks my user's session."
echo ""
echo "If xbacklight does not work, edit /etc/X11/xorg.conf.d/20-intel.conf"
echo "https://wiki.archlinux.org/title/Backlight#xbacklight"
echo ""
