#!/bin/bash


for i in *.chimeric

do 
  grep 'SA:' $i > $i.list
  uniq $i.list >$i.list.unique
  wc -l $i.list.unique >$i.list.unique.ct 
done  

