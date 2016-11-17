WORKDIR = /mnt/research/ged/sherine/2015-metagenome-assembly/ecoli-test
NUCMER = /mnt/home/mahmoud4/MUMmer3.23
MYSCRIPTS = /mnt/research/ged/sherine/upgrades/foo
PREFIX = ecoli
mc= 0 250 500 750 1000 2000
KAK=kak
KSIZE = 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51
MEGAHIT=/mnt/home/mahmoud4/megahit
TRIM = /opt/software/Trimmomatic/0.32
TOOLKIT =/opt/software/FASTX/0.0.14--GCC-4.4.5/bin
SANDBOX = /opt/software/khmer/2.0--GCC-4.8.2
SCRIPTS = /opt/software/khmer/2.0--GCC-4.8.2/scripts
#SANDBOX = /opt/software/khmer/khmer-1.4
#SCRIPTS =/opt/software/khmer/khmer-1.4/scripts
QUAST = ~/quast-2.3
#--------------------------------------------------------------------------------------------------------------------------------
sampling: ${WORKDIR}/SRR606429-1.fastq.gz ${WORKDIR}/SRR606429-1.fastq.gz
	gunzip -c SRR606249_1.fastq.gz | head -40000 |gzip > spodar-1.fastq.gz	
	gunzip -c SRR606249_2.fastq.gz | head -40000 |gzip > spodar-2.fastq.gz
#-----------------------------------------------------------All quality-------------------------------------------------------------------------------------
quality: ${WORKDIR}/ecoli-1.fastq.gz  ${WORKDIR}/ecoli-2.fastq.gz \
	ecoli.se.fq.gz \
	ecoli.se.qc.fq.gz \
	ecoli.pe.qc.fq.gz.pe \
	protocol-quality-rename-1 \
	protocol-quality-rename-1 
#-------------------------------------------------SPAdes Quality----------------------------------------------------------------------------------------
spades-quality: ecoli.pe.qc.fq.gz \
	ecoli.spades.d/scaffolds.fasta \
	spades-quality-assembly.fa 

#-------------------------------------------------IDBA Quality----------------------------------------------------------------------------------------
idba-quality: ecoli.pe.qc.fq.gz \
	ecoli.pe.fa \
	ecoli.idba.d.qc/scaffold.fa \
	idba-quality-assembly.fa 
#------------------------------------------------Megahit Quality-------------------------------------------------------------------------------------------- 
megahit-quality: ecoli.pe.qc.fq.gz \
	megahit.qc.pe/final.contigs.fa \
	megahit-quality-assembly.fa  
#-----------------------------------------------------------QUALITY STARTS-------------------------------------------------------------------------------
ecoli.se.fq.gz:  ${WORKDIR}/ecoli-1.fastq.gz  ${WORKDIR}/ecoli-2.fastq.gz
	java -jar ${TRIM}/trimmomatic-0.32.jar PE ${WORKDIR}/ecoli-1.fastq.gz  ${WORKDIR}/ecoli-2.fastq.gz  s1_pe s1_se s2_pe s2_se ILLUMINACLIP:${TRIM}/adapters/TruSeq2-PE.fa:2:30:12 
	${SCRIPTS}/interleave-reads.py s1_pe s2_pe | gzip -9c > ecoli.pe.fq.gz 
	cat s1_se s2_se | gzip -9c > ecoli.se.fq.gz

ecoli.se.qc.fq.gz: ecoli.se.fq.gz 
	gunzip -c ecoli.pe.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ecoli.pe.qc.fq.gz 
	gunzip -c ecoli.se.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ecoli.se.qc.fq.gz

ecoli.pe.qc.fq.gz.pe: ecoli.se.qc.fq.gz 
	extract-paired-reads.py ecoli.pe.qc.fq.gz 

protocol-quality-rename-1: ecoli.pe.qc.fq.gz.pe
	./qc-rename-1.sh && touch protocol-quality-rename-1


protocol-quality-rename-2: ecoli.pe.qc.fq.gz.pe 
	./qc-rename-2.sh && touch protocol-quality-rename-2

#-------------------------------------------------------------SPADES QUALITY---------------------------------------------------------------------------------
ecoli.spades.d/scaffolds.fasta:  ecoli.pe.qc.fq.gz 
	/usr/bin/time -a -o sqc.txt  /mnt/home/mahmoud4/SPAdes-3.9.0-Linux/bin/spades.py --meta --pe1-12 ecoli.pe.qc.fq.gz -o ecoli.spades.d    

spades-quality-assembly.fa: ecoli.spades.d/scaffolds.fasta  
	python ${SANDBOX}/sandbox/calc-best-assembly.py ecoli.spades.d/scaffolds.fasta -o spades-quality-best.fa
	python ${SANDBOX}/sandbox/sandbox/multi-rename.py assembly spades-quality-best.fa > spades-quality-assembly.fa
#-----------------------------------------------------------------IDBA QUALITY-------------------------------------------------------------------------------
ecoli.pe.fa: ecoli.pe.qc.fq.gz
	fastq-to-fasta.py ecoli.pe.qc.fq.gz >ecoli.pe.fa 
ecoli.idba.d.qc/scaffold.fa: ecoli.pe.fa
	/usr/bin/time -a -o iqc.txt idba_ud --pre_correction -r ecoli.pe.fa -o ecoli.idba.d.qc 

idba-quality-assembly.fa: ecoli.idba.d.qc/scaffold.fa
	python ${SANDBOX}/sandbox/calc-best-assembly.py ecoli.idba.d.qc/scaffold.fa -o idba-quality-best.fa 
	python ${SANDBOX}/sandbox/multi-rename.py assembly idba-quality-best.fa > idba-quality-assembly.fa
#---------------------------------------------------------------Megahit Quality------------------------------------------------------------------------------
megahit.qc.pe/final.contigs.fa: ecoli.pe.qc.fq.gz ecoli.se.qc.fq.gz  
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ecoli.pe.qc.fq.gz -o megahit.qc.pe 
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ecoli.se.qc.fq.gz -o megahit.qc.se
megahit-quality-assembly.fa: megahit.qc.pe/final.contigs.fa 
	cat megahit.qc.pe/final.contigs.fa megahit.qc.se/final.contigs.fa > megahit-quality-assembly.fa
#----------------------------------------------------------------DIGINORM STARTS-----------------------------------------------------------------------------
protocol-diginorm-C20: ecoli.pe.qc.fq.gz ecoli.se.qc.fq.gz
	normalize-by-median.py -p -k 20 -C 20 -N 4 -x 1e9 --savegraph normC20k20.kh *.pe.qc.fq.gz
	normalize-by-median.py -C 20 --loadgraph normC20k20.kh --savegraph normC20k20.kh *.se.qc.fq.gz

protocol-diginorm-filter: normC20k20.kh
	filter-abund.py -V normC20k20.kh *.keep 

protocol-diginorm-extract: 
	./extract.sh 
	touch protocol-diginorm-extract
protocol-diginorm-C5:
	normalize-by-median.py -C 5 -k 20 -N 4 -x 1e9 --savegraph normC5k20.kh -p *.pe.qc.fq.gz.keep.abundfilt.pe 
	normalize-by-median.py -C 5 --savegraph normC5k20.kh --loadgraph normC5k20.kh *.pe.qc.fq.gz.keep.abundfilt.se *.se.qc.fq.gz.keep.abundfilt

protocol-diginorm-combine-pe-se:
	cat ${WORKDIR}/ecoli.pe.qc.fq.gz.keep.abundfilt.pe > ${WORKDIR}/ecoli.pe.kak.qc.fq.gz
	cat ${WORKDIR}/ecoli.pe.qc.fq.gz.keep.abundfilt.se ${WORKDIR}/ecoli.se.qc.fq.gz.keep.abundfilt > ${WORKDIR}/ecoli.se.kak.qc.fq.gz 
#---------------------------------------------------------------SPADES DIGINORM------------------------------------------------------------------------------
spades-diginorm-1:*.pe.kak.qc.fq.gz
	./spades-dig.sh \
	touch spades-diginorm-1

spades-diginorm-2: ecoli.pe.kak.qc.fq.gz ecoli.se.kak.qc.fq.gz
	/usr/bin/time -a -o sdig.txt spades.py --sc --pe1-12 ecoli.pe.kak.qc.fq.gz -o ecoli.pe.kak.qc.spades.d
	/usr/bin/time -a -o sdig.txt spades.py --sc --pe1-12 ecoli.se.kak.qc.fq.gz -o ecoli.se.kak.qc.spades.d
	
finalize-spades-diginorm:  ecoli.spades.d/contigs.fasta 
	python ${SANDBOX}/sandbox/calc-best-assembly.py ecoli.*e.kak.qc.spades.d/contigs.fasta -o spades-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly spades-diginorm-best.fa > spades-diginorm-assembly.fa
#------------------------------------------------------------------IDBA DIGINORM-----------------------------------------------------------------------------
idba-diginorm-1: *.pe.kak.qc.fq.gz  
	./idba-dig.sh \
	touch idba-diginorm-1

idba-diginorm-2: ecoli.pe.kak.fa 
	/usr/bin/time -a -o idig.txt idba_ud --pre_correction -r ecoli.pe.kak.fa  -o ecoli.idba.d.digi
	#/opt/software/IDBAUD/1.1.0--GCC-4.4.5/bin/idba  --pre_correction -r ecoli.pe.kak.fa  -o ecoli.idba.d.digi

finalize-idba-diginorm: ecoli.idba.d.digi/scaffold.fa	
	python ${SANDBOX}/sandbox/calc-best-assembly.py ecoli.idba.d.digi/scaffold.fa -o idba-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly idba-diginorm-best.fa > idba-diginorm-assembly.fa
#-------------------------------------------------------------Megahit DIGINORM------------------------------------------------------------------------------
megahit-digi-1:
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ecoli.pe.kak.qc.fq.gz -o megahit.digi.pe
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ecoli.se.kak.qc.fq.gz -o megahit.digi.se

#------------------------------------------------------------------PARTITION STARTS--------------------------------------------------------------------------
protocol-partition-below: normC5k20.kh *.kak.*.fq.gz
	python ${SANDBOX}/sandbox/filter-below-abund.py normC5k20.kh *.kak.*.fq.gz 


protocol-partition-rename-1: ecoli.pe.kak.qc.fq.gz.below ecoli.se.kak.qc.fq.gz.below
	mv ecoli.pe.kak.qc.fq.gz.below  ecoli.pe.kak.qc.fq.gz.below.fq &&  mv ecoli.se.kak.qc.fq.gz.below ecoli.se.kak.qc.fq.gz.below.fq 

protocol-partition-run: normC5k20.kh ecoli.pe.kak.qc.fq.gz.below.fq  ecoli.se.kak.qc.fq.gz.below.fq 
	do-partition.py -k 32 -x 1e9 --threads 4 kak *.kak.qc.fq.gz.below.fq


protocol-partition-extract: *.part  
	extract-partitions.py -X 100000 kak *.part


protocol-partition-rename-2:  
	./seperate.sh \
	touch protocol-partition-rename-2

protocol-partition-compress: 
	gzip *.pe.fq  *.se.fq

#------------------------------------------------------------------Spades Partition--------------------------------------------------------------------------
spades-partition-1: kak*.pe.fq.gz
	./spades-part.sh \
	touch spades-partition-1

spades-partition-2: *.pe.fq
	./spades-part-run.sh \
	touch spades-partition-2

spades-partition-3: kak.group*.pe.fq.gz
	./spades-part-finalize.sh \
	touch spades-partition-3

finalize-spades-partition: 
	python ${SANDBOX}/sandbox/multi-rename.py assembly spades-partition-best.group*.fa > spades-partition-assembly.fa
#------------------------------------------------------------------IDBA Partition-----------------------------------------------------------------------------
idba-partition-1: kak*.pe.fq.gz
	./idba-part.sh \
	touch idba-partition-1

idba-partition-2: *.pe.fa 
	./idba-part-run.sh \
	touch idba-partition-2

idba-partition-3: kak.group*.pe.fq.gz
	./idba-part-finalize.sh \
	touch idba-partition-3

finalize-idba-partition:
	python ${SANDBOX}/sandbox/multi-rename.py assembly idba-partition-best.group*.fa > idba-partition-assembly.fa
#-------------------------------------------------------------------Megahit PARTITION------------------------------------------------------------------------
megahit-part-1: 
	./megahit-part.sh \
        touch megahit-part-1

megahit-part-2:
	./megahit-part-finalize.sh \
        touch megahit-part-2
#-------------------------------------------------------------------Analysis--------------------------------------------------------------------------------
megahit-quality-assembly500.fa: ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/spades-quality-assembly.fa ${WORKDIR}/megahit-quality-assembly.fa 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${WORKDIR}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 500	
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${WORKDIR}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 500 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${WORKDIR}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 500 

mqc500.coords: ${WORKDIR}/idba-quality-assembly500.fa  ${WORKDIR}/spades-quality-assembly500.fa  ${WORKDIR}/megahit-quality-assembly500.fa 
	${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc500 ${WORKDIR}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc500 ${WORKDIR}/mircea.fa ${WORKDIR}/spades-quality-assembly500.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/mqc500 ${WORKDIR}/mircea.fa ${WORKDIR}/megahit-quality-assembly500.fa

asseblies.QC.NOOVERLAP.99:
	python ${MYSCRIPTS}/analyze_assembly.py ${WORKDIR}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly500.fa \
        ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/iqc500.coords ${WORKDIR}/sqc500.coords ${WORKDIR}/mqc500.coords QC.AMBIGUOUS.99 -a True 99 
	
	python ${MYSCRIPTS}/analyze_assembly.py ${WORKDIR}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly500.fa \
        ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/iqc500.coords ${WORKDIR}/sqc500.coords ${WORKDIR}/mqc500.coords QC.BESTHIT5.99 -b True 99
	
	python ${MYSCRIPTS}/analyze_assembly.py ${WORKDIR}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly500.fa \
        ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/iqc500.coords ${WORKDIR}/sqc500.coords ${WORKDIR}/mqc500.coords QC.NOOVERLAP.99 -c True 99
	
#----------------------------------------------------------------Reads Coverage-----------------------------------------------------------------------------
qc-ref.bam: ${WORKDIR}/ecoli.pe.qc.fq.gz ${WORKDIR}/ecoli.se.qc.fq.gz ${WORKDIR}/mircea.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/ecoli.pe.qc.fq.gz   > ${WORKDIR}/qc-ref.pe.sai 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/ecoli.se.qc.fq.gz   > ${WORKDIR}/qc-ref.se.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.pe.sai ${WORKDIR}/ecoli.pe.qc.fq.gz > ${WORKDIR}/qc-ref.pe.sam 
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.se.sai ${WORKDIR}/ecoli.se.qc.fq.gz > ${WORKDIR}/qc-ref.se.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/qc-ref.pe.sam ${WORKDIR}/qc-ref.pe.bam 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/qc-ref.se.sam ${WORKDIR}/qc-ref.se.bam 
	samtools merge ${WORKDIR}/qc-ref.bam ${WORKDIR}/qc-ref.pe.bam ${WORKDIR}/qc-ref.se.bam 
	samtools view -h -o ${WORKDIR}/qc-ref.sam ${WORKDIR}/qc-ref.bam

unmapped-qc-to-ref: 
	samtools view -h -o ${WORKDIR}/qc-ref.pe.sam ${WORKDIR}/qc-ref.pe.bam
	samtools view -h -c -f 4 ${WORKDIR}/qc-ref.pe.bam >> unmapped-qc-to-ref 
	samtools view -h -o ${WORKDIR}/qc-ref.se.sam ${WORKDIR}/qc-ref.se.bam
	samtools view -h -c -f 4 ${WORKDIR}/qc-ref.se.bam >> unmapped-qc-to-ref 

ecoli.qc.coverage: ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.sam
	python coverage-profile.py ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.sam ${WORKDIR}/ecoli.qc.coverage 

#-------------------------------------------------------------READ INCORPORATION---------------------------------------------
iq-unmapped.count: ${WORKDIR}/ecoli.pe.qc.fq.gz ${WORKDIR}/ecoli.se.qc.fq.gz ${WORKDIR}/idba-quality-assembly500.fa
	bwa index ${WORKDIR}/idba-quality-assembly500.fa 
	bwa aln ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/ecoli.pe.qc.fq.gz   > ${WORKDIR}/iq.pe.sai 
	bwa aln ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/ecoli.se.qc.fq.gz   > ${WORKDIR}/iq.se.sai 
	bwa samse ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/iq.pe.sai ${WORKDIR}/ecoli.pe.qc.fq.gz > ${WORKDIR}/iq.pe.sam 
	bwa samse ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/iq.se.sai ${WORKDIR}/ecoli.se.qc.fq.gz > ${WORKDIR}/iq.se.sam
	samtools faidx ${WORKDIR}/idba-quality-assembly500.fa 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.pe.sam ${WORKDIR}/iq.pe.bam 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.se.sam ${WORKDIR}/iq.se.bam 
	samtools faidx ${WORKDIR}/idba-quality-assembly500.fa 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.pe.sam ${WORKDIR}/iq.pe.bam 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.se.sam ${WORKDIR}/iq.se.bam 
	samtools view -c -f 4 ${WORKDIR}/iq.pe.bam > ${WORKDIR}/iq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/iq.se.bam >> ${WORKDIR}/iq-unmapped.count 

sq-unmapped.count:  ${WORKDIR}/ecoli.pe.qc.fq.gz ${WORKDIR}/ecoli.se.qc.fq.gz ${WORKDIR}/spades-quality-assembly500.fa
	bwa index ${WORKDIR}/spades-quality-assembly500.fa 
	bwa aln ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/ecoli.pe.qc.fq.gz   > ${WORKDIR}/sq.pe.sai 
	bwa aln ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/ecoli.se.qc.fq.gz   > ${WORKDIR}/sq.se.sai 
	bwa samse ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/sq.pe.sai ${WORKDIR}/ecoli.pe.qc.fq.gz > ${WORKDIR}/sq.pe.sam 
	bwa samse ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/sq.se.sai ${WORKDIR}/ecoli.se.qc.fq.gz > ${WORKDIR}/sq.se.sam 
	samtools faidx ${WORKDIR}/spades-quality-assembly500.fa 
	samtools import ${WORKDIR}/spades-quality-assembly500.fa.fai ${WORKDIR}/sq.pe.sam ${WORKDIR}/sq.pe.bam 
	samtools import ${WORKDIR}/spades-quality-assembly500.fa.fai ${WORKDIR}/sq.se.sam ${WORKDIR}/sq.se.bam 
	samtools view -c -f 4 ${WORKDIR}/sq.pe.bam > ${WORKDIR}/sq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/sq.se.bam >> ${WORKDIR}/sq-unmapped.count

mq-unmapped.count:  ${WORKDIR}/ecoli.pe.qc.fq.gz ${WORKDIR}/ecoli.se.qc.fq.gz ${WORKDIR}/megahit-quality-assembly500.fa
	bwa index ${WORKDIR}/megahit-quality-assembly500.fa 
	bwa aln ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/ecoli.pe.qc.fq.gz   > ${WORKDIR}/mq.pe.sai 	
	bwa aln ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/ecoli.se.qc.fq.gz   > ${WORKDIR}/mq.se.sai 
	bwa samse ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/mq.pe.sai ${WORKDIR}/ecoli.pe.qc.fq.gz > ${WORKDIR}/mq.pe.sam 
	bwa samse ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/mq.se.sai ${WORKDIR}/ecoli.se.qc.fq.gz > ${WORKDIR}/mq.se.sam 
	samtools faidx ${WORKDIR}/megahit-quality-assembly500.fa 
	samtools import ${WORKDIR}/megahit-quality-assembly500.fa.fai ${WORKDIR}/mq.pe.sam ${WORKDIR}/mq.pe.bam 
	samtools import ${WORKDIR}/megahit-quality-assembly500.fa.fai ${WORKDIR}/mq.se.sam ${WORKDIR}/mq.se.bam 
	samtools view -c -f 4 ${WORKDIR}/mq.pe.bam > ${WORKDIR}/mq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/mq.se.bam >> ${WORKDIR}/mq-unmapped.count

#--------------------------------------------------------Unaligned Coverage Profile--------------------------------------------------------------------
iqc.AM99-mapped-reads: 
	cat Niqc500.QC.AMBIGIOUS500.99.unaligned > iqc.AM99.fa   
	bwa index ${WORKDIR}/iqc.AM99.fa
	bwa aln ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/ecoli.pe.qc.fq.gz  > ${WORKDIR}/iqc.AM99.pe.sai
	bwa aln ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/ecoli.se.qc.fq.gz  > ${WORKDIR}/iqc.AM99.se.sai
	bwa samse ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.pe.sai ${WORKDIR}/ecoli.pe.qc.fq.gz  > ${WORKDIR}/iqc.AM99.pe.sam
	bwa samse ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.se.sai ${WORKDIR}/ecoli.se.qc.fq.gz  > ${WORKDIR}/iqc.AM99.se.sam
	samtools faidx ${WORKDIR}/iqc.AM99.fa
	samtools import ${WORKDIR}/iqc.AM99.fa.fai ${WORKDIR}/iqc.AM99.pe.sam ${WORKDIR}/iqc.AM99.pe.bam 
	samtools import ${WORKDIR}/iqc.AM99.fa.fai ${WORKDIR}/iqc.AM99.se.sam ${WORKDIR}/iqc.AM99.se.bam
	samtools view -h -F 4 ${WORKDIR}/iqc.AM99.pe.bam > ${WORKDIR}/iqc.AM99.mapped.pe.bam
	samtools view -h -F 4 ${WORKDIR}/iqc.AM99.se.bam > ${WORKDIR}/iqc.AM99.mapped.se.bam
	samtools view -c -F 4 ${WORKDIR}/iqc.AM99.pe.bam > ${WORKDIR}/iqc.AM99.aligned.reads
	samtools view -c -F 4 ${WORKDIR}/iqc.AM99.se.bam >> ${WORKDIR}/iqc.AM99.aligned.reads
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/iqc.AM99.mapped.pe.bam > ${WORKDIR}/iqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/iqc.AM99.mapped.se.bam >> ${WORKDIR}/iqc.AM99.mappedreads.fa
	bwa index ${WORKDIR}/mircea.fa
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/iqc.AM99.mappedreads.fa  >${WORKDIR}/iqc.AM99.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/iqc.AM99.sai ${WORKDIR}/iqc.AM99.mappedreads.fa > ${WORKDIR}/iqc.AM99.sam
	samtools faidx ${WORKDIR}/mircea.fa
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/iqc.AM99.sam ${WORKDIR}/iqc.AM99.bam
	samtools view -c -F 4 ${WORKDIR}/iqc.AM99.bam > ${WORKDIR}/iqc.AM99-mapped-reads

iqc.AM99.unmapped.sam:  ${WORKDIR}/iqc.AM99.pe.bam ${WORKDIR}/iqc.AM99.se.bam ${WORKDIR}/iqc.AM99.fa
	samtools view -h -f 4 ${WORKDIR}/iqc.AM99.bam > ${WORKDIR}/iqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh ${WORKDIR}/iqc.AM99.unmapped.bam > ${WORKDIR}/iqc.AM99.unmappedreads.fa 
	bwa index ${WORKDIR}/iqc.AM99.fa
	bwa aln ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.unmappedreads.fa  >${WORKDIR}/iqc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.unmapped.sai ${WORKDIR}/iqc.AM99.unmappedreads.fa > ${WORKDIR}/iqc.AM99.unmapped.sam

iqc-unaligned-cov: 
	python coverage-profile.py ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.unmapped.sam iqc.unmapped.out     



unaligned-analysis-AMI-sqc:
	cat Nsqc500.QC.AMBIGIOUS500.99.unaligned > sqc.AM99.fa         
	bwa index ${WORKDIR}/sqc.AM99.fa
	bwa aln ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/ecoli.pe.qc.fq.gz  > ${WORKDIR}/sqc.AM99.pe.sai
	bwa aln ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/ecoli.se.qc.fq.gz  > ${WORKDIR}/sqc.AM99.se.sai
	bwa samse ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.pe.sai ${WORKDIR}/ecoli.pe.qc.fq.gz  > ${WORKDIR}/sqc.AM99.pe.sam 
	bwa samse ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.se.sai ${WORKDIR}/ecoli.se.qc.fq.gz  > ${WORKDIR}/sqc.AM99.se.sam
	samtools faidx ${WORKDIR}/sqc.AM99.fa
	samtools import ${WORKDIR}/sqc.AM99.fa.fai ${WORKDIR}/sqc.AM99.pe.sam ${WORKDIR}/sqc.AM99.pe.bam 
	samtools import ${WORKDIR}/sqc.AM99.fa.fai ${WORKDIR}/sqc.AM99.se.sam ${WORKDIR}/sqc.AM99.se.bam
	samtools view -h -F 4 ${WORKDIR}/sqc.AM99.pe.bam > ${WORKDIR}/sqc.AM99.mapped.pe.bam
	samtools view -h -F 4 ${WORKDIR}/sqc.AM99.se.bam > ${WORKDIR}/sqc.AM99.mapped.se.bam
	samtools view -c -F 4 ${WORKDIR}/sqc.AM99.pe.bam > ${WORKDIR}/sqc.AM99.aligned.reads   
	samtools view -c -F 4 ${WORKDIR}/sqc.AM99.se.bam >> ${WORKDIR}/sqc.AM99.aligned.reads 
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/sqc.AM99.mapped.pe.bam > ${WORKDIR}/sqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/sqc.AM99.mapped.se.bam >> ${WORKDIR}/sqc.AM99.mappedreads.fa
	bwa index ${WORKDIR}/mircea.fa
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/sqc.AM99.mappedreads.fa  >${WORKDIR}/sqc.AM99.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/sqc.AM99.sai ${WORKDIR}/sqc.AM99.mappedreads.fa > ${WORKDIR}/sqc.AM99.sam
	samtools faidx ${WORKDIR}/mircea.fa
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/sqc.AM99.sam ${WORKDIR}/sqc.AM99.bam
	samtools view -c -F 4 ${WORKDIR}/sqc.AM99.bam > ${WORKDIR}/sqc.AM99-mapped-reads

sqc-unaligned:  ${WORKDIR}/sqc.AM99.pe.bam ${WORKDIR}/sqc.AM99.se.bam ${WORKDIR}/sqc.AM99.fa
	samtools view -h -f 4 ${WORKDIR}/sqc.AM99.bam > ${WORKDIR}/sqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh ${WORKDIR}/sqc.AM99.unmapped.bam > ${WORKDIR}/sqc.AM99.unmappedreads.fa 	
	bwa index ${WORKDIR}/sqc.AM99.fa
	bwa aln ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.unmappedreads.fa  >${WORKDIR}/sqc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.unmapped.sai ${WORKDIR}/sqc.AM99.unmappedreads.fa > ${WORKDIR}/sqc.AM99.unmapped.sam

sqc-unaligned-cov: 
	python coverage-profile.py ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.unmapped.sam sqc.unmapped.out      


unaligned-analysis-AMI-mqc:
	cat Nmqc500.QC.AMBIGIOUS500.99.unaligned >mqc.AM99.fa 
	bwa index ${WORKDIR}/mqc.AM99.fa
	bwa aln ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/ecoli.pe.qc.fq.gz  > ${WORKDIR}/mqc.AM99.pe.sai
	bwa aln ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/ecoli.se.qc.fq.gz  > ${WORKDIR}/mqc.AM99.se.sai
	bwa samse ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.pe.sai ${WORKDIR}/ecoli.pe.qc.fq.gz  > ${WORKDIR}/mqc.AM99.pe.sam
	bwa samse ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.se.sai ${WORKDIR}/ecoli.se.qc.fq.gz  > ${WORKDIR}/mqc.AM99.se.sam
	samtools faidx ${WORKDIR}/mqc.AM99.fa
	samtools import ${WORKDIR}/mqc.AM99.fa.fai ${WORKDIR}/mqc.AM99.pe.sam ${WORKDIR}/mqc.AM99.pe.bam
	samtools import ${WORKDIR}/mqc.AM99.fa.fai ${WORKDIR}/mqc.AM99.se.sam ${WORKDIR}/mqc.AM99.se.bam
	samtools view -h -F 4 ${WORKDIR}/mqc.AM99.pe.bam > ${WORKDIR}/mqc.AM99.mapped.pe.bam
	samtools view -h -F 4 ${WORKDIR}/mqc.AM99.se.bam > ${WORKDIR}/mqc.AM99.mapped.se.bam
	samtools view -c -F 4 ${WORKDIR}/mqc.AM99.pe.bam > ${WORKDIR}/mqc.AM99.aligned.reads
	samtools view -c -F 4 ${WORKDIR}/mqc.AM99.se.bam >> ${WORKDIR}/mqc.AM99.aligned.reads
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/mqc.AM99.mapped.pe.bam > ${WORKDIR}/mqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/mqc.AM99.mapped.se.bam >> ${WORKDIR}/mqc.AM99.mappedreads.fa
	bwa index ${WORKDIR}/mircea.fa
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/mqc.AM99.mappedreads.fa  >${WORKDIR}/mqc.AM99.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/mqc.AM99.sai ${WORKDIR}/mqc.AM99.mappedreads.fa > ${WORKDIR}/mqc.AM99.sam
	samtools faidx ${WORKDIR}/mircea.fa
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/mqc.AM99.sam ${WORKDIR}/mqc.AM99.bam
	samtools view -c -F 4 ${WORKDIR}/mqc.AM99.bam > ${WORKDIR}/mqc.AM99-mapped-reads

mqc-unaligned:  ${WORKDIR}/mqc.AM99.pe.bam ${WORKDIR}/mqc.AM99.se.bam ${WORKDIR}/mqc.AM99.fa
	samtools view -h -f 4 ${WORKDIR}/mqc.AM99.bam > ${WORKDIR}/mqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh ${WORKDIR}/mqc.AM99.unmapped.bam > ${WORKDIR}/mqc.AM99.unmappedreads.fa 
	bwa index ${WORKDIR}/mircea.fa
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/mqc.AM99.unmappedreads.fa  >${WORKDIR}/mqc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/mqc.AM99.unmapped.sai ${WORKDIR}/mqc.AM99.unmappedreads.fa > ${WORKDIR}/mqc.AM99.unmapped.sam

mqc-unaligned-cov: 
	python coverage-profile.py ${WORKDIR}/mircea.fa ${WORKDIR}/mqc.AM99.unmapped.sam mqc.unmapped.reference     

#awk '$1 >=5 {sum += $2} END {print sum}' backup/all.unmapped.coverage
#awk '{sum += $2} END {print sum}' backup/all.unmapped.coverage 

#------------------------------------------------------------Finding Chimeric Reads--------------------------------------------------------------------------
chimeric:  ${WORKDIR}/mircea.fa ecoli.se.qc.fq.gz ecoli.pe.qc.fq.gz
	bwa index ${WORKDIR}/mircea.fa 
	bwa mem -M -t 16 ${WORKDIR}/mircea.fa ecoli.se.qc.fq.gz  > ecoli-se.sam
	bwa mem -M -t 16 ${WORKDIR}/mircea.fa ecoli.pe.qc.fq.gz  > ecoli-pe.sam
	samtools faidx ${WORKDIR}/mircea.fa
	samtools import mircea.fa.fai ecoli-pe.sam ecoli-pe.bam
	samtools import mircea.fa.fai ecoli-se.sam ecoli-se.bam
	samtools view ecoli-pe.bam | grep 'SA:'  > ecoli-pe.chimeric
	samtools view ecoli-se.bam | grep 'SA:'  > ecoli-se.chimeric
	bash count-chimeric.sh 

#---------------------------------------------------------------Cleaning ------------------------------------------------------------------------------------	
clean: *.list *.list.unique
	rm *.list 
	rm *.list.unique  
