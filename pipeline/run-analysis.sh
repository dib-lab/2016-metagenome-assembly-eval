#PBS -A ged
#PBS -l nodes=1:ppn=3
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N analyzeassembly


cd /mnt/research/ged/sherine/run


make run-prokka 
make run-analysis 





