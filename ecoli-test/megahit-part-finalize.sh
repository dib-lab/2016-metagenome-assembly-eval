#!/bin/bash

   
for i in kak*.fq.gz;
do
    name=$(basename $i .fq.gz);
	python ~/khmer/sandbox/calc-best-assembly.py  $name/final.contigs.fa   -o megahit-partition-best.$name.fa
done


