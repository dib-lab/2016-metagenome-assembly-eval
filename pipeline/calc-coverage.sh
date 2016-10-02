#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N fix98

module load samtools 
module load bwa

cd /mnt/research/ged/sherine/run/

cat SRR606249.pe.qc.fq.gz  SRR606249.se.qc.fq.gz > qc.fq.gz

bwa index mircea.fa

bwa aln mircea.fa qc.fq.gz >  /mnt/scratch/mahmoud4/qc.sai 

bwa samse mircea.fa  /mnt/scratch/mahmoud4/qc.sai qc.fq.gz > /mnt/scratch/mahmoud4/qc.sam

python /mnt/home/mahmoud4/scripts/cov.py mircea.fa /mnt/scratch/mahmoud4/qc.sam /mnt/scratch/mahmoud4/new.qc.coverage 

