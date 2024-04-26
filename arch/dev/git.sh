#!/bin/bash
#
# Configuration of environment for Git and GitHub Authentication on Arch Linux-based distributions
# By: 4rcan31
#
# Requirements: Have an Arch Linux-based distribution installed
#
# Start of configuration
set -e
echo "Starting configuration for installing Git..."

function git_install() {
    # Installation of Git
    sudo pacman -S --noconfirm git

    # Configuring username and email
    if [ -z "$(git config --global user.email)" ]; then
        read -p "Please provide the email address associated with your Git account: " userEmailInput
        git config --global user.email "$userEmailInput"
    fi

    if [ -z "$(git config --global user.name)" ]; then
        read -p "Please provide your username for Git: " usernameInput
        git config --global user.name "$usernameInput"
    fi

    git config --global credential.helper cache
}

function main() {
    git_install
}
main

echo -e "All set. Now, when Git asks for the username, enter your GitHub username ('$usernameInput'), and when it asks for the password, paste your GitHub token."
