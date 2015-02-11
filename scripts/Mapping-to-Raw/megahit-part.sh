#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N megahit-part

module load bowtie2

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping-to-Raw/megahit/

gunzip -c /mnt/home/mahmoud4/Metagenome-Protocol/quality/SRR606249.pe.qc.fq.gz | bowtie2 -p 4 -x /mnt/home/mahmoud4/Metagenome-Protocol/Mapping-to-Raw/megahit/megahit-part -U - -S /mnt/research/ged/sherine/Mapping-to-Raw/megahit/megahit-part.sam-1

gunzip -c /mnt/home/mahmoud4/Metagenome-Protocol/quality/SRR606249.pe.qc.fq.gz | bowtie2 -p 4 -x /mnt/home/mahmoud4/Metagenome-Protocol/Mapping-to-Raw/megahit/megahit-part -U - -S /mnt/research/ged/sherine/Mapping-to-Raw/megahit/megahit-part.sam-1

gzip -c /mnt/research/ged/sherine/Mapping-to-Raw/megahit/megahit-part.sam-1 /mnt/research/ged/sherine/Mapping-to-Raw/megahit/megahit-part.sam-2  > /mnt/research/ged/sherine/Mapping-to-Raw/megahit/megahit-part.sam
