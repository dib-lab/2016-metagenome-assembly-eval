#!/bin/bash

for i in *pe.kak.qc.fq.gz; 

do 

    name=$(basename $i .qc.fq.gz).fa

    python /usr/local/share/khmer/scripts/fastq-to-fasta.py $i > $name

done
