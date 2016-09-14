#!/bin/bash

for i in kak*.pe.fq.gz
do
   name=$(basename $i .pe.fq.gz).fa;
   fastq-to-fasta.py $i > $name
done

