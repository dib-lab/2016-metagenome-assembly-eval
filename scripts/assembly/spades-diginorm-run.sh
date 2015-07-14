#PBS -A ged-intel11
#PBS -l nodes=1:ppn=1
#PBS -l walltime=120:00:00
#PBS -l mem=250GB
#PBS -N spades-diginorm
 
module load SPAdes
cd /mnt/home/mahmoud4/DIGINORM/spades/
bash spades-diginorm-assembly.sh

