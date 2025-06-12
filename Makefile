# --- Переменные компиляции ---
LATEXMK = latexmk
LATEXMK_FLAGS = -pdf -interaction=nonstopmode -shell-escape

# --- Переменные для параллельной сборки ---
PARALLEL_JOBS ?= $(shell nproc --all 2>/dev/null || echo 1)

# --- Переменные для очистки ---
RM = rm -f
TEMPORARY_FILES = *.aux *.bbl *.blg *.fdb_latexmk *.fls *.nav *.out *.snm *.synctex.gz *.toc
LOG_FILES = *.log

# --- Настройки Docker ---
DOCKER_IMAGE = 2109199812/docker-latex
DOCKER_RUN = docker run
DOCKER_FLAGS = --rm -i -v "${PWD}":/diplom:Z
DOCKER_WORKDIR_FLAGS = --workdir=/diplom
DOCKER_COMMAND = make --no-print-directory

# --- Исходные файлы ---
TEX_FILES := $(wildcard *.tex)
PDF_FILES := $(patsubst %.tex,%.pdf,$(TEX_FILES))

# --- Цели ---
.PHONY: all release _release_local diploma presentation clean clean_all help \
        _local_diploma _local_presentation

all: release

release:
	@echo "🚀 Запускаю ПАРАЛЛЕЛЬНУЮ сборку на [$(PARALLEL_JOBS)] ядрах в Docker..."
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_WORKDIR_FLAGS) $(DOCKER_IMAGE) $(DOCKER_COMMAND) -j$(PARALLEL_JOBS) _release_local
	@echo "✅ Все документы успешно собраны."

_release_local:
	@echo "🔥 Удаляю старые PDF и временные файлы перед полной сборкой..."
	$(RM) $(PDF_FILES) $(TEMPORARY_FILES) $(LOG_FILES)
	@echo "📄 Компилирую все .tex файлы в параллельном режиме..."
	@$(MAKE) --no-print-directory $(PDF_FILES)
	@echo "🧹 Очистка временных файлов после сборки..."
	@$(MAKE) --no-print-directory clean

diploma:
	@echo "🚀 Собираю диплом (diploma.pdf) в Docker..."
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_WORKDIR_FLAGS) $(DOCKER_IMAGE) $(DOCKER_COMMAND) _local_diploma
	@echo "✅ Диплом собран."

_local_diploma:
	@echo "🔥 Удаляю старый файл diploma.pdf (если существует)..."
	$(RM) diploma.pdf
	@echo "📄 Компилирую diploma.tex в diploma.pdf с помощью latexmk..."
	$(LATEXMK) $(LATEXMK_FLAGS) diploma.tex
	@echo "👍 Файл diploma.pdf успешно создан."

presentation:
	@echo "🚀 Собираю презентацию (presentation.pdf) в Docker..."
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_WORKDIR_FLAGS) $(DOCKER_IMAGE) $(DOCKER_COMMAND) _local_presentation
	@echo "✅ Презентация собрана."

_local_presentation:
	@echo "🔥 Удаляю старый файл presentation.pdf (если существует)..."
	$(RM) presentation.pdf
	@echo "📄 Компилирую presentation.tex в presentation.pdf с помощью latexmk..."
	$(LATEXMK) $(LATEXMK_FLAGS) presentation.tex
	@echo "👍 Файл presentation.pdf успешно создан."

%.pdf: %.tex
	@echo "🔥 Удаляю старый файл $@ (если существует)..."
	$(RM) $@
	@echo "📄 Компилирую $< в $@ с помощью latexmk..."
	$(LATEXMK) $(LATEXMK_FLAGS) $<
	@echo "👍 Файл $@ успешно создан."

# --- Цели для очистки ---
clean:
	@echo "🧹 Удаляю временные файлы..."
	$(RM) $(TEMPORARY_FILES) $(LOG_FILES)

clean_all:
	@echo "💣 Удаляю все сгенерированные файлы, включая PDF..."
	$(RM) $(PDF_FILES)
	@$(MAKE) --no-print-directory clean

help:
	@echo "Makefile для сборки LaTeX документов в Docker"
	@echo "------------------------------------------------"
	@echo "Основные возможности:"
	@echo "  - Старые PDF удаляются перед каждой сборкой."
	@echo "  - Команда 'make release' запускает сборку в несколько потоков."
	@echo ""
	@echo "Доступные команды:"
	@echo "  make release (all)      - Параллельно собрать все .tex файлы в PDF внутри Docker."
	@echo "  make diploma            - Собрать только 'diploma.pdf' (сначала удалив старый)."
	@echo "  make presentation       - Собрать только 'presentation.pdf' (сначала удалив старый)."
	@echo "  make clean              - Удалить временные файлы сборки (*.aux, *.log и т.д.)."
	@echo "  make clean_all          - Удалить все временные файлы и готовые PDF."
	@echo "  make help               - Показать это сообщение."
