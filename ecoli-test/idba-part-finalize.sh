#!/bin/bash

GROUPLIST=$(ls -1 kak.group*.fa | cut -c 5-13)
for g in $GROUPLIST
do
   python ~/khmer/sandbox/calc-best-assembly.py  idba.part.$g.d/scaffold.fa -o idba-partition-best.$g.fa
done



