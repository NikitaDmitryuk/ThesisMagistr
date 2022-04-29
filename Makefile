
all: docker-latex

diplom: diplom.tex
	pdflatex -interaction=nonstopmode diplom
	bibtex diplom
	pdflatex -interaction=nonstopmode diplom
	pdflatex -interaction=nonstopmode diplom

presentation: presentation.tex
	pdflatex -interaction=nonstopmode presentation
	pdflatex -interaction=nonstopmode presentation

clean:
	rm *.out
	rm *.aux 
	rm *.blg 
	rm *.bbl 
	rm *.toc
	rm *.nav
	rm *.snm

release: diplom presentation clean
	rm *.log
	rm -r install
	rm -r .git
	rm -r images
	rm -r chapters
	rm -r biblio
	rm -r .github
	rm README.md
	rm presentation.tex
	rm diplom.tex
	rm .gitignore
	rm Jenkinsfile
	rm Makefile

docker-latex:
	sudo systemctl start docker
	docker run --rm -i -v ${PWD}:/diplom:Z docker-latex bash -c "make diplom && make presentation && make clean"
