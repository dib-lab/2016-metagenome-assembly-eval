# !/bin/bash -eu

~/samtools-1.1/samtools view -f4 $1 | cut -f1,10 | xargs -n 2 -l bash -c 'printf ">$0\n$1\n"'
