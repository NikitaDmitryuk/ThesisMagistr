#!/bin/sh

sudo pacman -S docker git
sudo usermod -a -G docker $USER
echo "Restart the PC after the first run of the script"
sudo systemctl start docker
sudo docker build -t docker-latex .
