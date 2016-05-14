DATA = /mnt/home/mahmoud4/data
WORKDIR = /mnt/research/ged/sherine/testing-automation
MYSCRIPTS = /mnt/home/mahmoud4/scripts
NUCMER = contigs_reports/nucmer_output
PREFIX = SRR606249
N-READS-PER-FILE = 5536289548 
mc= 0 250 500 750 1000 2000
KSIZE = 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51
KAK=kak
MEGAHIT=/mnt/home/mahmoud4/megahit
TRIM = /opt/software/Trimmomatic/0.32
TOOLKIT =/opt/software/FASTX/0.0.14--GCC-4.4.5/bin/
#SANDBOX = /opt/software/khmer/khmer-1.4
#SCRIPTS =/opt/software/khmer/khmer-1.4/scripts
SANDBOX = /opt/software/khmer/2.0--GCC-4.8.2
SCRIPTS = /opt/software/khmer/2.0--GCC-4.8.2/scripts
QUAST = ~/quast-2.3
#--------------------------------------------------------------------------------------------------------------------------------
all-protocol: ${DATA}/SRR606429-1.fastq.gz ${DATA}/SRR606429-1.fastq.gz 
	quality
	diginorm
	partition
	velvet-quality
	spades-quality
	idba-quality
	velvet-diginorm
	spades-diginorm
	idba-diginorm
	velvet-partition
	spades-partition
	idba-partition
#--------------------------------------------------------------------------------------------------------------------------------
quality: ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz 
	interleaving-1
	interleaving-2
	interleaving-3
	protocol-quality-rename-1
	protocol-quality-rename-2 	
#--------------------------------------------------------------------------------------------------------------------------------
diginorm: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz 
	linking-quality
	protocol-diginorm-C20
	protocol-diginorm-filter
	protocol-diginorm-extract
	protocol-diginorm-C5
	protocol-diginorm-combine-pe-se
#--------------------------------------------------------------------------------------------------------------------------------
partition: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz 
	linking-diginorm
	protocol-partition-below
	protocol-partition-rename-1
	protocol-partition-run
	protocol-partition-extract
	protocol-partition-rename-2
	protocol-partition-compress
#--------------------------------------------Velvet Quality--------------------------------------------------------
velvet-quality:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz 
	velvet-quality-1
	finalize-velvet-quality
#---------------------------------------------IDBA Quality---------------------------------------------------------
idba-quality: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz 
	idba-quality-1
	idba-quality-2
	finalize-idba-quality	
#--------------------------------------------Spades Quality--------------------------------------------------------
spades-quality:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz
	spades-quality-1
	spades-quality-2
	finalize-spades-quality
#---------------------------------------------MEGAHIT QUALITY-----------------------------------------
megahit-quality: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz
	megahit-qc-1
	finalize-megahit-quality
#----------------------------------------------Velvet Diginorm---------------------------------------------------------
velvet-diginorm: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz
	velvet-diginorm-1
	finalize-velvet-diginorm 
#----------------------------------------------IDBA Diginorm----------------------------------------------------------
idba-diginorm: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz
	idba-diginorm-1
	idba-diginorm-2
	finalize-idba-diginorm 
#----------------------------------------------Spades Diginorm---------------------------------------------------------
spades-diginorm: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz
	spades-diginorm-1
	spades-diginorm-2
	finalize-spades-diginorm  
#---------------------------------------------Megahit Diginorm----------------------------------------------------------
megahit-diginorm: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz
	megahit-digi-1
	finalize-megahit-diginorm 
#------------------------------------------------Velvet  Partition-------------------------------------------------------------
velvet-partition:  ${WORKDIR}/normC5k20.kh 
	velvet-partition-1
	velvet-partition-2
	finalize-velvet-partition 
#-------------------------------------------------Spades Partition-------------------------------------------------------------
spades-partition:  ${WORKDIR}/normC5k20.kh  
	spades-partition-1
	spades-partition-2
	spades-partition-3
	finalize-spades-partition 
#--------------------------------------------------IDBA Partition--------------------------------------------------------------
idba-partition:  ${WORKDIR}/normC5k20.kh 
	idba-partition-1
	idba-partition-2
	idba-partition-3
	finalize-idba-partition
#---------------------------------------------------Megahit Partition------------------------------------------------------------
megahit-partition:  ${WORKDIR}/normC5k20.kh 
	megahit-part-1
	megahit-part-2
	finalize-megahit-partition
#----------------------------------------------------------------QUALITY STARTS-------------------------------------------------------------------------------
interleaving-1: ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz
	java -jar ${TRIM}/trimmomatic-0.32.jar PE ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz  s1_pe s1_se s2_pe s2_se ILLUMINACLIP:${TRIM}/adapters/TruSeq2-PE.fa:2:30:12 
	${SCRIPTS}/interleave-reads.py s1_pe s2_pe | gzip -9c > ${WORKDIR}/${PREFIX}.pe.fq.gz
	cat s1_se s2_se | gzip -9c > ${WORKDIR}/${PREFIX}.se.fq.gz

interleaving-2: ${WORKDIR}/${PREFIX}.se.fq.gz ${WORKDIR}/${PREFIX}.pe.fq.gz
	gunzip -c ${WORKDIR}/${PREFIX}.pe.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${WORKDIR}/${PREFIX}.pe.qc.fq.gz 
	gunzip -c ${WORKDIR}/${PREFIX}.se.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${WORKDIR}/${PREFIX}.se.qc.fq.gz

interleaving-3: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	extract-paired-reads.py ${WORKDIR}/${PREFIX}.pe.qc.fq.gz 

protocol-quality-rename-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz.pe
	./qc-rename-1.sh 
	touch protocol-quality-rename-1


protocol-quality-rename-2: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz.se
	./qc-rename-2.sh 
	touch protocol-quality-rename-2

#----------------------------------------------------------------VELVET QUALITY ------------------------------------------------------------------------------
velvet-quality-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  
	./velvet-qc.sh 
	touch velvet-quality-1

finalize-velvet-quality: ${WORKDIR}/${PREFIX}.velvet.qc.*.d/contigs.fa 
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/${PREFIX}.velvet.qc.*.d/contigs.fa -o ${WORKDIR}/velvet-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly  ${WORKDIR}/velvet-quality-best.fa > ${WORKDIR}/velvet-quality-assembly.fa

#--------------------------------------------------------------SPADES QUALITY---------------------------------------------------------------------------------
spades-quality-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	./spades-qc.sh \
	touch spades-quality-1

spades-quality-2:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	/usr/bin/time -a -o ${WORKDIR}/sqc.txt spades.py --sc --pe1-12 ${WORKDIR}/${PREFIX}.pe.qc.fq.gz -o ${WORKDIR}/${PREFIX}.spades.d 

finalize-spades-quality: ${WORKDIR}/${PREFIX}.spades.d/contigs.fasta
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/${PREFIX}.spades.d/contigs.fasta -o ${WORKDIR}/spades-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/spades-quality-best.fa > ${WORKDIR}/spades-quality-assembly.fa
#------------------------------------------------------------------IDBA QUALITY-------------------------------------------------------------------------------
idba-quality-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	./idba-qc.sh && touch idba-quality-1

idba-quality-2: ${WORKDIR}/${PREFIX}.pe.fa
	/usr/bin/time -a -o ${WORKDIR}/iqc.txt idba_ud --pre_correction -r ${WORKDIR}/${PREFIX}.pe.fa -o ${WORKDIR}/${PREFIX}.idba.d.qc 

finalize-idba-quality: ${WORKDIR}/${PREFIX}.idba.d.qc/scaffold.fa
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/${PREFIX}.idba.d.qc/scaffold.fa -o ${WORKDIR}/idba-quality-best.fa 
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/idba-quality-best.fa > ${WORKDIR}/idba-quality-assembly.fa

#----------------------------------------------------------------Megahit Quality------------------------------------------------------------------------------
megahit-qc-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz
	/usr/bin/time  -a  -o ${WORKDIR}/megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${WORKDIR}/${PREFIX}.pe.qc.fq.gz -o ${WORKDIR}/megahit.qc.pe \
	/usr/bin/time  -a  -o ${WORKDIR}/megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${WORKDIR}/${PREFIX}.se.qc.fq.gz -o ${WORKDIR}/megahit.qc.se
finalize-megahit-quality:  ${WORKDIR}/megahit.qc.pe/final.contigs.fa ${WORKDIR}/megahit.qc.se/final.contigs.fa 
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/megahit.qc.?e/final.contigs.fa -o ${WORKDIR}/megahit-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/megahit-quality-best.fa > ${WORKDIR}/megahit-quality-assembly.fa        
#-----------------------------------------------------------------DIGINORM STARTS-----------------------------------------------------------------------------
protocol-diginorm-C20: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz
	normalize-by-median.py -p -k 20 -C 20 -N 4 -x 1e9 --savetable ${WORKDIR}/normC20k20.kh ${WORKDIR}/*.pe.qc.fq.gz
	normalize-by-median.py -C 20 --loadtable ${WORKDIR}/normC20k20.kh --savetable ${WORKDIR}/normC20k20.kh ${WORKDIR}/*.se.qc.fq.gz

protocol-diginorm-filter: ${WORKDIR}/normC20k20.kh
	filter-abund.py -V ${WORKDIR}/normC20k20.kh ${WORKDIR}/*.keep 

protocol-diginorm-extract: 
	./extract.sh 
	touch protocol-diginorm-extract
protocol-diginorm-C5: ${WORKDIR}/normC5k20.kh 
	normalize-by-median.py -C 5 -k 20 -N 4 -x 1e9 --savetable ${WORKDIR}/normC5k20.kh -p ${WORKDIR}/*.pe.qc.fq.gz.keep.abundfilt.pe 
	normalize-by-median.py -C 5 --savetable ${WORKDIR}/normC5k20.kh --loadtable ${WORKDIR}/normC5k20.kh ${WORKDIR}/*.pe.qc.fq.gz.keep.abundfilt.se ${WORKDIR}/*.se.qc.fq.gz.keep.abundfilt

protocol-diginorm-combine-pe-se:
	./diginorm-combine-pe.sh && ./diginorm-combine-se.sh \
	touch protocol-diginorm-combine-pe-se
#----------------------------------------------------------------VELVET DIGINORM-----------------------------------------------------------------------------
velvet-diginorm-1: $(foreach k,$(KSIZE),$(subst KSIZE,$k,${PREFIX}.velvet.digi.KSIZE.d))

${PREFIX}.velvet.digi.%.d: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz 
	/usr/bin/time -a -o ${WORKDIR}/vdig.txt velveth $@ $* -fastq.gz -shortPaired $< -short $(word 2,$^) && velvetg $@ -exp_cov auto -cov_cutoff auto

finalize-velvet-diginorm: ${WORKDIR}/${PREFIX}.velvet.digi.*.d/contigs.fa 
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/${PREFIX}.velvet.digi.*.d/contigs.fa -o ${WORKDIR}/velvet-diginorm-best.fa 
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/velvet-diginorm-best.fa > ${WORKDIR}/velvet-diginorm-assembly.fa 
#----------------------------------------------------------------SPADES DIGINORM------------------------------------------------------------------------------
spades-diginorm-1:${WORKDIR}/*.pe.kak.qc.fq.gz
	./spades-dig.sh \
	touch spades-diginorm-1

#spades-diginorm-1: ${WORKDIR}/${PREFIX}.%.pe.kak.qc.fq.gz	
	#gunzip -c $< > $<.gz

spades-diginorm-2: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz
	/usr/bin/time -a -o ${WORKDIR}/sdig.txt spades.py --sc --pe1-12 ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz -o ${WORKDIR}/${PREFIX}.pe.kak.qc.spades.d
	/usr/bin/time -a -o ${WORKDIR}/sdig.txt spades.py --sc --pe1-12 ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz -o ${WORKDIR}/${PREFIX}.se.kak.qc.spades.d
        
finalize-spades-diginorm: ${WORKDIR}/${PREFIX}.spades.d/contigs.fasta
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/${PREFIX}.pe.kak.qc.spades.d/contigs.fasta -o ${WORKDIR}/spades-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/spades-diginorm-best.fa > ${WORKDIR}/spades-diginorm-assembly.fa
#-------------------------------------------------------------------IDBA DIGINORM-----------------------------------------------------------------------------
idba-diginorm-1: ${WORKDIR}/*.pe.kak.qc.fq.gz  
	./idba-dig.sh \
	touch idba-diginorm-2

idba-diginorm-2: ${WORKDIR}/${PREFIX}.pe.kak.fa 
	/usr/bin/time -a -o ${WORKDIR}/idig.txt idba_ud --pre_correction -r ${WORKDIR}/${PREFIX}.pe.kak.fa  -o ${WORKDIR}/${PREFIX}.idba.d.digi

finalize-idba-diginorm: ${WORKDIR}/${PREFIX}.idba.d.digi/scaffold.fa	
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/${PREFIX}.idba.d.digi/scaffold.fa -o ${WORKDIR}/idba-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/idba-diginorm-best.fa > ${WORKDIR}/idba-diginorm-assembly.fa
#---------------------------------------------------------------Megahit DIGINORM------------------------------------------------------------------------------
megahit-digi-1: ${WORKDIR}/*.pe.kak.qc.fq.gz
	/usr/bin/time  -a  -o ${WORKDIR}/megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz -o ${WORKDIR}/megahit.digi.pe
	/usr/bin/time  -a  -o ${WORKDIR}/megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz -o ${WORKDIR}/megahit.digi.se
finalize-megahit-diginorm: ${WORKDIR}/megahit.digi.pe/final.contigs.fa  ${WORKDIR}/megahit.digi.se/final.contigs.fa
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/megahit.digi.?e/final.contigs.fa  -o ${WORKDIR}/megahit-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/megahit-diginorm-best.fa > ${WORKDIR}/megahit-diginorm-assembly.fa
#-------------------------------------------------------------------PARTITION STARTS--------------------------------------------------------------------------
protocol-partition-below:  ${WORKDIR}/normC5k20.kh  ${WORKDIR}/kak*.pe.fq.gz  ${WORKDIR}/kak*.se.fq.gz
	python ${SANDBOX}/sandbox/filter-below-abund.py ${WORKDIR}/normC5k20.kh ${WORKDIR}/*.kak.*.fq.gz 
protocol-partition-rename-1: 
	mv ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz.below  ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz.below.fq &&  mv ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz.below ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz.below.fq 

protocol-partition-run: 
	do-partition.py -k 32 -x 1e9 --threads 4 kak ${WORKDIR}/*.kak.qc.fq.gz.below.fq


protocol-partition-extract:  
	extract-partitions.py -X 100000 kak ${WORKDIR}/*.part


protocol-partition-rename-2:  
	./seperate.sh \
	touch protocol-partition-rename-2

protocol-partition-compress: 
	gzip ${WORKDIR}/*.pe.fq  ${WORKDIR}/*.se.fq

#-----------------------------------Velvet Partition-------------------------------------------------------------------------
velvet-partition-1: ${WORKDIR}/kak.group*.pe.fq.gz  ${WORKDIR}/kak.group*.se.fq.gz
	./velvet-part.sh \
	touch velvet-partition-1

velvet-partition-2: 
	./velvet-part-finalize.sh \
	touch velvet-partition-2
finalize-velvet-partition: ${WORKDIR}/velvet-partition-best.group*.fa
	        python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/velvet-partition-best.group*.fa > ${WORKDIR}/velvet-partition-assembly.fa

#-------------------------------------------------------------------Spades Partition--------------------------------------------------------------------------
spades-partition-1: ${WORKDIR}/kak.group*.pe.fq.gz  ${WORKDIR}/kak.group*.se.fq.gz
	./spades-part.sh \
	touch spades-partition-1

spades-partition-2: ${WORKDIR}/*.pe.fq
	./spades-part-run.sh \
	touch spades-partition-2

spades-partition-3: 
	./spades-part-finalize.sh \
	touch spades-partition-3

finalize-spades-partition:  ${WORKDIR}/spades-partition-best.group*.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/spades-partition-best.group*.fa > ${WORKDIR}/spades-partition-assembly.fa
#------------------------------------------------------------------IDBA Partition-----------------------------------------------------------------------------
idba-partition-1: ${WORKDIR}/kak.group*.pe.fq.gz  ${WORKDIR}/kak.group*.se.fq.gz 
	./idba-part.sh \
	touch idba-partition-1

idba-partition-2: 
	./idba-part-run.sh \
	touch idba-partition-2

idba-partition-3: 
	./idba-part-finalize.sh \
	touch idba-partition-3

finalize-idba-partition: ${WORKDIR}/idba-partition-best.group*.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/idba-partition-best.group*.fa > ${WORKDIR}/idba-partition-assembly.fa
#--------------------------------------------------------------------Megahit PARTITION------------------------------------------------------------------------
megahit-part-1: ${WORKDIR}/kak.group*.pe.fq.gz  ${WORKDIR}/kak.group*.se.fq.gz 
	./megahit-part.sh \
	touch megahit-part-1

megahit-part-2:
	./megahit-part-finalize.sh \
	touch megahit-part-2
finalize-megahit-partition:
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/megahit-partition-best*.fa > ${WORKDIR}/megahit-partition-assembly.fa

#-------------------------------------------------------------------QUAST------------------------------------------------------------------------------------
quasting-2-ref: ${WORKDIR}/*-assembly.fa   ${DATA}/mircea.fa.gz 
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/velvet-quality-quast/ ${WORKDIR}/velvet-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/idba-quality-quast/ ${WORKDIR}/idba-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/spades-quality-quast/ ${WORKDIR}/spades-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/megahit-quality-quast/ ${WORKDIR}/megahit-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/velvet-diginorm-quast/ ${WORKDIR}/velvet-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/idba-diginorm-quast/ ${WORKDIR}/idba-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/spades-diginorm-quast/ ${WORKDIR}/spades-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/megahit-diginorm-quast/ ${WORKDIR}/megahit-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/velvet-partition-quast/ ${WORKDIR}/velvet-partition-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.ga -o ${WORKDIR}/velvet-partition-quast/ ${WORKDIR}/velvet-partition-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/spades-partition-quast/ ${WORKDIR}/spades-partition-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${WORKDIR}/megahit-partition-quast/ ${WORKDIR}/megahit-partition-assembly.fa 

quasting-2-assembly: ${WORKDIR}/*-assembly.fa ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/velvet-quality-assembly.fa -o ref-velvet-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/idba-quality-assembly.fa -o ref-idba-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/spades-quality-assembly.fa -o ref-spades-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/megahit-quality-assembly.fa -o ref-megahit-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/velvet-diginorm-assembly.fa -o ref-velvet-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/idba-diginorm-assembly.fa -o ref-idba-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/spades-diginorm-assembly.fa -o ref-spades-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/megahit-diginorm-assembly.fa -o ref-megahit-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/velvet-partition-assembly.fa -o ref-velvet-partition-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/idba-partition-assembly.fa -o ref-idba-partition-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/spades-partition-assembly.fa -o ref-spades-partition-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${WORKDIR}/megahit-partition-assembly.fa -o ref-megahit-partition-quast/ ${DATA}/mircea.fa.gz

#------------------------NEW----------------------Read Incorporation Experiment-------------------------------------------------------------------------------
#------------------------NEW----------------------------------Mapping-------------------------------------------------------------------------------------
reads-to-vqc: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/velvet-quality-assembly.fa
	bwa index ${WORKDIR}/velvet-quality-assembly.fa 
	bwa aln ${WORKDIR}/velvet-quality-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/vq.pe.sai 
	bwa aln ${WORKDIR}/velvet-quality-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/vq.se.sai 
	bwa samse ${WORKDIR}/velvet-quality-assembly.fa ${WORKDIR}/vq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/vq.pe.sam 
	bwa samse ${WORKDIR}/velvet-quality-assembly.fa ${WORKDIR}/vq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/vq.se.sam 
	samtools faidx ${WORKDIR}/velvet-quality-assembly.fa 
	samtools import ${WORKDIR}/velvet-quality-assembly.fa.fai ${WORKDIR}/vq.pe.sam ${WORKDIR}/vq.pe.bam 
	samtools import ${WORKDIR}/velvet-quality-assembly.fa.fai ${WORKDIR}/vq.se.sam ${WORKDIR}/vq.se.bam 
	#cat ${WORKDIR}/vq.pe.bam ${WORKDIR}/vq.se.bam > ${WORKDIR}/vq.bam 
	#cat ${WORKDIR}/vq.pe.sam ${WORKDIR}/vq.se.sam > ${WORKDIR}/vq.sam
	samtools view -c -f 4 ${WORKDIR}/vq.pe.bam > ${WORKDIR}/vq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/vq.se.bam >> ${WORKDIR}/vq-unmapped.count

 

reads-to-vdigi: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz  ${WORKDIR}/velvet-diginorm-assembly.fa 
	bwa index ${WORKDIR}/velvet-diginorm-assembly.fa
	bwa aln ${WORKDIR}/velvet-diginorm-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/vd.pe.sai 
	bwa aln ${WORKDIR}/velvet-diginorm-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/vd.se.sai 
	bwa samse ${WORKDIR}/velvet-diginorm-assembly.fa ${WORKDIR}/vd.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/vd.pe.sam 
	bwa samse ${WORKDIR}/velvet-diginorm-assembly.fa ${WORKDIR}/vd.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/vd.se.sam 
	samtools faidx ${WORKDIR}/velvet-diginorm-assembly.fa 
	samtools import ${WORKDIR}/velvet-diginorm-assembly.fa.fai ${WORKDIR}/vd.pe.sam ${WORKDIR}/vd.pe.bam 
	samtools import ${WORKDIR}/velvet-diginorm-assembly.fa.fai ${WORKDIR}/vd.se.sam ${WORKDIR}/vd.se.bam
	#cat ${WORKDIR}/vd.pe.sam ${WORKDIR}/vd.se.sam > ${WORKDIR}/vd.sam 
	#cat ${WORKDIR}/vd.pe.bam ${WORKDIR}/vd.se.bam > ${WORKDIR}/vd.bam
	samtools view -c -f 4 ${WORKDIR}/vd.pe.bam > ${WORKDIR}/vd-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/vd.se.bam >> ${WORKDIR}/vd-unmapped.count


reads-to-vpart: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/velvet-partition-assembly.fa 
	bwa index ${WORKDIR}/velvet-partition-assembly.fa 
	bwa aln ${WORKDIR}/velvet-partition-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/vp.pe.sai 
	bwa aln ${WORKDIR}/velvet-partition-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/vp.se.sai 
	bwa samse ${WORKDIR}/velvet-partition-assembly.fa ${WORKDIR}/vp.pe.sai ${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/vp.pe.sam 
	bwa samse ${WORKDIR}/velvet-partition-assembly.fa ${WORKDIR}/vp.se.sai ${PREFIX}.se.qc.fq.gz > ${WORKDIR}/vp.se.sam 
	samtools ${WORKDIR}/faidx velvet-partition-assembly.fa 
	samtools import ${WORKDIR}/velvet-partition-assembly.fa.fai ${WORKDIR}/vp.pe.sam ${WORKDIR}/vp.pe.bam 
	samtools import ${WORKDIR}/velvet-partition-assembly.fa.fai ${WORKDIR}/vp.se.sam ${WORKDIR}/vp.se.bam 
	#cat ${WORKDIR}/vp.pe.sam ${WORKDIR}/vp.se.sam >${WORKDIR}/vp.sam 
	#cat ${WORKDIR}/vp.pe.bam ${WORKDIR}/vp.se.bam >${WORKDIR}/vp.bam 
	samtools view -c -f 4 ${WORKDIR}/vp.pe.bam > ${WORKDIR}/vp-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/vp.se.bam >> ${WORKDIR}/vp-unmapped.count	

reads-to-iqc: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/idba-quality-assembly.fa 
	bwa index ${WORKDIR}/idba-quality-assembly.fa 
	bwa aln ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/iq.pe.sai 
	bwa aln ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/iq.se.sai 
	bwa samse ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/iq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/iq.pe.sam 
	bwa samse ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/iq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/iq.se.sam
	samtools faidx ${WORKDIR}/idba-quality-assembly.fa 
	samtools import ${WORKDIR}/idba-quality-assembly.fa.fai ${WORKDIR}/iq.pe.sam ${WORKDIR}/iq.pe.bam 
	samtools import ${WORKDIR}/idba-quality-assembly.fa.fai ${WORKDIR}/iq.se.sam ${WORKDIR}/iq.se.bam 
	samtools faidx ${WORKDIR}/idba-quality-assembly.fa 
	samtools import ${WORKDIR}/idba-quality-assembly.fa.fai ${WORKDIR}/iq.pe.sam ${WORKDIR}/iq.pe.bam 
	samtools import ${WORKDIR}/idba-quality-assembly.fa.fai ${WORKDIR}/iq.se.sam ${WORKDIR}/iq.se.bam 
	#cat ${WORKDIR}/iq.pe.sam ${WORKDIR}/iq.se.sam >${WORKDIR}/iq.sam 
	#cat ${WORKDIR}/iq.pe.bam ${WORKDIR}/iq.se.bam >${WORKDIR}/iq.bam 
	samtools view -c -f 4 ${WORKDIR}/iq.pe.bam > ${WORKDIR}/iq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/iq.se.bam >> ${WORKDIR}/iq-unmapped.count 


reads-to-idigi: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/idba-diginorm-assembly.fa 
	bwa index ${WORKDIR}/idba-diginorm-assembly.fa 
	bwa aln ${WORKDIR}/idba-diginorm-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/id.pe.sai 
	bwa aln ${WORKDIR}/idba-diginorm-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/id.se.sai
	bwa samse ${WORKDIR}/idba-diginorm-assembly.fa ${WORKDIR}/id.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/id.pe.sam 
	bwa samse ${WORKDIR}/idba-diginorm-assembly.fa ${WORKDIR}/id.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/id.se.sam 
	samtools faidx ${WORKDIR}/idba-diginorm-assembly.fa 
	samtools import ${WORKDIR}/idba-diginorm-assembly.fa.fai ${WORKDIR}/id.pe.sam ${WORKDIR}/id.pe.bam 
	samtools import ${WORKDIR}/idba-diginorm-assembly.fa.fai ${WORKDIR}/id.se.sam ${WORKDIR}/id.se.bam 
	#cat ${WORKDIR}/id.pe.sam ${WORKDIR}/id.se.sam > ${WORKDIR}/id.sam 
	#cat ${WORKDIR}/id.pe.bam ${WORKDIR}/id.se.bam > ${WORKDIR}/id.bam 
	samtools view -c -f 4 ${WORKDIR}/id.pe.bam > ${WORKDIR}/id-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/id.se.bam >> ${WORKDIR}/id-unmapped.count

reads-to-ipart: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/idba-partition-assembly.fa  
	bwa index ${WORKDIR}/idba-partition-assembly.fa 
	bwa aln ${WORKDIR}/idba-partition-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/ip.pe.sai 
	bwa aln ${WORKDIR}/idba-partition-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/ip.se.sai 
	bwa samse ${WORKDIR}/idba-partition-assembly.fa ${WORKDIR}/ip.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/ip.pe.sam 
	bwa samse ${WORKDIR}/idba-partition-assembly.fa ${WORKDIR}/ip.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/ip.se.sam 
	samtools faidx ${WORKDIR}/idba-partition-assembly.fa 
	samtools import ${WORKDIR}/idba-partition-assembly.fa.fai ${WORKDIR}/ip.pe.sam ${WORKDIR}/ip.pe.bam 
	samtools import ${WORKDIR}/idba-partition-assembly.fa.fai ${WORKDIR}/ip.se.sam ${WORKDIR}/ip.se.bam 
	#cat ${WORKDIR}/ip.pe.sam ${WORKDIR}/ip.se.sam > ${WORKDIR}/ip.sam 
	#cat ${WORKDIR}/ip.pe.bam ${WORKDIR}/ip.se.bam > ${WORKDIR}/ip.bam 
	samtools view -c -f 4 ${WORKDIR}/ip.pe.bam > ${WORKDIR}/ip-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/ip.se.bam >> ${WORKDIR}/ip-unmapped.count

reads-to-sqc:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/spades-quality-assembly.fa 
	bwa index ${WORKDIR}/spades-quality-assembly.fa 
	bwa aln ${WORKDIR}/spades-quality-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/sq.pe.sai 
	bwa aln ${WORKDIR}/spades-quality-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/sq.se.sai 
	bwa samse ${WORKDIR}/spades-quality-assembly.fa ${WORKDIR}/sq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/sq.pe.sam 
	bwa samse ${WORKDIR}/spades-quality-assembly.fa ${WORKDIR}/sq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/sq.se.sam 
	samtools ${WORKDIR}/faidx spades-quality-assembly.fa 
	samtools import ${WORKDIR}/spades-quality-assembly.fa.fai ${WORKDIR}/sq.pe.sam ${WORKDIR}/sq.pe.bam 
	samtools import ${WORKDIR}/spades-quality-assembly.fa.fai ${WORKDIR}/sq.se.sam ${WORKDIR}/sq.se.bam 
	#cat ${WORKDIR}/sq.pe.sam ${WORKDIR}/sq.se.sam > ${WORKDIR}/sq.sam 
	#cat ${WORKDIR}/sq.pe.bam ${WORKDIR}/sq.se.bam > ${WORKDIR}/sq.bam
	samtools view -c -f 4 ${WORKDIR}/sq.pe.bam > ${WORKDIR}/sq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/sq.se.bam >> ${WORKDIR}/sq-unmapped.count

reads-to-sdigi: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/spades-diginorm-assembly.fa 
	bwa index ${WORKDIR}/spades-diginorm-assembly.fa 
	bwa aln ${WORKDIR}/spades-diginorm-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/sd.pe.sai 
	bwa aln ${WORKDIR}/spades-diginorm-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/sd.se.sai 
	bwa samse ${WORKDIR}/spades-diginorm-assembly.fa ${WORKDIR}/sd.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/sd.pe.sam 
	bwa samse ${WORKDIR}/spades-diginorm-assembly.fa ${WORKDIR}/sd.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/sd.se.sam
	samtools faidx ${WORKDIR}/spades-diginorm-assembly.fa 
	samtools import ${WORKDIR}/spades-diginorm-assembly.fa.fai ${WORKDIR}/sd.pe.sam ${WORKDIR}/sd.pe.bam 
	samtools import ${WORKDIR}/spades-diginorm-assembly.fa.fai ${WORKDIR}/sd.se.sam ${WORKDIR}/sd.se.bam
	#cat ${WORKDIR}/sd.pe.sam ${WORKDIR}/sd.se.sam > ${WORKDIR}/sd.sam 
	#cat ${WORKDIR}/sd.pe.bam ${WORKDIR}/sd.se.bam > ${WORKDIR}/sd.bam 
	samtools view -c -f 4 ${WORKDIR}/sd.pe.bam > ${WORKDIR}/sd-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/sd.se.bam >> ${WORKDIR}/sd-unmapped.count

reads-to-spart:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/spades-partition-assembly.fa 
	bwa index ${WORKDIR}/spades-partition-assembly.fa 
	bwa aln ${WORKDIR}/spades-partition-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/sp.pe.sai 
	bwa aln ${WORKDIR}/spades-partition-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/sp.se.sai 
	bwa samse ${WORKDIR}/spades-partition-assembly.fa ${WORKDIR}/sp.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/sp.pe.sam 
	bwa samse ${WORKDIR}/spades-partition-assembly.fa ${WORKDIR}/sp.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/sp.se.sam 
	samtools faidx ${WORKDIR}/spades-partition-assembly.fa 
	samtools import ${WORKDIR}/spades-partition-assembly.fa.fai ${WORKDIR}/sp.pe.sam ${WORKDIR}/sp.pe.bam 
	samtools import ${WORKDIR}/spades-partition-assembly.fa.fai ${WORKDIR}/sp.se.sam ${WORKDIR}/sp.se.bam 
	#cat ${WORKDIR}/sp.pe.sam ${WORKDIR}/sp.se.sam > ${WORKDIR}/sp.sam
	#cat ${WORKDIR}/sp.pe.bam ${WORKDIR}/sp.se.bam > ${WORKDIR}/sp.bam 	
	samtools view -c -f 4 ${WORKDIR}/sp.pe.bam > ${WORKDIR}/sp-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/sp.se.bam >> ${WORKDIR}/sp-unmapped.count

reads-to-mqc:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/megahit-quality-assembly.fa 
	bwa index ${WORKDIR}/megahit-quality-assembly.fa 
	bwa aln ${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/mq.pe.sai 
	bwa aln ${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/mq.se.sai 
	bwa samse ${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/mq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/mq.pe.sam 
	bwa samse ${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/mq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/mq.se.sam 
	samtools faidx ${WORKDIR}/megahit-quality-assembly.fa 
	samtools import ${WORKDIR}/megahit-quality-assembly.fa.fai ${WORKDIR}/mq.pe.sam ${WORKDIR}/mq.pe.bam 
	samtools import ${WORKDIR}/megahit-quality-assembly.fa.fai ${WORKDIR}/mq.se.sam ${WORKDIR}/mq.se.bam 
	#cat ${WORKDIR}/mq.pe.sam ${WORKDIR}/mq.se.sam > ${WORKDIR}/mq.sam 
	#cat ${WORKDIR}/mq.pe.bam ${WORKDIR}/mq.se.bam > ${WORKDIR}/mq.bam 
	samtools view -c -f 4 ${WORKDIR}/mq.pe.bam > ${WORKDIR}/mq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/mq.se.bam >> ${WORKDIR}/mq-unmapped.count

reads-to-mdigi:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/megahit-diginorm-assembly.fa 
	bwa index ${WORKDIR}/megahit-diginorm-assembly.fa 
	bwa aln ${WORKDIR}/megahit-diginorm-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/md.pe.sai 
	bwa aln ${WORKDIR}/megahit-diginorm-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/md.se.sai 
	bwa samse ${WORKDIR}/megahit-diginorm-assembly.fa ${WORKDIR}/md.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/md.pe.sam 
	bwa samse ${WORKDIR}/megahit-diginorm-assembly.fa ${WORKDIR}/md.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/md.se.sam 
	samtools faidx ${WORKDIR}/megahit-diginorm-assembly.fa 
	samtools import ${WORKDIR}/megahit-diginorm-assembly.fa.fai ${WORKDIR}/md.pe.sam ${WORKDIR}/md.pe.bam 
	samtools import ${WORKDIR}/megahit-diginorm-assembly.fa.fai ${WORKDIR}/md.se.sam ${WORKDIR}/md.se.bam 
	#cat ${WORKDIR}/md.pe.sam ${WORKDIR}/md.se.sam > ${WORKDIR}/md.sam 
	#cat ${WORKDIR}/md.pe.bam ${WORKDIR}/md.se.bam > ${WORKDIR}/md.bam 
	samtools view -c -f 4 ${WORKDIR}/md.pe.bam > ${WORKDIR}/md-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/md.se.bam >> ${WORKDIR}/md-unmapped.count

reads-to-mpart:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/megahit-partition-assembly.fa 
	bwa index ${WORKDIR}/megahit-partition-assembly.fa 
	bwa aln ${WORKDIR}/megahit-partition-assembly.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/mp.pe.sai 
	bwa aln ${WORKDIR}/megahit-partition-assembly.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/mp.se.sai 
	bwa samse ${WORKDIR}/megahit-partition-assembly.fa ${WORKDIR}/mp.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/mp.pe.sam
	bwa samse ${WORKDIR}/megahit-partition-assembly.fa ${WORKDIR}/mp.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/mp.se.sam 
	samtools faidx ${WORKDIR}/megahit-partition-assembly.fa 
	samtools import ${WORKDIR}/megahit-partition-assembly.fa.fai ${WORKDIR}/mp.pe.sam ${WORKDIR}/mp.pe.bam 
	samtools import ${WORKDIR}/megahit-partition-assembly.fa.fai ${WORKDIR}/mp.se.sam ${WORKDIR}/mp.se.bam 
	#cat ${WORKDIR}/mp.pe.sam ${WORKDIR}/mp.se.sam > ${WORKDIR}/mp.sam 
	#cat ${WORKDIR}/mp.pe.bam ${WORKDIR}/mp.pe.bam > ${WORKDIR}/mp.bam
	samtools view -c -f 4 ${WORKDIR}/mp.pe.bam > ${WORKDIR}/mp-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/mp.se.bam >> ${WORKDIR}/mp-unmapped.count 
#-------------------------------------------------------Unalignment Experiments--------------------------------------------------------------
extract-unaligned:
	python ${MYSCRIPTS}/extract-unaligned-contigs.py ${WORKDIR}/velvet-quality-assembly.unaligned ${WORKDIR}/velvet-quality-assembly.fa > ${WORKDIR}/velvet-quality-unaligned.fa
	python ${MYSCRIPTS}/extract-unaligned-contigs.py ${WORKDIR}/velvet-diginorm-assembly.unaligned ${WORKDIR}/velvet-diginorm-assembly.fa > ${WORKDIR}/velvet-diginorm-unaligned.fa 
	python ${MYSCRIPTS}/extract-unaligned-contigs.py ${WORKDIR}/velvet-partition-assembly.unaligned ${WORKDIR}/velvet-partition-assembly.fa > ${WORKDIR}/velvet-partition-unaligned.fa  
	python ${MYSCRIPTS}/extract-unaligned-scaffolds.py ${WORKDIR}/idba-quality-assembly.unaligned ${WORKDIR}/idba-quality-assembly.fa > ${WORKDIR}/idba-quality-unaligned.fa
	python ${MYSCRIPTS}/extract-unaligned-scaffolds.py ${WORKDIR}/idba-diginorm-assembly.unaligned ${WORKDIR}/idba-diginorm-assembly.fa >${WORKDIR}/idba-diginorm-unaligned.fa 
	python ${MYSCRIPTS}/extract-unaligned-scaffolds.py ${WORKDIR}/idba-partition-assembly.unaligned ${WORKDIR}/idba-partition-assembly.fa >${WORKDIR}/idba-partition-unaligned.fa 
	python ${MYSCRIPTS}/extract-unaligned-contigs.py ${WORKDIR}/spades-quality-assembly.unaligned ${WORKDIR}/spades-quality-assembly.fa >${WORKDIR}/spades-quality-unaligned.fa
	python ${MYSCRIPTS}/extract-unaligned-contigs.py ${WORKDIR}/spades-diginorm-assembly.unaligned ${WORKDIR}/spades-diginorm-assembly.fa >${WORKDIR}/spades-diginorm-unaligned.fa 
	python ${MYSCRIPTS}/extract-unaligned-contigs.py ${WORKDIR}/spades-partition-assembly.unaligned ${WORKDIR}/spades-partition-assembly.fa ${WORKDIR}/spades-partition-unaligned.fa
	 python ${MYSCRIPTS}/extract-unaligned-contigs.py ${WORKDIR}/megahit-quality-assembly.unaligned ${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/megahit-quality-unaligned.fa 
	python ${MYSCRIPTS}/extract-unaligned-contigs.py ${WORKDIR}/megahit-diginorm-assembly.unaligned ${WORKDIR}/megahit-diginorm-assembly.fa ${WORKDIR}/megahit-diginorm-unaligned.fa 
	python ${MYSCRIPTS}/extract-unaligned-contigs.py ${WORKDIR}/megahit-partition-assembly.unaligned ${WORKDIR}/megahit-partition-assembly.fa ${WORKDIR}/megahit-partition-unaligned.fa
#--------------------------------------------------Mapping reads to unaligned contigs--------------------------------------------------------
reads-to-unaligned-vqc: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/velvet-quality-unaligned.fa
	bwa index ${WORKDIR}/velvet-quality-unaligned.fa 
	bwa aln ${WORKDIR}/velvet-quality-unaligned.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/uvq.pe.sai 
	bwa aln ${WORKDIR}/velvet-quality-unaligned.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/uvq.se.sai 
	bwa samse ${WORKDIR}/velvet-quality-unaligned.fa ${WORKDIR}/uvq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/uvq.pe.sam 
	bwa samse ${WORKDIR}/velvet-quality-unaligned.fa ${WORKDIR}/uvq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/uvq.se.sam
	samtools faidx ${WORKDIR}/velvet-quality-unaligned.fa 
	samtools import ${WORKDIR}/velvet-quality-unaligned.fa.fai ${WORKDIR}/uvq.pe.sam ${WORKDIR}/uvq.pe.bam 
	samtools import ${WORKDIR}/velvet-quality-unaligned.fa.fai ${WORKDIR}/uvq.se.sam ${WORKDIR}/uvq.se.bam
	samtools view -h -F 4 ${WORKDIR}/uvq.pe.bam > ${WORKDIR}/uvqc-mapped.pe.bam
	samtools view -h -F 4 ${WORKDIR}/uvq.se.bam > ${WORKDIR}/uvqc-mapped.se.bam
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/uvqc-mapped.pe.bam > ${WORKDIR}/uvqc-reads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/uvqc-mapped.se.bam >> ${WORKDIR}/uvqc-reads.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/uvqc-reads.fa  >${WORKDIR}/uvqc.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/uvqc.sai ${WORKDIR}/uvqc-reads.fa > ${WORKDIR}/uvqc.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/uvqc.sam ${WORKDIR}/uvqc.bam 
	samtools view -c -F 4 ${WORKDIR}/uvqc.bam > ${WORKDIR}/uvqc-mapped-reads

reads-to-unaligned-iqc: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/idba-quality-unaligned.fa
	bwa index ${WORKDIR}/idba-quality-unaligned.fa 
	bwa aln ${WORKDIR}/idba-quality-unaligned.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/uiq.pe.sai 
	bwa aln ${WORKDIR}/idba-quality-unaligned.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/uiq.se.sai 
	bwa samse ${WORKDIR}/idba-quality-unaligned.fa ${WORKDIR}/uiq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/uiq.pe.sam 
	bwa samse ${WORKDIR}/idba-quality-unaligned.fa ${WORKDIR}/uiq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/uiq.se.sam
	samtools faidx ${WORKDIR}/idba-quality-unaligned.fa 
	samtools import ${WORKDIR}/idba-quality-unaligned.fa.fai ${WORKDIR}/uiq.pe.sam ${WORKDIR}/uiq.pe.bam 
	samtools import ${WORKDIR}/idba-quality-unaligned.fa.fai ${WORKDIR}/uiq.se.sam ${WORKDIR}/uiq.se.bam
	samtools view -h -F 4 ${WORKDIR}/uiq.pe.bam > ${WORKDIR}/uiqc-mapped.pe.bam 
	samtools view -h -F 4 ${WORKDIR}/uiq.se.bam > ${WORKDIR}/uiqc-mapped.se.bam
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/uiqc-mapped.pe.bam > ${WORKDIR}/uiqc-reads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/uiqc-mapped.se.bam >> ${WORKDIR}/uiqc-reads.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/uiqc-reads.fa  >${WORKDIR}/uiqc.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/uiqc.sai ${WORKDIR}/uiqc-reads.fa > ${WORKDIR}/uiqc.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/uiqc.sam ${WORKDIR}/uiqc.bam 
	samtools view -c -F 4 ${WORKDIR}/uiqc.bam > ${WORKDIR}/uiqc-mapped-reads

reads-to-unaligned-sqc: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/spades-quality-unaligned.fa
	bwa index ${WORKDIR}/spades-quality-unaligned.fa 
	bwa aln ${WORKDIR}/spades-quality-unaligned.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/usq.pe.sai 
	bwa aln ${WORKDIR}/spades-quality-unaligned.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/usq.se.sai 
	bwa samse ${WORKDIR}/spades-quality-unaligned.fa ${WORKDIR}/usq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/usq.pe.sam 
	bwa samse ${WORKDIR}/spades-quality-unaligned.fa ${WORKDIR}/usq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/usq.se.sam
	samtools faidx ${WORKDIR}/spades-quality-unaligned.fa 
	samtools import ${WORKDIR}/spades-quality-unaligned.fa.fai ${WORKDIR}/usq.pe.sam ${WORKDIR}/usq.pe.bam 
	samtools import ${WORKDIR}/spades-quality-unaligned.fa.fai ${WORKDIR}/usq.se.sam ${WORKDIR}/usq.se.bam
	samtools view -h -F 4 ${WORKDIR}/usq.pe.bam > ${WORKDIR}/usqc-mapped.pe.bam 
	samtools view -h -F 4 ${WORKDIR}/usq.se.bam > ${WORKDIR}/usqc-mapped.se.bam
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/usqc-mapped.pe.bam > ${WORKDIR}/usqc-reads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/usqc-mapped.se.bam >> ${WORKDIR}/usqc-reads.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/usqc-reads.fa  >${WORKDIR}/usqc.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/usqc.sai ${WORKDIR}/usqc-reads.fa > ${WORKDIR}/usqc.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/usqc.sam ${WORKDIR}/usqc.bam 
	samtools view -c -F 4 ${WORKDIR}/usqc.bam > ${WORKDIR}/usqc-mapped-reads

reads-to-unaligned-mqc: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/megahit-quality-unaligned.fa
	bwa index ${WORKDIR}/megahit-quality-unaligned.fa 
	bwa aln ${WORKDIR}/megahit-quality-unaligned.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/umq.pe.sai 
	bwa aln ${WORKDIR}/megahit-quality-unaligned.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/umq.se.sai 
	bwa samse ${WORKDIR}/megahit-quality-unaligned.fa ${WORKDIR}/umq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/umq.pe.sam 
	bwa samse ${WORKDIR}/megahit-quality-unaligned.fa ${WORKDIR}/umq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/umq.se.sam
	samtools faidx ${WORKDIR}/megahit-quality-unaligned.fa 
	samtools import ${WORKDIR}/megahit-quality-unaligned.fa.fai ${WORKDIR}/umq.pe.sam ${WORKDIR}/umq.pe.bam 
	samtools import ${WORKDIR}/megahit-quality-unaligned.fa.fai ${WORKDIR}/umq.se.sam ${WORKDIR}/umq.se.bam
	samtools view -c -h -F 4 ${WORKDIR}/umq.pe.bam > ${WORKDIR}/umqc-mapped.pe 
	samtools view -c -h -F 4 ${WORKDIR}/umq.se.bam > ${WORKDIR}/umqc-mapped.se
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/umqc-mapped.pe.bam > ${WORKDIR}/umqc-reads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/umqc-mapped.se.bam >> ${WORKDIR}/umqc-reads.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/umqc-reads.fa  >${WORKDIR}/umqc.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/umqc.sai ${WORKDIR}/umqc-reads.fa > ${WORKDIR}/umqc.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/umqc.sam ${WORKDIR}/umqc.bam 
	samtools view -c -F 4 ${WORKDIR}/umqc.bam > ${WORKDIR}/umqc-mapped-reads

reads-to-all-unaligned:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/*-unaligned.fa 
	cat ${WORKDIR}/*-unaligned.fa > ${WORKDIR}/all-unaligned.fa
	bwa index ${WORKDIR}/all-unaligned.fa 
	bwa aln ${WORKDIR}/all-unaligned.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/all.pe.sai 
	bwa aln ${WORKDIR}/all-unaligned.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/all.se.sai 	
	bwa samse ${WORKDIR}/all-unaligned.fa ${WORKDIR}/all.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/all.pe.sam 
	bwa samse ${WORKDIR}/all-unaligned.fa ${WORKDIR}/all.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/all.se.sam
	samtools faidx ${WORKDIR}/all-unaligned.fa 
	samtools import ${WORKDIR}/all-unaligned.fa.fai ${WORKDIR}/all.pe.sam ${WORKDIR}/all.pe.bam 
	samtools import ${WORKDIR}/all-unaligned.fa.fai ${WORKDIR}/all.se.sam ${WORKDIR}/all.se.bam
	samtools view -h -F 4 ${WORKDIR}/all.pe.bam > ${WORKDIR}/all-mapped.pe.bam 
	samtools view -h -F 4 ${WORKDIR}/all.se.bam > ${WORKDIR}/all-mapped.se.bam
	samtools view -c -F 4 ${WORKDIR}/all.pe.bam > ${WORKDIR}/all-aligned-reads	
	samtools view -c -F 4 ${WORKDIR}/all.se.bam >> ${WORKDIR}/all-aligned-reads	
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/all-mapped.pe.bam > ${WORKDIR}/all-reads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/all-mapped.se.bam >> ${WORKDIR}/all-reads.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/all-reads.fa  >${WORKDIR}/all.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/all.sai ${WORKDIR}/all-reads.fa > ${WORKDIR}/all.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/all.sam ${WORKDIR}/all.bam 
	samtools view -c -F 4 ${WORKDIR}/all.bam > ${WORKDIR}/all-mapped-reads
#-----------------------------------------------------------------------------Coverage Profile----------------------------------------------------------------
reads-to-reference: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/mircea.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/qc-ref.pe.sai 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/qc-ref.se.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/qc-ref.pe.sam 
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/qc-ref.se.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/qc-ref.pe.sam ${WORKDIR}/qc-ref.pe.bam 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/qc-ref.se.sam ${WORKDIR}/qc-ref.se.bam 
	samtools merge ${WORKDIR}/qc-ref.bam ${WORKDIR}/qc-ref.pe.bam ${WORKDIR}/qc-ref.se.bam 
	samtools view -h -o ${WORKDIR}/qc-ref.sam ${WORKDIR}/qc-ref.bam

coverage-profile: ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.sam
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.sam > ${WORKDIR}/${PREFIX}.coverage 
#-----------------------------------------------Unalignemt Experiment One--------------------------------------------------------------------------
#--------------------------------------Unaligned reads to Unaligned IDBA reads ---------------------------------------------------------------------
unaligned-idba-unaligned:
	python ${QUAST}/quast.py -R ${WORKDIR}/idba-quality-unaligned.fa -o ${WORKDIR}/velvet-quality-unaligned/ ${WORKDIR}/velvet-quality-unaligned.fa
	python ${QUAST}/quast.py -R ${WORKDIR}/idba-quality-unaligned.fa -o ${WORKDIR}/velvet-diginorm-unaligned/ ${WORKDIR}/velvet-diginorm-unaligned.fa   
	python ${QUAST}/quast.py -R ${WORKDIR}/idba-quality-unaligned.fa -o ${WORKDIR}/velvet-partition-unaligned/ ${WORKDIR}/velvet-partition-unaligned.fa
	python ${QUAST}/quast.py -R ${WORKDIR}/idba-quality-unaligned.fa -o ${WORKDIR}/idba-diginorm-unaligned/ ${WORKDIR}/idba-diginorm-unaligned.fa
	python ${QUAST}/quast.py -R ${WORKDIR}/idba-quality-unaligned.fa -o ${WORKDIR}/idba-partition-unaligned/ ${WORKDIR}/idba-partition-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o ${WORKDIR}/spades-quality-unaligned/ ${WORKDIR}/spades-quality-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o ${WORKDIR}/spades-diginorm-unaligned/ ${WORKDIR}/spades-diginorm-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o ${WORKDIR}/spades-partition-unaligned/ ${WORKDIR}/spades-partition-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o ${WORKDIR}/megahit-quality-unaligned/ ${WORKDIR}/megahit-quality-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o ${WORKDIR}/megahit-diginorm-unaligned/ ${WORKDIR}/megahit-diginorm-unaligned.fa 
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o ${WORKDIR}/megahit-partition-unaligned/ ${WORKDIR}/megahit-partition-unaligned.fa

#----------------------------------------------------Different min-contig in QUAST parameters --------------------------------------------------------
qc-min-contig:
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o vqc-conting-$(i)/ ${WORKDIR}/velvet-quality-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o iqc-conting-$(i)/ ${WORKDIR}/idba-quality-assembly.fa --min-contig=$(i); )  
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o sqc-conting-$(i)/ ${WORKDIR}/spades-quality-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o mqc-conting-$(i)/ ${WORKDIR}/megahit-quality-assembly.fa --min-contig=$(i); )

digi-min-contig:
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o vdigi-conting-$(i)/ ${WORKDIR}/velvet-diginorm-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o idigi-conting-$(i)/ ${WORKDIR}/idba-diginorm-assembly.fa --min-contig=$(i); )  
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o sdigi-conting-$(i)/ ${WORKDIR}/spades-diginrom-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o mdigi-conting-$(i)/ ${WORKDIR}/megahit-diginorm-assembly.fa --min-contig=$(i); )

part-min-contig: 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o vpart-conting-$(i)/ ${WORKDIR}/velvet-partition-assembly.fa --min-contig=$(i);) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ipart-conting-$(i)/ ${WORKDIR}/idba-partition-assembly.fa --min-contig=$(i);)  
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o spart-conting-$(i)/ ${WORKDIR}/spades-partition-assembly.fa --min-contig=$(i);) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o mpart-conting-$(i)/ ${WORKDIR}/megahit-partition-assembly.fa --min-contig=$(i);)
#------------------------------------------------------------Finding Chimeric Reads--------------------------------------------------------------------------
chimeric:  ${DATA}/mircea.fa ${PREFIX}.se.qc.fq.gz ${PREFIX}.pe.qc.fq.gz
	bwa index ${DATA}/mircea.fa 
	bwa mem -M -t 16 ${DATA}/mircea.fa ${PREFIX}.se.qc.fq.gz  > ${PREFIX}-se.sam
	bwa mem -M -t 16 ${DATA}/mircea.fa ${PREFIX}.pe.qc.fq.gz  > ${PREFIX}-pe.sam
	samtools faidx ${DATA}/mircea.fa
	samtools import mircea.fa.fai ${PREFIX}-pe.sam ${PREFIX}-pe.bam
	samtools import mircea.fa.fai ${PREFIX}-se.sam ${PREFIX}-se.bam
	samtools view ${PREFIX}-pe.bam | grep 'SA:'  > ${PREFIX}-pe.chimeric
	samtools view ${PREFIX}-se.bam | grep 'SA:'  > ${PREFIX}-se.chimeric
	bash count-chimeric.sh

#----------------------------------------------------------------Sampling-------------------------------------------------------------
prepare: ${DATA}/${PREFIX}-1.fastq.gz ${DATA}/${PREFIX}-2.fastq.gz
	gunzip -c $< > ${DATA}/${PREFIX}-1.fastq
	gunzip -c $(word, 2, $^) > ${DATA}/${PREFIX}-2.fastq
	python ${MYSCRIPTS}/cat-seq.py $^ > ${DATA}/${PREFIX}.fastq
	split -l  ${N-READS-PER-FILE}*4  ${DATA}/${PREFIX}.fastq temp
	mv ${DATA}/tempaa > ${DATA}/${PREFIX}-half1.fastq 
	mv ${DATA}/tempab > ${DATA}/${PREFIX}-half2.fastq

sample75: ${DATA}/${PREFIX}-half1.fastq  ${DATA}/${PREFIX}-half2.fastq 
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half1.fastq 13703687 > ${DATA}/sample75per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half2.fastq 13703687 >> ${DATA}/sample75per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half1.fastq 13703687 >> ${DATA}/sample75per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half2.fastq 13703687 >> ${DATA}/sample75per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half1.fastq 13703687 >> ${DATA}/sample75per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half2.fastq 13703687 >> ${DATA}/sample75per.fastq	
	python ${MYSCRIPTS}/split.py ${DATA}/sample75per.fastq ${DATA}/sample75per-1.fastq ${DATA}/sample75per-2.fastq
	gzip -c ${DATA}/sample75per-1.fastq > ${DATA}/sample75per-1.fastq.gz 
	gzip -c ${DATA}/sample75per-2.fastq > ${DATA}/sample75per-2.fastq.gz
 
sample50: ${DATA}/${PREFIX}-half1.fastq  ${DATA}/${PREFIX}-half2.fastq 
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half1.fastq 13703687 > ${DATA}/sample50per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half2.fastq 13703687 >> ${DATA}/sample50per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half1.fastq 13703687 >> ${DATA}/sample50per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half2.fastq 13703687 >> ${DATA}/sample50per.fastq
	python ${MYSCRIPTS}/split.py ${DATA}/sample50per.fastq ${DATA}/sample50per-1.fastq ${DATA}/sample50per-2.fastq  	
	gzip -c ${DATA}/sample50per-1.fastq > ${DATA}/sample50per-1.fastq.gz 
	gzip -c ${DATA}/sample50per-2.fastq > ${DATA}/sample50per-2.fastq.gz 

sample25: ${DATA}/${PREFIX}-half1.fastq  ${DATA}/${PREFIX}-half2.fastq 
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half1.fastq 13703687 > ${DATA}/sample25per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half2.fastq 13703687 >> ${DATA}/sample25per.fastq
	python ${MYSCRIPTS}/split.py ${DATA}/sample25per.fastq ${DATA}/sample25per-1.fastq ${DATA}/sample25per-2.fastq
	gzip -c ${DATA}/sample25per-1.fastq > ${DATA}/sample25per-1.fastq.gz 
	gzip -c ${DATA}/sample25per-2.fastq > ${DATA}/sample25per-2.fastq.gz  

sample12point5: ${DATA}/${PREFIX}-half1.fastq  ${DATA}/${PREFIX}-half2.fastq 
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half1.fastq 6851844 > ${DATA}/sample12p5per.fastq
	python ${MYSCRIPTS}/sampling.py  ${DATA}/${PREFIX}-half2.fastq 6851843 >> ${DATA}/sample12p5per.fastq
	python ${MYSCRIPTS}/split.py ${DATA}/sample12p5per.fastq ${DATA}/sample12p5per-1.fastq ${DATA}/sample12p5per-2.fastq
	gzip -c ${DATA}/sample12p5per-1.fastq > ${DATA}/sample12p5per-1.fastq.gz 
	gzip -c ${DATA}/sample12p5per-2.fastq > ${DATA}/sample12p5per-2.fastq.gz 

sampleonem: ${DATA}/${PREFIX}-half1.fastq  ${DATA}/${PREFIX}-half2.fastq
	python ${MYSCRIPTS}/sampling.py ${DATA}/${PREFIX}-half1.fastq.gz  500000 > ${DATA}/sampleonem.fastq
	python ${MYSCRIPTS}/sampling.py ${DATA}/${PREFIX}-half2.fastq.gz  500000 >> ${DATA}/sampleonem.fastq
	python ${MYSCRIPTS}/split.py ${DATA}/sampleone-m.fastq ${DATA}/sampleonem-1.fastq ${DATA}/sampleonem-2.fastq 
	gzip -c ${DATA}/sampleonem-1.fastq > ${DATA}/sampleonem-1.fastq.gz 
	gzip -c ${DATA}/sampleonem-2.fastq > ${DATA}/sampleonem-2.fastq.gz



#----------------------New----------------------------------------Analayzing Assembly-----------------------------------------------------------------------
quality-nucmer: ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/spades-quality-assembly.fa  ${WORKDIR}/megahit-quality-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc  ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc  ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/mqc  ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa	

diginorm-nucmer: ${DATA}/mircea.fa ${WORKDIR}/idba-diginorm-assembly.fa ${WORKDIR}/spades-diginorm-assembly.fa ${WORKDIR}/megahit-diginorm-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/idigi  ${DATA}/mircea.fa ${WORKDIR}/idba-diginorm-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sdigi  ${DATA}/mircea.fa ${WORKDIR}/spades-diginorm-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/mdigi  ${DATA}/mircea.fa ${WORKDIR}/megahit-diginorm-assembly.fa

partition-nucmer: ${DATA}/mircea.fa ${WORKDIR}/idba-partition-assembly.fa ${WORKDIR}/spades-partition-assembly.fa ${WORKDIR}/megahit-partition-assembly.fa
	 ${NUCMER}/nucmer --coords -p ${WORKDIR}/ipart  ${DATA}/mircea.fa ${WORKDIR}/idba-partition-assembly.fa
	 ${NUCMER}/nucmer --coords -p ${WORKDIR}/spart  ${DATA}/mircea.fa ${WORKDIR}/spades-partition-assembly.fa
	 ${NUCMER}/nucmer --coords -p ${WORKDIR}/mpart  ${DATA}/mircea.fa ${WORKDIR}/megahit-partition-assembly.fa

quality-analysis: ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/spades-quality-assembly.fa  ${WORKDIR}/megahit-quality-assembly.fa   
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/spades-quality-assembly.fa ${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/iqc.coords ${WORKDIR}/sqc.coords ${WORKDIR}/mqc.coords ${WORKDIR}/quality-analysis-ambiguity99 99
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/spades-quality-assembly.fa ${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/iqc.coords ${WORKDIR}/sqc.coords ${workdir}/mqc.coords ${WORKDIR}/quality-besthit99 99 -a False	


#----------------------New----------------------------------------Minimum Contig Experiment------------------------------------------------------------------
idba-quality-mincontig: ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa  
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 250 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 500 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 1000 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 2000
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 3000


spades-quality-mincontig: ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 250 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 500 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 1000 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 2000
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 3000

megahit-quality-mincontig: ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 250 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 500 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 1000 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 2000
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 3000

run-nucmer-mincontig: ${WORKDIR}/idba-quality-assembly250.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/idba-quality-assembly1000.fa \
	${WORKDIR}/idba-quality-assembly2000.fa ${WORKDIR}/idba-quality-assembly3000.fa ${WORKDIR}/spades-quality-assembly250.fa  \
	${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly1000.fa ${WORKDIR}/spades-quality-assembly3000.fa \
	${WORKDIR}/megahit-quality-assembly250.fa ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/megahit-quality-assembly1000.fa \
	${WORKDIR}/megahit-quality-assembly2000.fa ${WORKDIR}/megahit-quality-assembly3000.fa

        ${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc250  ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly250.fa 
        ${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc500  ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa 
        ${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc1000  ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly1000.fa
        ${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc2000 ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly2000.fa
        ${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc3000 ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly3000.fa 

	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc250  ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly250.fa      
        ${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc500  ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly500.fa
        ${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc1000  ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly1000.fa
        ${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc2000 ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly2000.fa
        ${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc3000 ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly3000.fa
		
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc250  ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly250.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc500  ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly500.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc1000  ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly1000.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc2000 ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly2000.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc3000 ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly3000.fa
	

run-analysis-mincontig: ${WORKDIR}/iqc250 ${WORKDIR}/iqc500 ${WORKDIR}/iqc1000 ${WORKDIR}/iqc2000 ${WORKDIR}/iqc3000 \
	${WORKDIR}/sqc250 ${WORKDIR}/sqc500 ${WORKDIR}/sqc1000 ${WORKDIR}/sqc2000 ${WORKDIR}/sqc300 \
	${WORKDIR}/mqc250 ${WORKDIR}/mqc500 ${WORKDIR}/mqc1000 ${WORKDIR}/mqc2000 ${WORKDIR}/mqc300
        #add analayze-assembly.py here without options for coverage analysis or unaloignment
	        
	
#---------------------------------------------------------------Cleaning ------------------------------------------------------------------------------------	
clean: *.list *.list.unique
	rm *.list 
	rm *.list.unique  
