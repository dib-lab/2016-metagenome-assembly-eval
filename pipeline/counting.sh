#!/bin/bash


for i in *.unaligned

do 
  grep '>SRR' $i > $i.list
  uniq $i.list >$i.list.unique
  wc -l $i.list.unique >$i.list.unique.ct 
done  

