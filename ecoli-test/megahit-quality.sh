#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N megahitQC5


cd /mnt/research/ged/sherine/ecoli-test/ 

module swap GNU GNU/4.8.2
module load khmer

make megahit-qc-1

make finalize-megahit-quality










