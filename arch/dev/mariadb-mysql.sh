#!/bin/bash
#
# Install dbeaver as client universal data base
# By: 4rcan31
#
# Requirements: Have an Arch Linux-based distribution installed
#
# Start of configuration


sudo pacman -S mariadb --noconfirm
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation
