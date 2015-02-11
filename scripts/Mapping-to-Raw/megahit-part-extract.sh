#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N megahit-part-extract

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping-to-Raw/megahit/

bash extract-bam.sh /mnt/research/ged/sherine/Mapping-to-Raw/megahit/megahit-part.bam  > megahit-part.fasta

