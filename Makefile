
all: docker-latex

diplom:
	pdflatex -interaction=nonstopmode diplom
	bibtex diplom
	pdflatex -interaction=nonstopmode diplom
	pdflatex -interaction=nonstopmode diplom

clean:
	rm *.toc *.out *.aux *.blg *.bbl

docker-latex:
	docker run --rm -ti -v ${PWD}:/diplom:Z docker-latex bash -c "make diplom && make clean"
