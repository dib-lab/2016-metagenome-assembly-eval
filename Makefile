all: 2014-metag.pdf

2014-metag.pdf: 2014-metag.tex references.bib
	pdflatex 2014-metag.tex
	bibtex 2014-metag
	pdflatex 2014-metag.tex
	pdflatex 2014-metag.tex


clean:
	rm *.aux *.bbl *.blg *.log *.pdf
