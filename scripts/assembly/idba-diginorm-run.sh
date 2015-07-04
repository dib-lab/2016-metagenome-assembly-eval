#PBS -A ged-intel11 
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=250GB
#PBS -N megahit-

cd /mnt/home/mahmoud4/
bash idba-diginorm-assembly.sh
