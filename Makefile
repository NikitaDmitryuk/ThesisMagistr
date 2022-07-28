LATEX_COMPILER = pdflatex
LATEX_COMPILER_FLAGS = -interaction=nonstopmode
BIBLIO_COMPILER = bibtex
BIBLIO_COMPILER_FLAGS = 

RM = rm -f
TEMPORARY_FILES = *.out *.aux *.blg *.bbl *.toc *.nav *.snm
LOG_FILES = *.log

DOCKER_RUN = docker run
DOCKER_FLAGS = --rm -i -v "${PWD}":/diplom:Z
DOCKER_IMAGE = 2109199812/docker-latex
DOCKER_COMMAND = bash -c "make release"

FILES_TO_BUILD := $(shell find "${PWD}" -maxdepth 1 -name '*.tex' -printf "%f\n" | sed -r "s/(.*).tex/\1.pdf/g")

.PHONY: all release clean_before_build clean_after_build

all:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) $(DOCKER_COMMAND)

release: clean_before_build $(FILES_TO_BUILD) clean_after_build

%.pdf: %.tex
	$(LATEX_COMPILER) $(LATEX_COMPILER_FLAGS) $*
	@if grep -r "citation{.*}" $*.aux; then \
		$(BIBLIO_COMPILER) $(BIBLIO_COMPILER_FLAGS) $*; \
	fi
	$(LATEX_COMPILER) $(LATEX_COMPILER_FLAGS) $*
	$(LATEX_COMPILER) $(LATEX_COMPILER_FLAGS) $*

clean_before_build:
	$(RM) $(FILES_TO_BUILD) $(LOG_FILES) $(TEMPORARY_FILES)

clean_after_build:
	$(RM) $(TEMPORARY_FILES)
