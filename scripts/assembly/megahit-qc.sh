#PBS -A ged 
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=250GB
#PBS -N megahit-quality-corrected

cd /mnt/home/mahmoud4/megahit/quality/
/usr/bin/time  -a  -o megqc.txt python ../megahit -l 101 -m 1e+10 --cpu-only -r SRR606249.pe.qc.fq.gz -o /mnt/home/mahmoud4/megahit/quality/meghit-quality-pe
/usr/bin/time  -a  -o megqc.txt python ../megahit -l 101 -m 1e+10 --cpu-only -r SRR606249.se.qc.fq.gz -o /mnt/home/mahmoud4/megahit/quality/meghit-quality-se



