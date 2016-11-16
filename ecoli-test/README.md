If you need to split your data: 

python split-2.py ecoli_ref-5m.fastq.gz  ecoli-1.fastq  ecoli-2.fastq 

To run the pipeline: 

bash quality.sh 
bash idba-quality.sh 
bash spades-quality.sh 
bash megahit-quality.sh 
bash run-nucmer.sh 
bash run-analysis.sh 


