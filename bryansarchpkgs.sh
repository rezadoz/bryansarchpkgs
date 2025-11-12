#!/usr/bin/env bash

# Arch package dump script
echo -e "Welcome to bryan's arch package dump. We are going to:\n- install yay if needed\n- install bryan's packages"
sleep 1
echo -e "make sure you have multilib enabled in your `/etc/pacman.conf` cause I don't feel like adding that function"
sleep 1
echo -e "also you might not even need to enable multilib, but im pretty sure it's required for the gaming packages idk"
sleep 1

# Install yay if not already present
if ! command -v yay &>/dev/null; then
    echo "[INFO] yay not found. Installing..."
    cd /tmp/ || exit 1
    sudo pacman -Syu --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit 1
    makepkg -si --noconfirm
else
    echo "[INFO] yay already installed."
fi

# Main package installation
# ----------------------------------------------------------
# 
# NOTE: installs AMD CPU optimizations and NVIDIA GPU driver
# 
# ----------------------------------------------------------

echo "[INFO] Installing main packages..."
yay -Syu --needed --noconfirm \
    amd-ucode ntfs-3g nvidia feh geeqie gparted partiotionmanager qdirstat ark dolphin \
    gimp mpv-full-git nightpdf obs-studio openssh qbittorrent vlc waterfox-bin kalm \
    kate zanshin fish zsh asciiquarium astroterm btop catnip cava cmatrix discordo-git \
    fastfetch-git figlet figlet-fonts figlet-fonts-extra fireplace-git gotop iftop \
    jnettop nload nnn pipes.js-git tenki uwufetch zenith bat dysk fkill tree vnstat wego \
    zram-generator rsync epr-git kew neovim ranger yazi tldr++ cool-retro-term konsole \
    tmux jellyfin-server kvantum powerlevel10k cozette-otb dina-font \
    ttf-bigblueterminal-nerd ttf-daddytime-mono-nerd ttf-fantasque-nerd ttf-iosevka-nerd \
    ttf-iosevkaterm-nerd ttf-monoid-nerd ttf-uzura-font

# Situational package prompt
read -rp $'\nInstall situational packages? "monero-gui mullvad-vpn nginx torbrowser-launcher"\nY/n: ' situational
if [[ "$situational" =~ ^[Yy]?$ ]]; then
    yay -Syu --needed --noconfirm monero-gui mullvad-vpn nginx torbrowser-launcher
fi

# Gaming package prompt
read -rp $'\nInstall gaming packages? "retroarch steam vapour wine winetricks umu-launcher"\nY/n: ' gaming
if [[ "$gaming" =~ ^[Yy]?$ ]]; then
    yay -Syu --needed --noconfirm steam vapour wine winetricks umu-launcher
fi

echo -e "\n[INFO] All done."
