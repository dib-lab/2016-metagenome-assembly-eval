#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N spadesQC5


cd /mnt/research/ged/sherine/ecoli-test/

module swap GNU GNU/4.8.2
module load khmer

module load spades

make spades-quality-1

make spades-quality-2

make finalize-spades-quality








