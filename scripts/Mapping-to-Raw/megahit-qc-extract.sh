#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N megahit-qc-extract

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping-to-Raw/megahit/

bash extract-bam.sh /mnt/research/ged/sherine/Mapping-to-Raw/megahit/megahit-qc.bam > megahit-qc.fasta

