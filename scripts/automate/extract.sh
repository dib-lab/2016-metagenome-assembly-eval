#!/bin/bash

for i in *pe*keep*.abundfilt
do
   extract-paired-reads.py $i
done
