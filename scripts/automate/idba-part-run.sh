#!/bin/bash

for i in *.pe.fa
do
   name=$(basename $i .pe.fa);
   echo "idba_ud --pre_correction -r $i -o $name.idba.d"
done >> idba-part-run.sh

