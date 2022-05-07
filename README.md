# ThesisMagistr
Выпускная квалификационная работа 

Status of last deployment:

![example workflow](https://github.com/NikitaDmitryuk/ThesisMagistr/actions/workflows/main.yml/badge.svg)

## Установка в Linux

Запустить скрипт соответствующий вашей операционной системе:

```shell
bash install-*.sh
```

## Запуск компиляции latex

```shell
make
```

## Установка в Windows

Необходимо запустить программу PowerShell от имени администратора и ввести команду: 

```shell
wsl --install -d Ubuntu
```

Перезагружаем ПК. После этого заходим в магазин приложений Windows и скачиваем Ubuntu любой доступной версии. 

Устанавливаем убунту и действуем по инструкции установки в Linux. 

## Создание релиза

Создание релиза происходит на Github в специальном контейнере Docker по пушу тега вида v*. 

Пример:

```bash
git add .
git commit -m "your comment"
git push
git tag -a v0.1 -m "your comment"
git push --tags
```
