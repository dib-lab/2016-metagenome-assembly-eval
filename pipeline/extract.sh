#!/bin/bash

for i in *.pe.*.keep*
do
   extract-paired-reads.py $i
done
