# Установка и сборка (Docker)

Примеры команд (bash, Linux / WSL):

1) Запустить сборку с использованием удалённого образа (быстро):

```bash
# скачивает образ из реестра и создаёт контейнер с томом текущей папки
docker run --rm -v "$PWD":/diplom -w /diplom ghcr.io/nikitadmitryuk/thesismagistr/latex:latest make release
```

2) Собрать локальный образ из `install/Dockerfile` и использовать его:

```bash
# из корня репозитория
docker build -f install/Dockerfile -t thesismagistr-latex:26.04 .

# затем из корня репозитория
docker run --rm -v "$PWD":/diplom -w /diplom thesismagistr-latex:26.04 make release
```

3) Если хотите интерактивно зайти в контейнер (дебаг, отладка сборки):

```bash
docker run --rm -it -v "$PWD":/diplom -w /diplom thesismagistr-latex:26.04 /bin/bash
```
