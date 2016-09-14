# !/bin/bash -eu


samtools view  -F4 $1 | cut -f1,10 | xargs -n 2 -l bash -c 'printf ">$0\n$1\n"'

