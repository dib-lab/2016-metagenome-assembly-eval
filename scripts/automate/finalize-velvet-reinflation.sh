GROUPLIST=$(ls -1 kak.group*.pe.fq.gz | cut -c 5-13)
for g in $GROUPLIST
do
   python /usr/local/share/khmer/sandbox/calc-best-assembly.py *.${g}.*velvet.*.d/contigs.fa  -o velvet-reinflation-best.$g.fa
done

python /usr/local/share/khmer/sandbox/multi-rename.py assembly velvet-reinflation-best.group*.fa > velvet-reinflation-assembly.fa
