#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=24:00:00
#PBS -l mem=100GB
#PBS -N analysis-3

cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline 

module swap GNU GNU/4.8.2
module load khmer
module load Trimmomatic
module load prokka 


#make mincontig-analysis 
#make stats
make annotate-prokka
make parse-prokka 
  
