#!/bin/bash

## This script installs and configures the packages needed for my setup.
## It does not install a bootloader.



echo "Install packages from official repos (y/n)?"
read input
if [ "$input" = 'y' ]; then
  sudo pacman -S xorg xorg-xinit xorg-backlight xf86-video-intel xorg-xfontsel xwallpaper picom                # xorg stuff
  sudo pacman -S qtile                                                                                         # qtile
  sudo pacman -S zathura zathura-pdf-poppler dmenu neovim alacritty python python-pip sxiv thunderbird cups    # useful
  sudo pacman -S firefox firefox-developer-edition                                                             # browser
  sudo pacman -S alsa-utils pulseaudio pulseaudio-alsa pavucontrol pulsemixer                                  # sound
  sudo pacman -S texlive-most pandoc                                                                           # latex
  sudo pacman -S docker docker-compose                                                                         # devops tools
  sudo pacman -S openssh htop lsof tmux gparted                                                                # useful admin tools
  sudo pacman -S net-tools iproute2 nmap                                                                       # useful network tools
  sudo pacman -S gcc gdb base-devel linux-headers                                                              # kernel/low-level development
  sudo pacman -S lm_sensors psensor xsensors                                                                   # lm_sensors
fi
echo ""
echo ""
echo ""








echo "Copy directories to ~/.config (y/n)?"
read input
if [ "$input" = 'y' ]; then
  mkdir -p $HOME/.config
  for d in dotfiles/config/*/; do
    cp -r $d $HOME/.config
  done
fi
echo ""
echo ""
echo ""




echo "Copy directories to ~/.local (y/n)?"
read input
if [ "$input" = 'y' ]; then
mkdir -p $HOME/.local
  for d in dotfiles/local/*/; do
    cp -r $d $HOME/.local
  done
fi
echo ""
echo ""
echo ""



echo "Copy .bashrc and .xinitrc to ~ (y/n)?"
read input
if [ "$input" = 'y' ]; then
  for d in dotfiles/*/; do
    cp dotfiles/xinitrc $HOME/.xinitrc
    cp dotfiles/bashrc $HOME/.bashrc
  done
fi
echo ""
echo ""
echo ""




echo "Clone slock source to ~/.config/slock (y/n)?"
read input
if [ "$input" = 'y' ]; then
  mkdir $HOME/slock
  git clone https://git.suckless.org/slock $HOME/.config/slock/
fi
echo ""
echo ""
echo ""












cd ~




echo "Install Yay (y/n)?"
read input
if [ "$input" = 'y' ]; then
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si
  cd ..
  rm -rf yay-bin
fi
echo ""
echo ""
echo ""











echo "Set up packer for nvim (y/n)?"
read input
if [ "$input" = 'y' ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
   ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi
echo ""
echo ""
echo ""





echo "Set keymap (y/n)?"
read input
if [ "$input" = 'y' ]; then
  # Set v-console and X11 keymaps
  sudo echo "KEYMAP=uk" >> /etc/vconsole.conf
  sudo localectl set-x11-keymap gb
fi
echo ""
echo ""
echo ""





echo "Set up lm-sensors (y/n)?"
read input
if [ "$input" = 'y' ]; then
  sudo sensors-detect
fi





clear
echo ""
echo "Edit slock so it locks my user's session."
echo ""
echo "If xbacklight does not work, edit /etc/X11/xorg.conf.d/20-intel.conf"
echo "https://wiki.archlinux.org/title/Backlight#xbacklight"
echo ""
