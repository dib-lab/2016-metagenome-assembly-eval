#PBS -A ged
#PBS -l nodes=1:ppn=3
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N 5perQC

cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline/ 

module swap GNU GNU/4.8.2
module load khmer

 
module load Trimmomatic
make quality







