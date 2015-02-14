#!/bin/bash

for i in *kak*.pe.fq
do
   name=$(basename $i .fq).fa
   python /usr/local/share/khmer/scripts/fastq-to-fasta.py $i > $name
done

