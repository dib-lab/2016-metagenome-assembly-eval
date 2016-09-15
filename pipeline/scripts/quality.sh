#PBS -A ged
#PBS -l nodes=1:ppn=3
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N sQ5


cd /mnt/research/ged/sherine/sampling/five/
module swap GNU GNU/4.8.2
module load khmer

 
module load Trimmomatic

make interleaving-1
make interleaving-2
make interleaving-3
make protocol-quality-rename-1
make protocol-quality-rename-2 








