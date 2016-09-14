#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N spadespart25


cd /mnt/research/ged/sherine/quality25
module load khmer 
module load spades

make spades-partition-3
make finalize-spades-partition






