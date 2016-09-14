#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N spart12p5


cd /mnt/research/ged/sherine/quality2p5

module swap GNU GNU/4.8.2
module load khmer

make protocol-partition-below

make protocol-partition-rename-1

make protocol-partition-run

make protocol-partition-extract

make protocol-partition-rename-2

make protocol-partition-compress




