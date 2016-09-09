DATA = /mnt/home/mahmoud4/data
WORKDIR = /mnt/research/ged/sherine/run
MYSCRIPTS = /mnt/home/mahmoud4/scripts
NUCMER = contigs_reports/nucmer_output
PREFIX = SRR606249
N-READS-PER-FILE = 5536289548 
mc= 0 250 500 750 1000 2000
KSIZE = 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51
KAK=kak
partial.cutoff =50 
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


#-----------------------------------------------READ INCORPORATION---------------------------------------------
reads-to-iqc: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/idba-quality-assembly500.fa 
	bwa index ${WORKDIR}/idba-quality-assembly500.fa 
	bwa aln ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/iq.pe.sai 
	bwa aln ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/iq.se.sai 
	bwa samse ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/iq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/iq.pe.sam 
	bwa samse ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/iq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/iq.se.sam
	samtools faidx ${WORKDIR}/idba-quality-assembly500.fa 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.pe.sam ${WORKDIR}/iq.pe.bam 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.se.sam ${WORKDIR}/iq.se.bam 
	samtools faidx ${WORKDIR}/idba-quality-assembly500.fa 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.pe.sam ${WORKDIR}/iq.pe.bam 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.se.sam ${WORKDIR}/iq.se.bam 
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

reads-to-sqc:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/spades-quality-assembly500.fa 
	bwa index ${WORKDIR}/spades-quality-assembly500.fa 
	bwa aln ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/sq.pe.sai 
	bwa aln ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/sq.se.sai 
	bwa samse ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/sq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/sq.pe.sam 
	bwa samse ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/sq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/sq.se.sam 
	samtools faidx ${WORKDIR}/spades-quality-assembly500.fa 
	samtools import ${WORKDIR}/spades-quality-assembly500.fa.fai ${WORKDIR}/sq.pe.sam ${WORKDIR}/sq.pe.bam 
	samtools import ${WORKDIR}/spades-quality-assembly500.fa.fai ${WORKDIR}/sq.se.sam ${WORKDIR}/sq.se.bam 
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

reads-to-mqc:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/megahit-quality-assembly500.fa 
	bwa index ${WORKDIR}/megahit-quality-assembly500.fa 
	bwa aln ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/mq.pe.sai 
	bwa aln ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/mq.se.sai 
	bwa samse ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/mq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/mq.pe.sam 
	bwa samse ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/mq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/mq.se.sam 
	samtools faidx ${WORKDIR}/megahit-quality-assembly500.fa 
	samtools import ${WORKDIR}/megahit-quality-assembly500.fa.fai ${WORKDIR}/mq.pe.sam ${WORKDIR}/mq.pe.bam 
	samtools import ${WORKDIR}/megahit-quality-assembly500.fa.fai ${WORKDIR}/mq.se.sam ${WORKDIR}/mq.se.bam 
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
#--------------------------------------------------Mapping reads to unaligned contigs--------------------------------------------------------
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
#-----------------------------------------------------------------Reads Coverage Profile----------------------------------------------------------------
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

count-unmapped-reads: 
	samtools view -h -o ${WORKDIR}/qc-ref.pe.sam ${WORKDIR}/qc-ref.pe.bam
	samtools view -h -c -f 4 ${WORKDIR}/qc-ref.pe.bam >> unmapped-qc-to-ref 
	samtools view -h -o ${WORKDIR}/qc-ref.se.sam ${WORKDIR}/qc-ref.se.bam
	samtools view -h -c -f 4 ${WORKDIR}/qc-ref.se.bam >> unmapped-qc-to-ref 
      	

coverage-profile: ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.sam
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.sam ${WORKDIR}/${PREFIX}.qc.coverage 

#--------------------------------------------------------Unaligned Coverage Profile--------------------------------------------------------------------
iqc-unaligned:  ${WORKDIR}/iqc.AM99.pe.bam ${WORKDIR}/iqc.AM99.se.bam ${WORKDIR}/iqc.AM99.fa
	samtools view -h -f 4 ${WORKDIR}/iqc.AM99.bam > ${WORKDIR}/iqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh ${WORKDIR}/iqc.AM99.unmapped.bam > ${WORKDIR}/iqc.AM99.unmappedreads.fa 
	bwa index ${WORKDIR}/iqc.AM99.fa
	bwa aln ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.unmappedreads.fa  >${WORKDIR}/iqc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.unmapped.sai ${WORKDIR}/iqc.AM99.unmappedreads.fa > ${WORKDIR}/iqc.AM99.unmapped.sam

iqc-unaligned-cov: 
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.unmapped.sam iqc.unmapped.out > ${WORKDIR}/iqc.Am99.unmapped.coverage 	


sqc-unaligned:  ${WORKDIR}/sqc.AM99.pe.bam ${WORKDIR}/sqc.AM99.se.bam ${WORKDIR}/sqc.AM99.fa
	samtools view -h -f 4 ${WORKDIR}/sqc.AM99.bam > ${WORKDIR}/sqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh ${WORKDIR}/sqc.AM99.unmapped.bam > ${WORKDIR}/sqc.AM99.unmappedreads.fa 
	bwa index ${WORKDIR}/sqc.AM99.fa
	bwa aln ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.unmappedreads.fa  >${WORKDIR}/sqc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.unmapped.sai ${WORKDIR}/sqc.AM99.unmappedreads.fa > ${WORKDIR}/sqc.AM99.unmapped.sam

sqc-unaligned-cov: 
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.unmapped.sam sqc.unmapped.out > ${WORKDIR}/sqc.Am99.unmapped.coverage      


mqc-unaligned:  ${WORKDIR}/mqc.AM99.pe.bam ${WORKDIR}/mqc.AM99.se.bam ${WORKDIR}/mqc.AM99.fa
	samtools view -h -f 4 ${WORKDIR}/mqc.AM99.bam > ${WORKDIR}/mqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh ${WORKDIR}/mqc.AM99.unmapped.bam > ${WORKDIR}/mqc.AM99.unmappedreads.fa 
	bwa index ${WORKDIR}/mqc.AM99.fa
	bwa aln ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.unmappedreads.fa  >${WORKDIR}/mqc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.unmapped.sai ${WORKDIR}/mqc.AM99.unmappedreads.fa > ${WORKDIR}/mqc.AM99.unmapped.sam

mqc-unaligned-cov: 
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.unmapped.sam mqc.unmapped.out > ${WORKDIR}/mqc.Am99.unmapped.coverage      

all-unaligned:
	cat iqc.AM99.fa sqc.AM99.fa mqc.AM99.fa > qc.AM99.fa  
	cat iqc.AM99.unmappedreads.fa  sqc.AM99.unmappedreads.fa  mqc.AM99.unmappedreads.fa  > qc.AM99.unmappedreads.fa
	bwa index ${WORKDIR}/qc.AM99.fa
	bwa aln ${WORKDIR}/qc.AM99.fa ${WORKDIR}/qc.AM99.unmappedreads.fa  >${WORKDIR}/qc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/qc.AM99.fa ${WORKDIR}/qc.AM99.unmapped.sai ${WORKDIR}/qc.AM99.unmappedreads.fa > ${WORKDIR}/qc.AM99.unmapped.sam
	
all-cov: 
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/qc.AM99.fa ${WORKDIR}/qc.AM99.unmapped.sam all.unmapped.out > ${WORKDIR}/all.unmapped.coverage 
	
	#awk '$1 >=5 {sum += $2} END {print sum}' backup/all.unmapped.coverage
	#awk '{sum += $2} END {print sum}' backup/all.unmapped.coverage	
#------------------------------------------------------------Finding Chimeric Reads--------------------------------------------------------------------------
chimeric:  ${DATA}/mircea.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	bwa index ${DATA}/mircea.fa 
	bwa mem -M -t 16 ${DATA}/mircea.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${PREFIX}-se.sam
	bwa mem -M -t 16 ${DATA}/mircea.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${PREFIX}-pe.sam
	samtools faidx ${DATA}/mircea.fa
	samtools import mircea.fa.fai ${PREFIX}-pe.sam ${PREFIX}-pe.bam
	samtools import mircea.fa.fai ${PREFIX}-se.sam ${PREFIX}-se.bam
	samtools view ${PREFIX}-pe.bam | grep 'SA:'  > ${PREFIX}-pe.chimeric
	samtools view ${PREFIX}-se.bam | grep 'SA:'  > ${PREFIX}-se.chimeric
	bash ${MYSCRIPTS}/count-chimeric.sh

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



#We need to analyze the sampling usig our script; so we need to run nucmer and our script; here it is for sampline quality 25 
#We need to update NUCMER Path here before running 
sampling-nucmer-25: ${WORKDIR}/idba-quality-s25-assembly.fa ${WORKDIR}/spades-quality-s25-assembly.fa ${WORKDIR}/megahit-quality-s25-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc-s25  ${DATA}/mircea.fa ${WORKDIR}/idba-quality-s25-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc-s25  ${DATA}/mircea.fa ${WORKDIR}/spades-quality-s25-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/mqc-s25  ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-s25-assembly.fa 

sampling-nucmer-50: ${WORKDIR}/idba-quality-s50-assembly.fa ${WORKDIR}/spades-quality-s50-assembly.fa ${WORKDIR}/megahit-quality-s50-assembly.fa 
	${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc-s50  ${DATA}/mircea.fa ${WORKDIR}/idba-quality-s50-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc-s50  ${DATA}/mircea.fa ${WORKDIR}/spades-quality-s50-assembly.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/mqc-s50  ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-s50-assembly.fa 
	
	  

s25-quality-analysis: ${DATA}/mircea.fa ${WORKDIR}/idba-quality-s25-assembly.fa ${WORKDIR}/spades-quality-s25-assembly.fa \
	${WORKDIR}/megahit-quality-s25-assembly.fa

	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-s25-assembly.fa ${WORKDIR}/spades-quality-s25-assembly.fa \
	${WORKDIR}/megahit-quality-s25-assembly.fa ${WORKDIR}/iqc-s25.coords ${WORKDIR}/sqc-s25.coords ${WORKDIR}/mqc-s25.coords S25.QC.AMBIGIOUS99 \
	-a True 99
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-s25-assembly.fa ${WORKDIR}/spades-quality-s25-assembly.fa \
	${WORKDIR}/megahit-quality-s25-assembly.fa ${WORKDIR}/iqc-s25.coords ${WORKDIR}/sqc-s25.coords ${WORKDIR}/mqc-s25.coords S25.QC.BESTHIT99 \
	99 -b True      


s50-quality-analysis: ${DATA}/mircea.fa ${WORKDIR}/idba-quality-s50-assembly.fa ${WORKDIR}/spades-quality-s50-assembly.fa \
	${WORKDIR}/megahit-quality-s50-assembly.fa 
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-s50-assembly.fa ${WORKDIR}/spades-quality-s50-assembly.fa \
	${WORKDIR}/megahit-quality-s50-assembly.fa ${WORKDIR}/iqc-s50.coords ${WORKDIR}/sqc-s50.coords ${WORKDIR}/mqc-s50.coords S50.QC.AMBIGIOUS99 \
	-a True 99
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-s50-assembly.fa ${WORKDIR}/spades-quality-s50-assembly.fa \
	${WORKDIR}/megahit-quality-s50-assembly.fa ${WORKDIR}/iqc-s50.coords ${WORKDIR}/sqc-s50.coords ${WORKDIR}/mqc-s50.coords S50.QC.BESTHIT99 \
	99 -b True
		

	

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
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/spades-quality-assembly.fa \
	${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/iqc.coords ${WORKDIR}/sqc.coords ${WORKDIR}/mqc.coords \
        ${WORKDIR}/QC.AMBIGIOUS99 -a True 99
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/spades-quality-assembly.fa \ 
	${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/iqc.coords ${WORKDIR}/sqc.coords ${workdir}/mqc.coords \
	${WORKDIR}/QC.BESTHIT99 99 -b True


nooverlap: 
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/spades-quality-assembly.fa \
	${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/iqc.coords ${WORKDIR}/sqc.coords ${WORKDIR}/mqc.coords \
	${WORKDIR}/QC.NOOVERLAP99 -c True 99 
	
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa ${WORKDIR}/spades-quality-assembly.fa \
	${WORKDIR}/megahit-quality-assembly.fa ${WORKDIR}/iqc.coords ${WORKDIR}/sqc.coords ${workdir}/mqc.coords \
	${WORKDIR}/QC.NOOVERLAP95 95 -c True

	
 



partial-analysis:
	awk '$$3 < ${partial.cutoff}' ${WORKDIR}/iqc.QC.BESTHIT99.aligned.partial |wc -l > ${WORKDIR}/iqc.QC.BESTHIT99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff}' ${WORKDIR}/sqc.QC.BESTHIT99.aligned.partial |wc -l > ${WORKDIR}/iqc.QC.BESTHIT99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff}' ${WORKDIR}/mqc.QC.BESTHIT99.aligned.partial |wc -l > ${WORKDIR}/iqc.QC.BESTHIT99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff}'${WORKDIR}/iqc.QC.AMBIGIOUS99.aligned.partial |wc -l > ${WORKDIR}/iqc.QC.AMBIGIOUS99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff} '${WORKDIR}/sqc.QC.AMBIGIOUS99.aligned.partial |wc -l > ${WORKDIR}/sqc.QC.AMBIGIOUS99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff} '${WORKDIR}/mqc.QC.AMBIGIOUS99.aligned.partial |wc -l > ${WORKDIR}/mqc.QC.AMBIGIOUS99.aligned.partial.filtered


coverage-analysis: 
	sort -rn -k 3 ${WORKDIR}/iqc.QC.BESTHIT99.count.covered > ${WORKDIR}/iqc.QC.BESTHIT99.count.covered.sorted 
	sort -rn -k 3 ${WORKDIR}/sqc.QC.BESTHIT99.count.covered > ${WORKDIR}/sqc.QC.BESTHIT99.count.covered.sorted 	
	sort -rn -k 3 ${WORKDIR}/mqc.QC.BESTHIT99.count.covered > ${WORKDIR}/mqc.QC.BESTHIT99.count.covered.sorted 
	sort -rn -k 3 ${WORKDIR}/iqc.QC.AMBIGIOUS99.count.covered > ${WORKDIR}/iqc.QC.AMBIGIOUS99.count.covered.sorted 
	sort -rn -k 3 ${WORKDIR}/sqc.QC.AMBIGIOUS99.count.covered > ${WORKDIR}/sqc.QC.AMBIGIOUS99.count.covered.sorted 
	sort -rn -k 3 ${WORKDIR}/mqc.QC.AMBIGIOUS99.count.covered > ${WORKDIR}/mqc.QC.AMBIGIOUS99.count.covered.sorted 


#Unalignment Analysis: We used the unaligned contigs(from our script) and align reads to them. 
#We extract the reads that are aligned (those reads contribute to unalignment) and map them to reference genome
#to see whether they exist in the reference or not 


unaligned-analysis-BH: 

	#cat ${WORKDIR}/*BESTHIT99.unaligned > ${WORKDIR}/QC.BH99.fa
	#bwa index ${WORKDIR}/QC.BH99.fa
	#bwa aln ${WORKDIR}/QC.BH99.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/QC.BH99.pe.sai 
	#bwa aln ${WORKDIR}/QC.BH99.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/QC.BH99.se.sai  
	#bwa samse ${WORKDIR}/QC.BH99.fa ${WORKDIR}/QC.BH99.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/QC.BH99.pe.sam 
	#bwa samse ${WORKDIR}/QC.BH99.fa ${WORKDIR}/QC.BH99.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/QC.BH99.se.sam
	#samtools faidx ${WORKDIR}/QC.BH99.fa 
	#samtools import ${WORKDIR}/QC.BH99.fa.fai ${WORKDIR}/QC.BH99.pe.sam ${WORKDIR}/QC.BH99.pe.bam 
	#samtools import ${WORKDIR}/QC.BH99.fa.fai ${WORKDIR}/QC.BH99.se.sam ${WORKDIR}/QC.BH99.se.bam 
	samtools view -h -f 4 ${WORKDIR}/QC.BH99.pe.bam > ${WORKDIR}/QC.BH99.unmapped.pe.bam 
	samtools view -h -f 4 ${WORKDIR}/QC.BH99.se.bam > ${WORKDIR}/QC.BH99.unmapped.se.bam
	samtools view -c -h  -f 4 ${WORKDIR}/QC.BH99.pe.bam > ${WORKDIR}/QC.BH99.unaligned.reads      
	samtools view -c -h -f 4 ${WORKDIR}/QC.BH99.se.bam >> ${WORKDIR}/QC.BH99.unaligned.reads     
        
unaligned-analysis-AMI-iqc: 

	cat iqc500.QC.AMBIGIOUS500.99.unaligned > iqc.AM99.fa   
	bwa index ${WORKDIR}/iqc.AM99.fa
	bwa aln ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/iqc.AM99.pe.sai
	bwa aln ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/iqc.AM99.se.sai
	bwa samse ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/iqc.AM99.pe.sam
	bwa samse ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/iqc.AM99.se.sam
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



unaligned-analysis-AMI-sqc:

	cat sqc500.QC.AMBIGIOUS500.99.unaligned > sqc.AM99.fa 	
	bwa index ${WORKDIR}/sqc.AM99.fa
	bwa aln ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/sqc.AM99.pe.sai
	bwa aln ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/sqc.AM99.se.sai
	bwa samse ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/sqc.AM99.pe.sam 
	bwa samse ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/sqc.AM99.se.sam
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
	#samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/sqc.AM99.sam ${WORKDIR}/sqc.AM99.bam 
	samtools view -c -F 4 ${WORKDIR}/sqc.AM99.bam > ${WORKDIR}/sqc.AM99-mapped-reads        

unaligned-analysis-AMI-mqc:

	cat mqc500.QC.AMBIGIOUS500.99.unaligned > mqc.AM99.fa   
	bwa index ${WORKDIR}/mqc.AM99.fa
	bwa aln ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/mqc.AM99.pe.sai
	bwa aln ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/mqc.AM99.se.sai
	bwa samse ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/mqc.AM99.pe.sam
	bwa samse ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/mqc.AM99.se.sam
	samtools faidx ${WORKDIR}/mqc.AM99.fa
	samtools import ${WORKDIR}/mqc.AM99.fa.fai ${WORKDIR}/mqc.AM99.pe.sam ${WORKDIR}/mqc.AM99.pe.bam
	samtools import ${WORKDIR}/mqc.AM99.fa.fai ${WORKDIR}/mqc.AM99.se.sam ${WORKDIR}/mqc.AM99.se.bam
	samtools view -h -F 4 ${WORKDIR}/mqc.AM99.pe.bam > ${WORKDIR}/mqc.AM99.mapped.pe.bam
	samtools view -h -F 4 ${WORKDIR}/mqc.AM99.se.bam > ${WORKDIR}/mqc.AM99.mapped.se.bam
	samtools view -c -F 4 ${WORKDIR}/mqc.AM99.pe.bam > ${WORKDIR}/mqc.AM99.aligned.reads
	samtools view -c -F 4 ${WORKDIR}/mqc.AM99.se.bam >> ${WORKDIR}/mqc.AM99.aligned.reads
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/mqc.AM99.mapped.pe.bam > ${WORKDIR}/mqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/mqc.AM99.mapped.se.bam >> ${WORKDIR}/mqc.AM99.mappedreads.fa
	#bwa index ${WORKDIR}/mircea.fa
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/mqc.AM99.mappedreads.fa  >${WORKDIR}/mqc.AM99.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/mqc.AM99.sai ${WORKDIR}/mqc.AM99.mappedreads.fa > ${WORKDIR}/mqc.AM99.sam
	samtools faidx ${WORKDIR}/mircea.fa
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/mqc.AM99.sam ${WORKDIR}/mqc.AM99.bam
	samtools view -c -F 4 ${WORKDIR}/mqc.AM99.bam > ${WORKDIR}/mqc.AM99-mapped-reads

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
	

run-analysis-mincontig:
	# ${WORKDIR}/iqc250.coords  ${WORKDIR}/iqc1000.coords ${WORKDIR}/iqc2000.coords  \
	${WORKDIR}/sqc250.coords ${WORKDIR}/sqc1000.coords ${WORKDIR}/sqc2000.coords  \
	${WORKDIR}/mqc250.coords ${WORKDIR}/mqc1000.coords ${WORKDIR}/mqc2000.coords
	#add analayze-assembly.py here without options for coverage analysis or unalignments 
	#python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly250.fa ${WORKDIR}/spades-quality-assembly250.fa \
	${WORKDIR}/megahit-quality-assembly250.fa ${WORKDIR}/iqc250.coords  ${WORKDIR}/sqc250.coords  ${WORKDIR}/mqc250.coords \
	QC.AMBIGIOUS250.99 -a True 99

	#python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly1000.fa ${WORKDIR}/spades-quality-assembly1000.fa \
	${WORKDIR}/megahit-quality-assembly1000.fa ${WORKDIR}/iqc1000.coords ${WORKDIR}/sqc1000.coords ${WORKDIR}/mqc1000.coords \
	QC.AMBIGIOUS1000.99 -a True 99
	
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly2000.fa ${WORKDIR}/spades-quality-assembly2000.fa \
	${WORKDIR}/megahit-quality-assembly2000.fa ${WORKDIR}/iqc2000.coords ${WORKDIR}/sqc2000.coords ${WORKDIR}/mqc2000.coords \
	QC.AMBIGIOUS2000.99 -a True 99

	#python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly250.fa ${WORKDIR}/spades-quality-assembly250.fa \
	${WORKDIR}/megahit-quality-assembly250.fa ${WORKDIR}/iqc250.coords ${WORKDIR}/sqc250.coords ${WORKDIR}/mqc250.coords \
	QC.BESTHIT250.99 -b True 99


	#python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly1000.fa ${WORKDIR}/spades-quality-assembly1000.fa \
	${WORKDIR}/megahit-quality-assembly1000.fa ${WORKDIR}/iqc1000.coords ${WORKDIR}/sqc1000.coords ${WORKDIR}/mqc1000.coords \
	QC.BESTHIT1000.99 -b True 99


mincontig-2000:

	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly2000.fa ${WORKDIR}/spades-quality-assembly2000.fa \
        ${WORKDIR}/megahit-quality-assembly2000.fa ${WORKDIR}/iqc2000.coords ${WORKDIR}/sqc2000.coords ${WORKDIR}/mqc2000.coords \
        QC.AMBIGIOUS2000.99 -a True 99

	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly2000.fa ${WORKDIR}/spades-quality-assembly2000.fa \
	${WORKDIR}/megahit-quality-assembly2000.fa ${WORKDIR}/iqc2000.coords ${WORKDIR}/sqc2000.coords ${WORKDIR}/mqc2000.coords \
	QC.AMBIGIOUS2000.95 -a True 95

	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly2000.fa ${WORKDIR}/spades-quality-assembly2000.fa \
	${WORKDIR}/megahit-quality-assembly2000.fa ${WORKDIR}/iqc2000.coords ${WORKDIR}/sqc2000.coords ${WORKDIR}/mqc2000.coords \
	QC.BESTHIT2000.99 -b True 99

	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly2000.fa ${WORKDIR}/spades-quality-assembly2000.fa \
        ${WORKDIR}/megahit-quality-assembly2000.fa ${WORKDIR}/iqc2000.coords ${WORKDIR}/sqc2000.coords ${WORKDIR}/mqc2000.coords \
        QC.BESTHIT2000.95 -b True 95

mincontig-3000:

	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly3000.fa ${WORKDIR}/spades-quality-assembly3000.fa \
	${WORKDIR}/megahit-quality-assembly3000.fa ${WORKDIR}/iqc3000.coords ${WORKDIR}/sqc3000.coords ${WORKDIR}/mqc3000.coords \
	QC.AMBIGIOUS3000.99 -a True 99

	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly3000.fa ${WORKDIR}/spades-quality-assembly3000.fa \
	${WORKDIR}/megahit-quality-assembly3000.fa ${WORKDIR}/iqc3000.coords ${WORKDIR}/sqc3000.coords ${WORKDIR}/mqc3000.coords \
	QC.AMBIGIOUS3000.95 -a True 95

	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly3000.fa ${WORKDIR}/spades-quality-assembly3000.fa \
	${WORKDIR}/megahit-quality-assembly3000.fa ${WORKDIR}/iqc3000.coords ${WORKDIR}/sqc3000.coords ${WORKDIR}/mqc3000.coords \
	QC.BESTHIT3000.99 -b True 99

	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly3000.fa ${WORKDIR}/spades-quality-assembly3000.fa \
	${WORKDIR}/megahit-quality-assembly3000.fa ${WORKDIR}/iqc3000.coords ${WORKDIR}/sqc3000.coords ${WORKDIR}/mqc3000.coords \
	QC.BESTHIT3000.95 -b True 95
 

 
    	
#---------------------------------------------------------------Cleaning ------------------------------------------------------------------------------------	
clean: *.list *.list.unique
	rm *.list 
	rm *.list.unique  
