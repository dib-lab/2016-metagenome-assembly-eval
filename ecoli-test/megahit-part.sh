#!/bin/bash 

for i in kak*.fq.gz;
do
    name=$(basename $i .fq.gz);
    python /mnt/home/mahmoud4/megahit/megahit -l 101 -m 1e+10 --cpu-only -r $i -o $name
done 

