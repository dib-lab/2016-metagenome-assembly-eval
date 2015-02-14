#!/bin/bash

for i in kak*.pe.fq.gz
do
   gunzip -c $i > $(basename $i .gz)
done
