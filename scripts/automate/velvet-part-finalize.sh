#!/bin/bash

GROUPLIST=$(ls -1 kak.group*.pe.fq.gz | cut -c 5-13)
for g in $GROUPLIST
do
   python ~/khmer/sandbox/calc-best-assembly.py  *.${g}.*velvet.*.d/contigs.fa  -o velvet-partition-best.$g.fa
done
