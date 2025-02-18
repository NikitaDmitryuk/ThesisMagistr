#!/bin/sh

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
    pull_or_build_docker_image "$1"
}

main "$@"
