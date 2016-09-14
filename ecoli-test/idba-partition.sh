#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N idbapart25


cd /mnt/research/ged/sherine/quality25
module load khmer 
module load IDBAUD

make idba-partition-1

make idba-partition-2

make idba-partition-3

make finalize-idba-partition









