@echo off
SETLOCAL

rem - Used for commenting

rem Build all .tex files in the main directory
docker run --rm -i -v "%cd%":/diplom -w /diplom ghcr.io/nikitadmitryuk/thesismagistr/latex:latest make release

rem Build diploma.pdf file
rem docker run --rm -i -v "%cd%":/diplom -w /diplom ghcr.io/nikitadmitryuk/thesismagistr/latex:latest make diploma

rem Build presentation.pdf file
rem docker run --rm -i -v "%cd%":/diplom -w /diplom ghcr.io/nikitadmitryuk/thesismagistr/latex:latest make presentation

pause

ENDLOCAL
