
all: docker-latex

diploma: Dmitryuk_Nikita_FN4-41M_diploma.tex
	pdflatex -interaction=nonstopmode Dmitryuk_Nikita_FN4-41M_diploma
	bibtex Dmitryuk_Nikita_FN4-41M_diploma
	pdflatex -interaction=nonstopmode Dmitryuk_Nikita_FN4-41M_diploma
	pdflatex -interaction=nonstopmode Dmitryuk_Nikita_FN4-41M_diploma

presentation: Dmitryuk_Nikita_FN4-41M_presentation.tex
	pdflatex -interaction=nonstopmode Dmitryuk_Nikita_FN4-41M_presentation
	pdflatex -interaction=nonstopmode Dmitryuk_Nikita_FN4-41M_presentation

clean:
	rm *.out
	rm *.aux 
	rm *.blg 
	rm *.bbl 
	rm *.toc
	rm *.nav
	rm *.snm

release: diploma presentation clean

docker-latex:
	sudo systemctl start docker
	docker run --rm -i -v ${PWD}:/diplom:Z docker-latex bash -c "make release"
