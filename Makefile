COMPILER_LATEX = pdflatex
COMPILER_FLAGS = -interaction=nonstopmode

COMPILER_BIBTEX = bibtex

RM = rm
RM_FLAGS = -f
RM_FILES = *.out *.aux *.blg *.bbl *.toc *.nav *.snm
LOG_FILES = *.log

SOURCES := $(shell find "${PWD}" -maxdepth 1 -name '*.tex' -printf "%f\n")
RESULTS := $(shell find "${PWD}" -maxdepth 1 -name '*.tex' -printf "%f\n" | sed -r "s/(.*).tex/\1.pdf/g")

all:
	docker run --rm -i -v "${PWD}":/diplom:Z 2109199812/docker-latex bash -c "make release"

release: clean_results $(RESULTS) clean

%.pdf: %.tex
	$(COMPILER_LATEX) $(COMPILER_FLAGS) $*
	-$(COMPILER_BIBTEX) $*
	$(COMPILER_LATEX) $(COMPILER_FLAGS) $*
	$(COMPILER_LATEX) $(COMPILER_FLAGS) $*

clean:
	$(RM) $(RM_FLAGS) $(RM_FILES)

clean_results:
	$(RM) $(RM_FLAGS) $(RESULTS) $(LOG_FILES)
