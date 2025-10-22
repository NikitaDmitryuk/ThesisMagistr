# Установка и сборка (Docker)

Примеры команд (bash, Linux / WSL):

1) Запустить сборку с использованием удалённого образа (быстро):

```bash
# скачивает образ из реестра и создаёт контейнер с томом текущей папки
docker run --rm -v "$PWD":/diplom -w /diplom ghcr.io/nikitadmitryuk/thesismagistr/latex:latest make
```

2) Собрать локальный образ из `install/Dockerfile` и использовать его:

```bash
# из папки install
docker build -t thesismagistr-latex ./install

# затем из корня репозитория
docker run --rm -v "$PWD":/diplom -w /diplom thesismagistr-latex make
```

3) Если хотите интерактивно зайти в контейнер (дебаг, отладка сборки):

```bash
docker run --rm -it -v "$PWD":/diplom -w /diplom thesismagistr-latex /bin/bash
```
