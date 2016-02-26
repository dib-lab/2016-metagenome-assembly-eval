#!/bin/bash

NUCMER =~/Desktop/software/MUMmer3.24/



		
python filter_below_mincontig.py idba-quality-assembly.fa iqc250.fa 250
python filter_below_mincontig.py idba-quality-assembly.fa iqc500.fa 500
python filter_below_mincontig.py idba-quality-assembly.fa iqc750.fa 750 
python filter_below_mincontig.py idba-quality-assembly.fa iqc1000.fa 1000 
python filter_below_mincontig.py idba-quality-assembly.fa iqc2000.fa 2000
python filter_below_mincontig.py idba-quality-assembly.fa iqc3000.fa 3000


NUCMER/nucmer --coords -p iqc250  mircea.fa iqc250.fa 
NUCMER/nucmer --coords -p iqc500  mircea.fa iqc500.fa
NUCMER/nucmer --coords -p iqc750  mircea.fa iqc750.fa
NUCMER/nucmer --coords -p iqc1000  mircea.fa iqc1000.fa
NUCMER/nucmer --coords -p iqc2000  mircea.fa iqc2000.fa
NUCMER/nucmer --coords -p iqc3000  mircea.fa iqc3000.fa


python genome_fraction.py iqc250.fa mircea.fa iqc250.coords > fractions.mincontigs
python genome_fraction.py iqc500.fa mircea.fa iqc500.coords > fractions.mincontigs
python genome_fraction.py iqc750.fa mircea.fa iqc750.coords > fractions.mincontigs
python genome_fraction.py iqc1000.fa mircea.fa iqc1000.coords > fractions.mincontigs
python genome_fraction.py iqc2000.fa mircea.fa iqc2000.coords > fractions.mincontigs
python genome_fraction.py iqc3000.fa mircea.fa iqc3000.coords > fractions.mincontigs

 



                                       
                                       
                                       
  
		
