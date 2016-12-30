all: 2016-metagenome.pdf

2016-metagenome.pdf: 2016-metagenome.tex
	pdflatex 2016-metagenome
	bibtex 2016-metagenome
	pdflatex 2016-metagenome
	pdflatex 2016-metagenome
