#! /bin/bash
set -e
set -u

module swap GNU GNU/4.8.2
module load khmer
module load Trimmomatic

make quality 
make megahit-quality
make ecoli.pe.fa 
make spades-quality

module swap GNU GNU/4.4.5
module load IDBAUD

make ecoli.idba.d.qc/scaffold.fa 
make idba-quality-assembly.fa 

module load bwa
module load SAMTools/1.2

make analysis
make readcoverage
make countunmapped 
make unalignedcoverage


module swap GNU GNU/4.8.2
module load khmer
module load Trimmomatic

make common-uncovered-coverage.out
make mqc500.dist

module swap GNU GNU/4.4.5
module load bwa
module load samtools

make mincontig-analysis
