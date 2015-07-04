#PBS -A ged 
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=250GB
#PBS -N megahit-diginorm-corrected

cd /mnt/home/mahmoud4/megahit/diginorm/
/usr/bin/time  -a  -o megdigi.txt python ../megahit -l 101 -m 1e+10 --cpu-only -r SRR606249.pe.kak.qc.fq.gz -o megahit-diginorm-pe/
/usr/bin/time  -a  -o megdigi.txt python ../megahit -l 101 -m 1e+10 --cpu-only -r SRR606249.se.kak.qc.fq.gz -o megahit-diginorm-se/



