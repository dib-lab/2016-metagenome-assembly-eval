#!/bin/bash

for i in *pe.kak.qc.fq.gz; 

do 

    name=$(basename $i .qc.fq.gz).fa

    fastq-to-fasta.py $i > $name

done
