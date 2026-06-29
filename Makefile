LATEXMK = latexmk
LATEXMK_FLAGS = -pdf -interaction=nonstopmode

RM = rm -f
TEMPORARY_FILES = *.out *.aux *.blg *.bbl *.toc *.nav *.snm *.fls *.fdb_latexmk
LOG_FILES = *.log

DOCKER_RUN = docker run
DOCKER_FLAGS = --rm -i -v "${PWD}":/diplom -w /diplom
GHCR_IMAGE ?= nikitadmitryuk/thesismagistr/latex
DOCKER_IMAGE = ghcr.io/$(GHCR_IMAGE):latest
DOCKER_COMMAND = make build

FILES_TO_BUILD := $(patsubst %.tex,%.pdf,$(wildcard *.tex))
TEX_SOURCES := $(wildcard *.tex) $(wildcard chapters/*.tex) $(wildcard settings/*.tex)
FILES_TO_LINT := $(wildcard *.tex)

.PHONY: all build release release_docker format format_check lint format_tex format_check_tex lint_tex check_logs smoke_pdf clean clean_after_build clean_diploma clean_presentation

all:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) $(DOCKER_COMMAND)

build: clean $(FILES_TO_BUILD) clean_after_build

release: clean lint_tex $(FILES_TO_BUILD) check_logs smoke_pdf clean_after_build

release_docker:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) make release

diploma presentation:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) bash -c "make clean_$@ && make $@.pdf && make clean_after_build"

format:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) make format_tex

format_check:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) make format_check_tex

lint:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) make lint_tex

format_tex:
	@mkdir -p /tmp/latexindent
	@for file in $(TEX_SOURCES); do \
		echo "Formatting $$file"; \
		latexindent -s -l=.latexindent.yaml -w -c=/tmp/latexindent "$$file"; \
	done; \
	echo "LaTeX formatting complete."

format_check_tex:
	@mkdir -p /tmp/latexindent
	@status=0; \
	for file in $(TEX_SOURCES); do \
		echo "Checking format $$file"; \
		if latexindent -s -l=.latexindent.yaml -k -c=/tmp/latexindent "$$file"; then \
			:; \
		else \
			code=$$?; \
			if [ "$$code" = "1" ]; then \
				echo "$$file needs formatting"; \
			else \
				echo "latexindent failed for $$file with exit code $$code"; \
			fi; \
			status=1; \
		fi; \
	done; \
	if [ "$$status" = "0" ]; then \
		echo "LaTeX format check passed."; \
	fi; \
	exit $$status

lint_tex:
	chktex -l .chktexrc $(FILES_TO_LINT)

%.pdf: %.tex
	$(LATEXMK) $(LATEXMK_FLAGS) $<

check_logs:
	sh scripts/check_latex_logs.sh

smoke_pdf:
	sh scripts/pdf_smoke_check.sh

clean:
	$(RM) $(FILES_TO_BUILD) $(LOG_FILES) $(TEMPORARY_FILES)

clean_after_build:
	$(RM) $(TEMPORARY_FILES)

clean_diploma clean_presentation:
	$(RM) $(TEMPORARY_FILES) $(subst clean_,,$@).pdf
