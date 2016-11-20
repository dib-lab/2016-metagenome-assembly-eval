#PBS -A ged
#PBS -l nodes=1:ppn=3
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N analysis

cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline/ 

module load bwa
module load samtools

module swap GNU GNU/4.8.2
module load khmer
module load Trimmomatic

make analysis
make readcoverage
make countunmapped 
make unalignedcoverage
make common-uncovered-coverage.out
make mqc500.dist

