
GROUPLIST=$(ls -1 readskak.group*.fq.sweep.nodn.pe.fa| cut -c 10-18)

for g in $GROUPLIST
do
   python /mnt/home/mahmoud4/khmer/sandbox/calc-best-assembly.py  readskak.${g}.*.idba.d/scaffold.fa -o idba-reinflation-best.$g.fa
done

python /mnt/home/mahmoud4/khmer/sandbox/multi-rename.py assembly  idba-reinflation-best.group*.fa > idba-reinflation-assembly.fa
