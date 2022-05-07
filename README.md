# ThesisMagistr
Выпускная квалификационная работа магистра

Status of last deployment:

![example workflow](https://github.com/NikitaDmitryuk/ThesisMagistr/actions/workflows/main.yml/badge.svg)

## Использование как шаблон

Клонировать данный репозиторий в свой GitHub можно используя кнопку Fork, после чего данный репозиорий появится в ваших репозиториях. 

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
Автоматически запустится процесс GitHub Actions, который закончится примерно через 1.5-2 минуты. Его можно наблюдать во вкладке *Actions* в репозитории. 
После этого справа в рпозитории появится релиз содержащий диплом со шрифтом times new roman и презентацию.
