#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N idbaQC5

cd /mnt/research/ged/sherine/run

module swap GNU GNU/4.8.2
module load khmer

module swap GNU GNU/4.4.5
module load IDBAUD

make idba-quality-1 
make idba-quality-2 
make finalize-idba-quality










