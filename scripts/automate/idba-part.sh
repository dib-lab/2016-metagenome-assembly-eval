#!/bin/bash

for i in *kak*.pe.fq.gz
do
   name=$(basename $i .fq).fa
   python ~/khmer/scripts/fastq-to-fasta.py $i > $name
done

