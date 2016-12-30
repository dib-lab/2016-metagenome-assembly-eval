all: 2016-metagenome.pdf

2016-metagenome.pdf: 2016-metagenome.tex
	pdflatex 2016-metagenome
	bibtex 2016-metagenome
	pdflatex 2016-metagenome
	pdflatex 2016-metagenome

clean:
	-rm -f 2016-metagenome.aux 2016-metagenome.bbl 2016-metagenome.blg \
		2016-metagenome.log 2016-metagenome.pdf
