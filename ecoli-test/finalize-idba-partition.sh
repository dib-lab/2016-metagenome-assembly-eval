GROUPLIST=$(ls -1 kak.group*.pe.fq.gz | cut -c 5-13)
for g in $GROUPLIST
do
   python /usr/local/share/khmer/sandbox/calc-best-assembly.py  *.${g}.*.idba.d/scaffold.fa -o idba-partition.best.$g.fa
done

python /usr/local/share/khmer/sandbox/multi-rename.py assembly  idba-partition.best.group*.fa > idba-partition-assembly.fa
