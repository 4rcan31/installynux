#!/bin/bash
#
# Install phpbrew, php version manager
# By: 4rcan31
#
# Requirements: Have an Arch Linux-based distribution installed
#
# Start of configuration

sudo pacman -S openssl-1.1 php base-devel libxslt pkg-config --noconfirm
sudo pacman -S base-devel libxml2 curl libjpeg-turbo libpng libxpm icu freetype2 \
libmcrypt readline tidy libxslt libzip --noconfirm
sudo pacman -S php php-pdo php-mysql --noconfirm

curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
chmod +x phpbrew.phar

# Move phpbrew.phar to somewhere can be found by your $PATH
sudo mv phpbrew.phar /usr/local/bin/phpbrew
phpbrew init

# I assume you're using bash
echo "[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc" >> ~/.bashrc

# For the first-time installation, you don't have phpbrew shell function yet.
source ~/.phpbrew/bashrc

# Fetch the release list from official php site...
phpbrew update

# List available releases
phpbrew known

# List available variants
phpbrew variants
