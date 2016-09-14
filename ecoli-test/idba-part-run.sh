#!/bin/bash

GROUPLIST=$(ls -1 kak.group*.fa | cut -c 5-13)
for g in $GROUPLIST    
do
   idba_ud --pre_correction -r kak.$g.fa -o idba.part.$g.d
done

