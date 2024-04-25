#!/bin/bash
#
# Configuration of environment for Docker and Docker Compose on Arch Linux-based distributions
# By: Jose and 4rcan31
#
# Requirements: Have an Arch Linux-based distribution installed
#
# Start of configuration
set -e
echo "Starting configuration for install docker and docker compose..."

function pre_install() {
    # Update repositories and install dependencies
    sudo pacman -Sy --noconfirm
    sudo pacman -S --noconfirm curl unzip wget
}

function docker_docker_compose_install() {
    # Installation of Docker and Docker Compose
    sudo pacman -S --noconfirm docker docker-compose

    # Add the user to the docker group if the group already exists
    sudo groupadd docker || true
    sudo usermod -aG docker $USER
    # Set permissions on the .docker directory
    if [ "$(id -u)" -eq 0 ]; then
        # If running as root
        sudo mkdir -p /root/.docker
        sudo chown -R root:root /root/.docker
        sudo chmod -R 700 /root/.docker
    else
        # If running as another user
        sudo mkdir -p ~/.docker
        sudo chown -R "$USER":"$USER" ~/.docker || true
        sudo chmod -R 700 ~/.docker
    fi
    sudo systemctl enable docker.service
    sudo systemctl start docker.service
}

function main() {
    pre_install
    docker_docker_compose_install
}
main

echo -e "\n\tInstallation finished! It is recommended to restart the system to apply the changes."
