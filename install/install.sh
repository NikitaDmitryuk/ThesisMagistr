#!/bin/sh

install_docker() {
    if ! command -v docker >/dev/null 2>&1; then
        if command -v pacman >/dev/null 2>&1; then
            echo "Установка Docker..."
            sudo pacman -S docker
        else
            echo "Не найден пакетный менеджер pacman. Установите Docker вручную."
            exit 1
        fi
    else
        echo "Docker уже установлен."
    fi
}

configure_docker() {
    echo "Настройка Docker..."
    sudo systemctl --now enable docker
    sudo setfacl -m user:"${USER}":rw /var/run/docker.sock
    sudo usermod -aG docker "${USER}"
    sudo systemctl restart docker
}

pull_or_build_docker_image() {
    if [ "$1" == "build" ]; then
        echo "Сборка Docker-образа для LaTeX..."
        docker build --load -t 2109199812/docker-latex .
    else
        echo "Загрузка Docker-образа для LaTeX..."
        docker pull 2109199812/docker-latex
    fi
}

main() {
    install_docker
    configure_docker
    pull_or_build_docker_image "$1"

    echo "Перезагрузите компьютер для применения изменений."
}

main "$@"
