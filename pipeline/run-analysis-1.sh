#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=96:00:00
#PBS -l mem=100GB
#PBS -N analysis-1

cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline

module load bwa
module load samtools

make analysis
make readcoverage
make countunmapped 
make unalignedcoverage


