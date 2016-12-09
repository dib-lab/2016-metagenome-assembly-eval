# !/bin/bash -eu
samtools view  -F4 $1 | awk '{OFS="\t"; print ">"$1"\n"$10}'
