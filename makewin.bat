@echo off
SETLOCAL

docker run --rm -i -v "%cd%":/diplom:Z 2109199812/docker-latex bash -c "make release"
