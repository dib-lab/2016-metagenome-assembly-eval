To get the data:

    curl -O https://s3.amazonaws.com/public.ged.msu.edu/ecoli_ref-5m.fastq.gz

Prepare the data:

    split-paired-reads.py ecoli_ref-5m.fastq.gz -1 ecoli-1.fastq.gz -2 ecoli-2.fastq.gz --gzip

Download the reference:

    curl -O https://s3.amazonaws.com/public.ged.msu.edu/ecoliMG1655.fa.gz
    gunzip ecoliMG1655.fa.gz

To run the ecoli pipeline do the following after splitting the ecoli set: 
=========================================================================

bash quality.sh 2>&1 | tee quality.log 

bash pre-idba-quality.sh 2>&1 | tee idba-quality.log 

bash idba-quality.sh 2>&1 | tee -a idba-quality.log

bash spades-quality.sh  2>&1 | tee spades-quality.log

bash megahit-quality.sh 2>&1 | tee megahit-quality.log  

bash run-analysis-1.sh 2>&1 | tee run-analysis-1.log 

bash run-analysis-2.sh 2>&1 | tee run-analysis-2.log

bash run-analysis-3.sh 2>&1 | tee run-analysis-3.log 

bash annotate-prokka.sh 2>&1 | tee prokka.annotation.log 
