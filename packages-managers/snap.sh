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

# Check if running as root and exit if it is
if [[ $EUID -eq 0 ]]; then
   error "This script should not be run as root. Please run as a regular user."
fi

info "Creating temporary directory"
TEMP_DIR=$(mktemp -d) || error "Failed to create temporary directory"

info "Cloning snapd repository from AUR"
git clone https://aur.archlinux.org/snapd.git "$TEMP_DIR/snapd" || error "Failed to clone snapd repository"

info "Building snapd"
cd "$TEMP_DIR/snapd" || error "Failed to change to snapd directory"
makepkg -si --noconfirm || error "Failed to build and install snapd"

info "Enabling and starting snapd socket"
sudo systemctl enable --now snapd.socket || error "Failed to enable snapd socket"
sudo systemctl enable --now snapd.apparmor || error "Failed to enable snapd.apparmor"

info "Cleaning up temporary files"
rm -rf "$TEMP_DIR" || error "Failed to remove temporary directory"

# Display the apps in start laucher
ln -st ~/.local/share/applications /var/lib/snapd/desktop/applications/*.desktop 2>/dev/null
info "Snapd installation completed successfully"
