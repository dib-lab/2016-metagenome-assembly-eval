#!/bin/bash

for i in *.pe.fq
do
   name=$(basename $i .pe.fq);
   echo "spades.py --sc --pe1-12 $name.pe.fq.gz -o $name.spades.d"
done >> spades-part-run.sh
spades.py --sc --pe1-12 kak.group0000.pe.fq.gz -o kak.group0000.spades.d
spades.py --sc --pe1-12 kak.group0000.pe.fq.gz -o kak.group0000.spades.d
