
all: docker-latex

diplom: diplom.tex
	pdflatex -interaction=nonstopmode diplom
	bibtex diplom
	pdflatex -interaction=nonstopmode diplom
	pdflatex -interaction=nonstopmode diplom

clean:
	rm *.out
	rm *.aux 
	rm *.blg 
	rm *.bbl 
	rm *.toc

docker-latex:
	sudo systemctl start docker
	docker run --rm -i -v ${PWD}:/diplom:Z docker-latex bash -c "make diplom && make clean"
