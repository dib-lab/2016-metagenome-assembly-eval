#!/bin/bash

for i in *.pe.qc.fq.gz
do
   name=$(basename $i .qc.fq.gz).fa
   python ~/khmer/scripts/fastq-to-fasta.py $i > $name
done

