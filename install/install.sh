#!/bin/sh

sudo pacman -S docker
sudo systemctl --now enable docker
sudo setfacl -m user:${USER}:rw /var/run/docker.sock
sudo systemctl restart docker

if [[ "$1" == "build" ]]; then
    sudo docker build -t 2109199812/docker-latex .
	exit
else
    docker pull 2109199812/docker-latex
    exit
fi
