#!/bin/bash


for i in megahit.kak.*.*e
do
   python ~/khmer/sandbox/calc-best-assembly.py  ${i}/final.contigs.fa   -o megahit-partition-best.$i.fa
done


