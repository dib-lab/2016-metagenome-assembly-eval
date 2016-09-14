#!/bin/bash

for i in *.pe.fq
do
   name=$(basename $i .pe.fq);
   spades.py --sc --pe1-12 $name.pe.fq.gz -o $name.spades.d
done 
