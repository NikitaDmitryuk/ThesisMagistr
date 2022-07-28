COMPILER_LATEX = pdflatex
COMPILER_FLAGS = -interaction=nonstopmode
COMPILER_BIBTEX = bibtex

TEMPORARY_FILES = *.out *.aux *.blg *.bbl *.toc *.nav *.snm
LOG_FILES = *.log

SOURCES := $(shell find "${PWD}" -maxdepth 1 -name '*.tex' -printf "%f\n")
RESULTS := $(shell find "${PWD}" -maxdepth 1 -name '*.tex' -printf "%f\n" | sed -r "s/(.*).tex/\1.pdf/g")

all:
	docker run --rm -i -v "${PWD}":/diplom:Z 2109199812/docker-latex bash -c "make release"

release: clean_before_build $(RESULTS) clean_after_build

%.pdf: %.tex
	$(COMPILER_LATEX) $(COMPILER_FLAGS) $*
	@if grep -r "citation{.*}" $*.aux; then \
		$(COMPILER_BIBTEX) $*; \
	fi
	$(COMPILER_LATEX) $(COMPILER_FLAGS) $*
	$(COMPILER_LATEX) $(COMPILER_FLAGS) $*

clean_before_build:
	rm -f $(RESULTS) $(LOG_FILES) $(TEMPORARY_FILES)

clean_after_build:
	rm -f $(TEMPORARY_FILES)
