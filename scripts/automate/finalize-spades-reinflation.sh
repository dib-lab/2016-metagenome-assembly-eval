GROUPLIST=$(ls -1 kak.group*.pe.fq.gz | cut -c 5-13)
for g in $GROUPLIST
do
   python /usr/local/share/khmer/sandbox/calc-best-assembly.py  *.${g}.*spades.d/contigs.fasta  -o spades-reinflation.best.$g.fa
done

python /usr/local/share/khmer/sandbox/multi-rename.py assembly  spades-reinflation.best.group*.fa > spades-reinflation.assembly.fa
