COMPILER_LATEX = pdflatex
COMPILER_FLAGS = -interaction=nonstopmode
COMPILER_BIBTEX = bibtex

RM = rm -f
TEMPORARY_FILES = *.out *.aux *.blg *.bbl *.toc *.nav *.snm
LOG_FILES = *.log

DOCKER_RUN = docker run
DOCKER_FLAGS = --rm -i -v "${PWD}":/diplom:Z
DOCKER_IMAGE = 2109199812/docker-latex
DOCKER_COMMAND = bash -c "make release"

SOURCES := $(shell find "${PWD}" -maxdepth 1 -name '*.tex' -printf "%f\n")
RESULTS := $(shell find "${PWD}" -maxdepth 1 -name '*.tex' -printf "%f\n" | sed -r "s/(.*).tex/\1.pdf/g")

.PHONY: all clean_before_build clean_after_build

all:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) $(DOCKER_COMMAND)

release: clean_before_build $(RESULTS) clean_after_build

%.pdf: %.tex
	$(COMPILER_LATEX) $(COMPILER_FLAGS) $*
	@if grep -r "citation{.*}" $*.aux; then \
		$(COMPILER_BIBTEX) $*; \
	fi
	$(COMPILER_LATEX) $(COMPILER_FLAGS) $*
	$(COMPILER_LATEX) $(COMPILER_FLAGS) $*

clean_before_build:
	$(RM) $(RESULTS) $(LOG_FILES) $(TEMPORARY_FILES)

clean_after_build:
	$(RM) $(TEMPORARY_FILES)
