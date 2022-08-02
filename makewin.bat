@echo off
SETLOCAL

rem - отвечает за комментирование

rem  Сборка всех файлов .tex в основной директории
docker run --rm -i -v "%cd%":/diplom:Z 2109199812/docker-latex bash -c "make release"

rem  Сборка файла diploma.pdf
rem  docker run --rm -i -v "%cd%":/diplom:Z 2109199812/docker-latex bash -c "make clean_before_build && make diploma.pdf"

rem  Сборка файла presentation.pdf
rem  docker run --rm -i -v "%cd%":/diplom:Z 2109199812/docker-latex bash -c "make clean_before_build && make presentation.pdf"

pause

ENDLOCAL
