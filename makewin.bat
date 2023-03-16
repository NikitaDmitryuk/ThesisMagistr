@echo off
SETLOCAL

rem - Used for commenting

rem Build all .tex files in the main directory
docker run --rm -i -v "%cd%":/diplom:Z 2109199812/docker-latex bash -c "make release"

rem Build diploma.pdf file
rem docker run --rm -i -v "%cd%":/diplom:Z 2109199812/docker-latex bash -c "make diploma"

rem Build presentation.pdf file
rem docker run --rm -i -v "%cd%":/diplom:Z 2109199812/docker-latex bash -c "make presentation"

pause

ENDLOCAL
