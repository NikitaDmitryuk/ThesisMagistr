LATEXMK = latexmk
LATEXMK_FLAGS = -pdf -interaction=nonstopmode

RM = rm -f
TEMPORARY_FILES = *.out *.aux *.blg *.bbl *.toc *.nav *.snm *.fls *.fdb_latexmk
LOG_FILES = *.log

DOCKER_RUN = docker run
DOCKER_FLAGS = --rm -i -v "${PWD}":/diplom -w /diplom
GHCR_IMAGE ?= nikitadmitryuk/thesismagistr/latex
DOCKER_IMAGE = ghcr.io/$(GHCR_IMAGE):latest
DOCKER_COMMAND = make release

FILES_TO_BUILD := $(patsubst %.tex,%.pdf,$(wildcard *.tex))

.PHONY: all release clean clean_after_build clean_diploma clean_presentation

all:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) $(DOCKER_COMMAND)

release: clean $(FILES_TO_BUILD) clean_after_build

diploma presentation:
	$(DOCKER_RUN) $(DOCKER_FLAGS) $(DOCKER_IMAGE) bash -c "make clean_$@ && make $@.pdf && make clean_after_build"

%.pdf: %.tex
	$(LATEXMK) $(LATEXMK_FLAGS) $<

clean:
	$(RM) $(FILES_TO_BUILD) $(LOG_FILES) $(TEMPORARY_FILES)

clean_after_build:
	$(RM) $(TEMPORARY_FILES)

clean_diploma clean_presentation:
	$(RM) $(TEMPORARY_FILES) $(subst clean_,,$@).pdf
