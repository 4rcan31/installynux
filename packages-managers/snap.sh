#!/bin/bash
#
# Install snap packages manager
# By: 4rcan31
#
# Requirements: Have an Arch Linux-based distribution installed

function info {
    echo -e "\e[1;34m[INFO]\e[0m $1"
}

function error {
    echo -e "\e[1;31m[ERROR]\e[0m $1"
    exit 1
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   error "This script must be run as root"
fi

info "Creating temporary directory"
cd / || error "Failed to change to root directory"
mkdir -p temp || error "Failed to create temporary directory"
cd temp || error "Failed to change to temporary directory"

info "Cloning snapd repository from AUR"
git clone https://aur.archlinux.org/snapd.git || error "Failed to clone snapd repository"
cd snapd || error "Failed to change to snapd directory"

info "Building and installing snapd"
makepkg -si || error "Failed to build and install snapd"

info "Enabling and starting snapd socket"
sudo systemctl enable --now snapd.socket || error "Failed to enable snapd socket"
systemctl enable --now snapd.apparmor || error "Faild to enable service"

info "Cleaning up temporary files"
cd / || error "Failed to change to root directory"
rm -rf /temp/snapd || error "Failed to remove temporary snapd directory"

info "Snapd installation completed successfully"
