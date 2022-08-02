#!/bin/sh

sudo pacman -S docker
sudo systemctl --now enable docker
sudo setfacl -m user:${USER}:rw /var/run/docker.sock
sudo usermod -aG docker ${USER}
sudo systemctl restart docker

if [[ "$1" == "build" ]]; then
    docker build -t 2109199812/docker-latex .
else
    docker pull 2109199812/docker-latex
fi

echo "Restart PC"

exit
