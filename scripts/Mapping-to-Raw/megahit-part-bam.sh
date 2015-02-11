#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N megahit-part-bam

module load samtools

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping-to-Raw/megahit/

~/samtools-1.1/samtools import megahit-quality-assembly.fa.fai /mnt/research/ged/sherine/Mapping-to-Raw/megahit/megahit-part.sam /mnt/research/ged/sherine/Mapping-to-Raw/megahit/megahit-part.bam
