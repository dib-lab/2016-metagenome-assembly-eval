#PBS -A ged
#PBS -l nodes=1:ppn=3
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N ecoli


cd /mnt/research/ged/sherine/ecoli-test/




python analyze_assembly.py ecoliMG1655.fa idba-quality-assembly.fa spades-quality-assembly.fa megahit-quality-assembly.fa ecoli-iqc.coords \
	ecoli-sqc.coords ecoli-mqc.coords Ecoli.QC.AMBIGIOUS500.99 -a True 99 

python analyze_assembly.py ecoliMG1655.fa idba-quality-assembly.fa spades-quality-assembly.fa megahit-quality-assembly.fa ecoli-iqc.coords \
        ecoli-sqc.coords ecoli-mqc.coords Ecoli.QC.BESTHIT500.99 -b True 99 

python analyze_assembly.py ecoliMG1655.fa idba-quality-assembly.fa spades-quality-assembly.fa megahit-quality-assembly.fa ecoli-iqc.coords \
	ecoli-sqc.coords ecoli-mqc.coords  Ecoli.QC.NOOVERLAPS500.99 -c True 99

 





