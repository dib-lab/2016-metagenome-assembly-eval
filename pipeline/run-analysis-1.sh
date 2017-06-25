#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=24:00:00
#PBS -l mem=10GB
#PBS -N analysis-1
#PBS -m abe

cd /mnt/research/ged/ctb/2015-metagenome-assembly/pipeline

module load bwa
module load samtools

#make analysis
make  unmapped-assemblies

