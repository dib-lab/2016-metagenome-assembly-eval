all: 2015-metag.pdf

2015-metag.pdf: 2015-metag.tex references.bib
	pdflatex 2015-metag.tex
	bibtex 2015-metag
	pdflatex 2015-metag.tex
	pdflatex 2015-metag.tex


clean:
	rm *.aux *.bbl *.blg *.log *.pdf
