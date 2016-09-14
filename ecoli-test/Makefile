DATA = /mnt/research/ged/sherine/ecoli-test/
CURRENT = /mnt/research/ged/sherine/ecoli-test/
NUCMER = contigs_reports/nucmer_output
PREFIX = ecoli
mc= 0 250 500 750 1000 2000
KAK=kak
KSIZE = 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51
MEGAHIT=/mnt/home/mahmoud4/megahit
TRIM = /opt/software/Trimmomatic/0.32
TOOLKIT =/opt/software/FASTX/0.0.14--GCC-4.4.5/bin/
SANDBOX = /opt/software/khmer/2.0--GCC-4.8.2
SCRIPTS = /opt/software/khmer/2.0--GCC-4.8.2/scripts
#SANDBOX = /opt/software/khmer/khmer-1.4
#SCRIPTS =/opt/software/khmer/khmer-1.4/scripts
QUAST = ~/quast-2.3
#--------------------------------------------------------------------------------------------------------------------------------
all-protocol: quality \
	diginorm \
	partition \
	velvet-quality \
	spades-quality \
	idba-quality \
	velvet-diginorm \
	spades-diginorm \
	idba-diginorm \
	velvet-partition \
	spades-partition \
	idba-partition \

#--------------------------------------------------------------------------------------------------------------------------------
sampling: ${DATA}/SRR606429-1.fastq.gz ${DATA}/SRR606429-1.fastq.gz
	gunzip -c SRR606249_1.fastq.gz | head -40000 |gzip > spodar-1.fastq.gz	
	gunzip -c SRR606249_2.fastq.gz | head -40000 |gzip > spodar-2.fastq.gz
#--------------------------------------------------------------------------------------------------------------------------------
quality: ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz 
	interleaving-1
	interleaving-2
	interleaving-3
	protocol-quality-rename-1
	protocol-quality-rename-2 	
#--------------------------------------------------------------------------------------------------------------------------------
diginorm: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz 
	linking-quality \
        protocol-diginorm-C20 \
        protocol-diginorm-filter \
        protocol-diginorm-extract \
        protocol-diginorm-C5 \
	protocol-diginorm-combine-pe-se
#--------------------------------------------------------------------------------------------------------------------------------
partition: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz 
	linking-diginorm \
	protocol-partition-below \
	protocol-partition-rename-1 \
	protocol-partition-run \
	protocol-partition-extract \
	protocol-partition-rename-2 \
	protocol-partition-compress 

#--------------------------------------------Velvet Quality--------------------------------------------------------
velvet-quality:  ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz 
	velvet-quality-1 \
	finalize-velvet-quality
#--------------------------------------------Spades Quality--------------------------------------------------------
spades-quality:  ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz 
	spades-quality-1 \
	spades-quality-2 \
	finalize-spades-quality
#---------------------------------------------IDBA Quality---------------------------------------------------------
idba-quality:  ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz 
	idba-quality-1 \
	idba-quality-2 \
	finalize-idba-quality	
#----------------------------------------------Velvet Diginorm---------------------------------------------------------
velvet-diginorm: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz
	velvet-diginorm-1 \
	finalize-velvet-diginorm 

#----------------------------------------------Spades Diginorm---------------------------------------------------------
spades-diginorm: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz
	spades-diginorm-1 \
	spades-diginorm-2 \
	finalize-spades-diginorm	
#----------------------------------------------IDBA Diginorm----------------------------------------------------------
idba-diginorm: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz
	idba-diginorm-1 \
	idba-diginorm-2 \
	finalize-idba-diginorm 
#------------------------------------------------Velvet  Partition-------------------------------------------------------------
velvet-partition: partition \
	velvet-partition-1 \
	velvet-partition-2 \
	finalize-velvet-partition 
#-------------------------------------------------Spades Partition-------------------------------------------------------------
spades-partition: partition \
	spades-partition-1 \
	spades-partition-2 \
	spades-partition-3 \
	finalize-spades-partition 
#--------------------------------------------------IDBA Partition--------------------------------------------------------------
idba-partition: partition \
	idba-partition-1 \
	idba-partition-2 \
	idba-partition-3 \
	finalize-idba-partition
#-----------------------------------------------------------QUALITY STARTS----------------------------------------------------------------------------------- 
interleaving-1: ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz
	java -jar ${TRIM}/trimmomatic-0.32.jar PE ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz  s1_pe s1_se s2_pe s2_se ILLUMINACLIP:${TRIM}/adapters/TruSeq2-PE.fa:2:30:12 
	${SCRIPTS}/interleave-reads.py s1_pe s2_pe | gzip -9c > ${PREFIX}.pe.fq.gz 
	cat s1_se s2_se | gzip -9c > ${PREFIX}.se.fq.gz

interleaving-2: ${PREFIX}.se.fq.gz ${PREFIX}.pe.fq.gz
	gunzip -c ${PREFIX}.pe.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${PREFIX}.pe.qc.fq.gz 
	gunzip -c ${PREFIX}.se.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${PREFIX}.se.qc.fq.gz

interleaving-3: ${PREFIX}.pe.qc.fq.gz 
	extract-paired-reads.py ${PREFIX}.pe.qc.fq.gz 

protocol-quality-rename-1: ${PREFIX}.pe.qc.fq.gz.pe
	./qc-rename-1.sh 
	touch protocol-quality-rename-1


protocol-quality-rename-2: ${PREFIX}.pe.qc.fq.gz.se 
	./qc-rename-2.sh 
	touch protocol-quality-rename-2
#----------------------------------------------------------------VELVET QUALITY ------------------------------------------------------------------------------
velvet-quality-1: ${PREFIX}.pe.qc.fq.gz  ${PREFIX}.se.qc.fq.gz 
	./velvet-qc.sh 
	touch velvet-quality-1

finalize-velvet-quality: 
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.velvet.qc.*.d/contigs.fa -o velvet-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly  velvet-quality-best.fa > velvet-quality-assembly.fa

#--------------------------------------------------------------SPADES QUALITY---------------------------------------------------------------------------------
spades-quality-1: ${PREFIX}.pe.qc.fq.gz 
	./spades-qc.sh \
	touch spades-quality-1

spades-quality-2:  ${PREFIX}.pe.qc.fq.gz 
	/usr/bin/time -a -o sqc.txt spades.py --sc --pe1-12 ${PREFIX}.pe.qc.fq.gz -o ${PREFIX}.spades.d	

finalize-spades-quality: ${PREFIX}.spades.d/contigs.fasta  
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.spades.d/contigs.fasta -o spades-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly spades-quality-best.fa > spades-quality-assembly.fa
#------------------------------------------------------------------IDBA QUALITY-------------------------------------------------------------------------------
idba-quality-1: ${PREFIX}.pe.qc.fq.gz
	./idba-qc.sh && touch idba-quality-1

idba-quality-2: ${PREFIX}.pe.fa
	/usr/bin/time -a -o iqc.txt idba_ud --pre_correction -r ${PREFIX}.pe.fa -o ${PREFIX}.idba.d.qc 

#finalize-idba-quality: ${PREFIX}.idba.d.qc/scaffold.fa
finalize-idba-quality: 
	#python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.idba.d.qc/scaffold.fa -o idba-quality-best.fa
	#for now only##python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.idba.d.qc/contig.fa -o idba-quality-best.fa 
	python ${SANDBOX}/sandbox/multi-rename.py assembly idba-quality-best.fa > idba-quality-assembly.fa

#----------------------------------------------------------------Megahit Quality------------------------------------------------------------------------------
megahit-qc-1: ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz  
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${PREFIX}.pe.qc.fq.gz -o megahit.qc.pe \
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${PREFIX}.se.qc.fq.gz -o megahit.qc.se

finalize-megahit-quality:  
	python ${SANDBOX}/sandbox/calc-best-assembly.py megahit.qc.?e/final.contigs.fa -o megahit-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly megahit-quality-best.fa > megahit-quality-assembly.fa	

#-----------------------------------------------------------------DIGINORM STARTS-----------------------------------------------------------------------------
protocol-diginorm-C20: ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz
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
	./diginorm-combine-pe.sh && ./diginorm-combine-se.sh \
        touch protocol-diginorm-combine-pe-se
#----------------------------------------------------------------VELVET DIGINORM-----------------------------------------------------------------------------
velvet-diginorm-1: $(foreach k,$(KSIZE),$(subst KSIZE,$k,${PREFIX}.velvet.digi.KSIZE.d)) 

${PREFIX}.velvet.digi.%.d: ${PREFIX}.pe.kak.qc.fq.gz ${PREFIX}.se.kak.qc.fq.gz
	/usr/bin/time -a -o vdig.txt velveth $@ $* -fastq.gz -shortPaired $< -short $(word 2,$^) && velvetg $@ -exp_cov auto -cov_cutoff auto

finalize-velvet-diginorm:
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.velvet.digi.*.d/contigs.fa -o velvet-diginorm-best.fa 
	python ${SANDBOX}/sandbox/multi-rename.py assembly velvet-diginorm-best.fa > velvet-diginorm-assembly.fa 
#----------------------------------------------------------------SPADES DIGINORM------------------------------------------------------------------------------
spades-diginorm-1:*.pe.kak.qc.fq.gz
	./spades-dig.sh \
	touch spades-diginorm-1

spades-diginorm-2: ${PREFIX}.pe.kak.qc.fq.gz ${PREFIX}.se.kak.qc.fq.gz
	/usr/bin/time -a -o sdig.txt spades.py --sc --pe1-12 ${PREFIX}.pe.kak.qc.fq.gz -o ${PREFIX}.pe.kak.qc.spades.d
	/usr/bin/time -a -o sdig.txt spades.py --sc --pe1-12 ${PREFIX}.se.kak.qc.fq.gz -o ${PREFIX}.se.kak.qc.spades.d
	
finalize-spades-diginorm:  ${PREFIX}.spades.d/contigs.fasta 
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.pe.kak.qc.spades.d/contigs.fasta -o spades-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly spades-diginorm-best.fa > spades-diginorm-assembly.fa
#-------------------------------------------------------------------IDBA DIGINORM-----------------------------------------------------------------------------
idba-diginorm-1: *.pe.kak.qc.fq.gz  
	./idba-dig.sh \
	touch idba-diginorm-2

idba-diginorm-2: ${PREFIX}.pe.kak.fa 
	/usr/bin/time -a -o idig.txt idba_ud --pre_correction -r ${PREFIX}.pe.kak.fa  -o ${PREFIX}.idba.d.digi

finalize-idba-diginorm: ${PREFIX}.idba.d.digi/scaffold.fa	
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.idba.d.digi/scaffold.fa -o idba-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly idba-diginorm-best.fa > idba-diginorm-assembly.fa
#---------------------------------------------------------------Megahit DIGINORM------------------------------------------------------------------------------
megahit-digi-1:
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${PREFIX}.pe.kak.qc.fq.gz -o megahit.digi.pe
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${PREFIX}.se.kak.qc.fq.gz -o megahit.digi.se

finalize-megahit-diginorm: 
	python ${SANDBOX}/sandbox/calc-best-assembly.py megahit.digi.*/final.contigs.fa  -o megahit-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly megahit-diginorm-best.fa > megahit-diginorm-assembly.fa
#-------------------------------------------------------------------PARTITION STARTS--------------------------------------------------------------------------
protocol-partition-below: normC5k20.kh *.kak.*.fq.gz
	python ${SANDBOX}/sandbox/filter-below-abund.py normC5k20.kh *.kak.*.fq.gz 


protocol-partition-rename-1: ${PREFIX}.pe.kak.qc.fq.gz.below ${PREFIX}.se.kak.qc.fq.gz.below
	mv ${PREFIX}.pe.kak.qc.fq.gz.below  ${PREFIX}.pe.kak.qc.fq.gz.below.fq &&  mv ${PREFIX}.se.kak.qc.fq.gz.below ${PREFIX}.se.kak.qc.fq.gz.below.fq 

protocol-partition-run: normC5k20.kh ${PREFIX}.pe.kak.qc.fq.gz.below.fq  ${PREFIX}.se.kak.qc.fq.gz.below.fq 
	do-partition.py -k 32 -x 1e9 --threads 4 kak *.kak.qc.fq.gz.below.fq


protocol-partition-extract: *.part  
	extract-partitions.py -X 100000 kak *.part


protocol-partition-rename-2:  
	./seperate.sh \
	touch protocol-partition-rename-2

protocol-partition-compress: 
	gzip *.pe.fq  *.se.fq

#--------------------------------------------------------------------Velvet Partition-------------------------------------------------------------------------
velvet-partition-1: kak*.pe.fq.gz  kak*.se.fq.gz 
	./velvet-part.sh \
	touch velvet-partition-1

velvet-partition-2: kak.group*.pe.fq.gz kak.group*.se.fq.gz
	./velvet-part-finalize.sh \
	touch velvet-partition-2
finalize-velvet-partition:
	        python ${SANDBOX}/sandbox/multi-rename.py assembly velvet-partition-best.group*.fa > velvet-partition-assembly.fa

#-------------------------------------------------------------------Spades Partition--------------------------------------------------------------------------
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
#--------------------------------------------------------------------Megahit PARTITION------------------------------------------------------------------------
megahit-part-1: 
	./megahit-part.sh \
        touch megahit-part-1

megahit-part-2:
	./megahit-part-finalize.sh \
        touch megahit-part-2
finalize-megahit-partition:
	python ${SANDBOX}/sandbox/multi-rename.py assembly megahit-partition-best*.fa > megahit-partition-assembly.fa
#-------------------------------------------------------------------QUAST------------------------------------------------------------------------------------
quasting-2-ref: *-assembly.fa   ${DATA}/mircea.fa.gz 
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/velvet-quality-quast/ velvet-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/idba-quality-quast/ idba-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/spades-quality-quast/ spades-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/megahit-quality-quast/ megahit-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/velvet-diginorm-quast/ velvet-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/idba-diginorm-quast/ idba-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/spades-diginorm-quast/ spades-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/megahit-diginorm-quast/ megahit-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/velvet-partition-quast/ velvet-partition-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.ga -o ${CURRENT}/velvet-partition-quast/ velvet-partition-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/spades-partition-quast/ spades-partition-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/megahit-partition-quast/ megahit-partition-assembly.fa 

quasting-2-assembly: *-assembly.fa ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R velvet-quality-assembly.fa -o ref-velvet-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R idba-quality-assembly.fa -o ref-idba-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R spades-quality-assembly.fa -o ref-spades-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R megahit-quality-assembly.fa -o ref-megahit-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R velvet-diginorm-assembly.fa -o ref-velvet-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R idba-diginorm-assembly.fa -o ref-idba-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R spades-diginorm-assembly.fa -o ref-spades-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R megahit-diginorm-assembly.fa -o ref-megahit-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R velvet-partition-assembly.fa -o ref-velvet-partition-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R idba-partition-assembly.fa -o ref-idba-partition-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R spades-partition-assembly.fa -o ref-spades-partition-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R megahit-partition-assembly.fa -o ref-megahit-partition-quast/ ${DATA}/mircea.fa.gz

#----------------------------------------------------------------Mapping-------------------------------------------------------------------------------------
mapping-2-ref: *-assembly.fa ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz
	bwa index velvet-quality-assembly.fa
	bwa aln velvet-quality-assembly.fa ${PREFIX}.pe.qc.fq.gz   > vq.pe.sai
	bwa aln velvet-quality-assembly.fa ${PREFIX}.se.qc.fq.gz   > vq.se.sai
	bwa samse velvet-quality-assembly.fa vq.pe.sai ${PREFIX}.pe.qc.fq.gz > vq.pe.sam
	bwa samse velvet-quality-assembly.fa vq.se.sai ${PREFIX}.se.qc.fq.gz > vq.se.sam
	samtools faidx velvet-quality-assembly.fa
	samtools import velvet-quality-assembly.fa.fai vq.pe.sam vq.pe.bam
	samtools import velvet-quality-assembly.fa.fai vq.se.sam vq.se.bam
	python extract-unaligned.py -o vq.pe.unaligned --format fasta vq.pe.bam
	python extract-unaligned.py -o vq.se.unaligned --format fasta vq.se.bam
	bwa index velvet-diginorm-assembly.fa
	bwa aln velvet-diginorm-assembly.fa ${PREFIX}.pe.qc.fq.gz   > vd.pe.sai
	bwa aln velvet-diginorm-assembly.fa ${PREFIX}.se.qc.fq.gz   > vd.se.sai
	bwa samse velvet-diginorm-assembly.fa vd.pe.sai ${PREFIX}.pe.qc.fq.gz > vd.pe.sa 
	bwa samse velvet-diginorm-assembly.fa vd.se.sai ${PREFIX}.se.qc.fq.gz > vd.se.sam
	samtools faidx velvet-diginorm-assembly.fa
	samtools import velvet-diginorm-assembly.fa.fai vd.pe.sam vd.pe.bam
	samtools import velvet-diginorm-assembly.fa.fai vd.se.sam vd.se.bam
	python extract-unaligned.py -o vd.pe.unaligned --format fasta vd.pe.bam
	python extract-unaligned.py -o vd.se.unaligned --format fasta vd.se.bam
	bwa index velvet-partition-assembly.fa
	bwa aln velvet-partition-assembly.fa ${PREFIX}.pe.qc.fq.gz   > vp.pe.sai
	bwa aln velvet-partition-assembly.fa ${PREFIX}.se.qc.fq.gz   > vp.se.sai
	bwa samse velvet-partition-assembly.fa vp.pe.sai ${PREFIX}.pe.qc.fq.gz > vp.pe.sam
	bwa samse velvet-partition-assembly.fa vp.se.sai ${PREFIX}.se.qc.fq.gz > vp.se.sam
	samtools faidx velvet-partition-assembly.fa
	samtools import velvet-partition-assembly.fa.fai vp.pe.sam vp.pe.bam
	samtools import velvet-partition-assembly.fa.fai vp.se.sam vp.se.bam
	python extract-unaligned.py -o vp.pe.unaligned --format fasta vp.pe.bam
	python extract-unaligned.py -o vp.se.unaligned --format fasta vp.se.bam
	bwa index idba-quality-assembly.fa
	bwa aln idba-quality-assembly.fa ${PREFIX}.pe.qc.fq.gz   > iq.pe.sai
	bwa aln idba-quality-assembly.fa ${PREFIX}.se.qc.fq.gz   > iq.se.sai
	bwa samse idba-quality-assembly.fa iq.pe.sai ${PREFIX}.pe.qc.fq.gz > iq.pe.sam
	bwa samse idba-quality-assembly.fa iq.se.sai ${PREFIX}.se.qc.fq.gz > iq.se.sam
	samtools faidx idba-quality-assembly.fa
	samtools import idba-quality-assembly.fa.fai iq.pe.sam iq.pe.bam
	samtools import idba-quality-assembly.fa.fai iq.se.sam iq.se.bam
	python extract-unaligned.py -o iq.pe.unaligned --format fasta iq.pe.bam
	python extract-unaligned.py -o iq.se.unaligned --format fasta iq.se.bam
	bwa index idba-diginorm-assembly.fa
	bwa aln idba-diginorm-assembly.fa ${PREFIX}.pe.qc.fq.gz   > id.pe.sai
	bwa aln idba-diginorm-assembly.fa ${PREFIX}.se.qc.fq.gz   > id.se.sai
	bwa samse idba-diginorm-assembly.fa id.pe.sai ${PREFIX}.pe.qc.fq.gz > id.pe.sam
	bwa samse idba-diginorm-assembly.fa id.se.sai ${PREFIX}.se.qc.fq.gz > id.se.sam
	samtools faidx idba-diginorm-assembly.fa
	samtools import idba-diginorm-assembly.fa.fai id.pe.sam id.pe.bam
	samtools import idba-diginorm-assembly.fa.fai id.se.sam id.se.bam
	python extract-unaligned.py -o id.pe.unaligned --format fasta id.pe.bam
	python extract-unaligned.py -o id.se.unaligned --format fasta id.se.bam
	bwa index idba-partition-assembly.fa
	bwa aln idba-partition-assembly.fa ${PREFIX}.pe.qc.fq.gz   > ip.pe.sai
	bwa aln idba-partition-assembly.fa ${PREFIX}.se.qc.fq.gz   > ip.se.sai
	bwa samse idba-partition-assembly.fa ip.pe.sai ${PREFIX}.pe.qc.fq.gz > ip.pe.sam
	bwa samse idba-partition-assembly.fa ip.se.sai ${PREFIX}.se.qc.fq.gz > ip.se.sam
	samtools faidx idba-partition-assembly.fa
	samtools import idba-partition-assembly.fa.fai ip.pe.sam ip.pe.bam
	samtools import idba-partition-assembly.fa.fai ip.se.sam ip.se.bam
	python extract-unaligned.py -o ip.pe.unaligned --format fasta ip.pe.bam
	python extract-unaligned.py -o ip.se.unaligned --format fasta ip.se.bam
	bwa index spades-quality-assembly.fa
	bwa aln spades-quality-assembly.fa ${PREFIX}.pe.qc.fq.gz   > sq.pe.sai
	bwa aln spades-quality-assembly.fa ${PREFIX}.se.qc.fq.gz   > sq.se.sai
	bwa samse spades-quality-assembly.fa sq.pe.sai ${PREFIX}.pe.qc.fq.gz > sq.pe.sam
	bwa samse spades-quality-assembly.fa sq.se.sai ${PREFIX}.se.qc.fq.gz > sq.se.sam
	samtools faidx spades-quality-assembly.fa
	samtools import spades-quality-assembly.fa.fai sq.pe.sam sq.pe.bam
	samtools import spades-quality-assembly.fa.fai sq.se.sam sq.se.bam
	python extract-unaligned.py -o sq.pe.unaligned --format fasta sq.pe.bam
	python extract-unaligned.py -o sq.se.unaligned --format fasta sq.se.bam
	bwa index spades-diginorm-assembly.fa
	bwa aln spades-diginorm-assembly.fa ${PREFIX}.pe.qc.fq.gz   > sd.pe.sai
	bwa aln spades-diginorm-assembly.fa ${PREFIX}.se.qc.fq.gz   > sd.se.sai
	bwa samse spades-diginorm-assembly.fa sd.pe.sai ${PREFIX}.pe.qc.fq.gz > sd.pe.sam
	bwa samse spades-diginorm-assembly.fa sd.se.sai ${PREFIX}.se.qc.fq.gz > sd.se.sam
	samtools faidx spades-diginorm-assembly.fa
	samtools import spades-diginorm-assembly.fa.fai sd.pe.sam sd.pe.bam
	samtools import spades-diginorm-assembly.fa.fai sd.se.sam sd.se.bam
	python extract-unaligned.py -o sd.pe.unaligned --format fasta sd.pe.bam
	python extract-unaligned.py -o sd.se.unaligned --format fasta sd.se.bam
	bwa index spades-partition-assembly.fa
	bwa aln spades-partition-assembly.fa ${PREFIX}.pe.qc.fq.gz   > sp.pe.sai
	bwa aln spades-partition-assembly.fa ${PREFIX}.se.qc.fq.gz   > sp.se.sai
	bwa samse spades-partition-assembly.fa sp.pe.sai ${PREFIX}.pe.qc.fq.gz > sp.pe.sam
	bwa samse spades-partition-assembly.fa sp.se.sai ${PREFIX}.se.qc.fq.gz > sp.se.sam
	samtools faidx spades-partition-assembly.fa
	samtools import spades-partition-assembly.fa.fai sp.pe.sam sp.pe.bam
	samtools import spades-partition-assembly.fa.fai sp.se.sam sp.se.bam
	python extract-unaligned.py -o sp.pe.unaligned --format fasta sp.pe.bam
	python extract-unaligned.py -o sp.se.unaligned --format fasta sp.se.bam
	bwa index megahit-quality-assembly.fa
	bwa aln megahit-quality-assembly.fa ${PREFIX}.pe.qc.fq.gz   > mq.pe.sai
	bwa aln megahit-quality-assembly.fa ${PREFIX}.se.qc.fq.gz   > mq.se.sai
	bwa samse megahit-quality-assembly.fa mq.pe.sai ${PREFIX}.pe.qc.fq.gz > mq.pe.sam
	bwa samse megahit-quality-assembly.fa mq.se.sai ${PREFIX}.se.qc.fq.gz > mq.se.sam
	samtools faidx megahit-quality-assembly.fa
	samtools import megahit-quality-assembly.fa.fai mq.pe.sam mq.pe.bam
	samtools import megahit-quality-assembly.fa.fai mq.se.sam mq.se.bam
	python extract-unaligned.py -o mq.pe.unaligned --format fasta mq.pe.bam
	python extract-unaligned.py -o mq.se.unaligned --format fasta mq.se.bam
	bwa index megahit-diginorm-assembly.fa
	bwa aln megahit-diginorm-assembly.fa ${PREFIX}.pe.qc.fq.gz   > md.pe.sai
	bwa aln megahit-diginorm-assembly.fa ${PREFIX}.se.qc.fq.gz   > md.se.sai
	bwa samse megahit-diginorm-assembly.fa md.pe.sai ${PREFIX}.pe.qc.fq.gz > md.pe.sam
	bwa samse megahit-diginorm-assembly.fa md.se.sai ${PREFIX}.se.qc.fq.gz > md.se.sam
	samtools faidx megahit-diginorm-assembly.fa
	samtools import megahit-diginorm-assembly.fa.fai md.pe.sam md.pe.bam
	samtools import megahit-diginorm-assembly.fa.fai md.se.sam md.se.bam
	python extract-unaligned.py -o md.pe.unaligned --format fasta md.pe.bam
	python extract-unaligned.py -o md.se.unaligned --format fasta md.se.bam
	bwa index megahit-partition-assembly.fa
	bwa aln megahit-partition-assembly.fa ${PREFIX}.pe.qc.fq.gz   > mp.pe.sai
	bwa aln megahit-partition-assembly.fa ${PREFIX}.se.qc.fq.gz   > mp.se.saiZZ
	bwa samse megahit-partition-assembly.fa mp.pe.sai ${PREFIX}.pe.qc.fq.gz > mp.pe.sam
	bwa samse megahit-partition-assembly.fa mp.se.sai ${PREFIX}.se.qc.fq.gz > mp.se.sam
	samtools faidx megahit-partition-assembly.fa
	samtools import megahit-partition-assembly.fa.fai mp.pe.sam mp.pe.bam
	samtools import megahit-partition-assembly.fa.fai mp.se.sam mp.se.bam
	python extract-unaligned.py -o mp.pe.unaligned --format fasta mp.pe.bam
	python extract-unaligned.py -o mp.se.unaligned --format fasta mp.se.bam
	bash counting.sh 

#----------------------------------------------------------Extracting Unaligned Reads-------------------------------------------------------------------------
extract-unaligned:
	python extract-unaligned-scaffolds.py idba-quality-quast/${NUCMER}/idba-quality-assembly.unaligned idba-quality-assembly.fa > idba-quality-unaligned.fa
	python extract-unaligned-contigs.py velvet-quality-quast/${NUCMER}/velvet-quality-assembly.unaligned velvet-quality-assembly.fa > velvet-quality-unaligned.fa
	python extract-unaligned-contigs.py spades-quality-quast/${NUCMER}/spades-quality-assembly.unaligned spades-quality-assembly.fa > spades-quality-unaligned.fa
	python extract-unaligned-contigs.py megahit-quality-quast/${NUCMER}/megahit-quality-assembly.unaligned megahit-quality-assembly.fa  > megahit-quality-unaligned.fa
	python extract-unaligned-scaffolds.py idba-diginorm-quast/${NUCMER}/idba-diginorm-assembly.unaligned idba-diginorm-assembly.fa > idba-diginorm-unaligned.fa
	python extract-unaligned-contigs.py velvet-diginorm-quast/${NUCMER}/velvet-diginorm-assembly.unaligned velvet-diginorm-assembly.fa > velvet-diginorm-unaligned.fa
	python extract-unaligned-contigs.py spades-diginorm-quast/${NUCMER}/spades-diginorm-assembly.unaligned spades-diginorm-assembly.fa > spades-diginorm-unaligned.fa
	python extract-unaligned-contigs.py megahit-diginorm-quast/${NUCMER}/megahit-diginorm-assembly.unaligned megahit-diginorm-assembly.fa  > megahit-diginorm-unaligned.fa
	python extract-unaligned-scaffolds.py idba-partition-quast/${NUCMER}/idba-partition-assembly.unaligned idba-partition-assembly.fa > idba-partition-unaligned.fa
	python extract-unaligned-contigs.py velvet-partition-quast/${NUCMER}/velvet-partition-assembly.unaligned velvet-partition-assembly.fa > velvet-partition-unaligned.fa
	python extract-unaligned-contigs.py spades-partition-quast/${NUCMER}/spades-partition-assembly.unaligned spades-partition-assembly.fa > spades-partition-unaligned.fa
	python extract-unaligned-contigs.py megahit-partition-quast/${NUCMER}/megahit-partition-assembly.unaligned megahit-partition-assembly.fa  > megahit-partition-unaligned.fa

#-------------------------------------------------Blasting Unligned Reads to Fusa Seeds----------------------------------------------------------------------
unaligned-fusa: fusA.seeds *-unaligned.fa 
	formatdb -i fusA.seeds  -p F 
	blastall -p blastn -d ${DATA}/fusA.seeds -i velvet-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o vqu
	blastall -p blastn -d ${DATA}/fusA.seeds -i velvet-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o vdu
	blastall -p blastn -d ${DATA}/fusA.seeds -i velvet-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o vpu
	blastall -p blastn -d ${DATA}/fusA.seeds -i idba-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o iqu
	blastall -p blastn -d ${DATA}/fusA.seeds -i idba-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o idu
	blastall -p blastn -d ${DATA}/fusA.seeds -i idba-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ipu
	blastall -p blastn -d ${DATA}/fusA.seeds -i spades-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o squ
	blastall -p blastn -d ${DATA}/fusA.seeds -i spades-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o sdu
	blastall -p blastn -d ${DATA}/fusA.seeds -i spades-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o spu
	blastall -p blastn -d ${DATA}/fusA.seeds -i megahit-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o mqu
	blastall -p blastn -d ${DATA}/fusA.seeds -i megahit-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o mdu
	blastall -p blastn -d ${DATA}/fusA.seeds -i megahit-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o mpu

#-------------------------------------------------Blasting Unaligned Reads to QC reads-----------------------------------------------------------------------
unaligned-to-qc: ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz *-unaligned.fa
	cat ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz >${PREFIX}.qc.fq.gz
	gunzip -c ${PREFIX}.qc.fq.gz > ${PREFIX}.qc
	formatdb -i ${PREFIX}.qc -p F
	blastall -p blastn -d ${PREFIX}.qc -i velvet-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qvqu
	blastall -p blastn -d ${PREFIX}.qc -i velvet-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qvdu
	blastall -p blastn -d ${PREFIX}.qc -i velvet-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qvpu
	blastall -p blastn -d ${PREFIX}.qc -i idba-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qiqu
	blastall -p blastn -d ${PREFIX}.qc -i idba-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qidu
	blastall -p blastn -d ${PREFIX}.qc -i idba-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qipu
	blastall -p blastn -d ${PREFIX}.qc -i spades-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qsqu
	blastall -p blastn -d ${PREFIX}.qc -i spades-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qsdu
	blastall -p blastn -d ${PREFIX}.qc -i spades-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qspu
	blastall -p blastn -d ${PREFIX}.qc -i megahit-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qmqu
	blastall -p blastn -d ${PREFIX}.qc -i megahit-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qmdu
	blastall -p blastn -d ${PREFIX}.qc -i megahit-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qmpu

#------------------------------------------------Blasting Unaligned Reads to Reference-----------------------------------------------------------------------
unaligned-ref: ${DATA}/mircea.fa.gz *-unaligned.fa
	gunzip -c ${DATA}/mircea.fa.gz >${DATA}/mircea.fa
	formatdb -i ${DATA}/mircea.fa  -p F 
	blastall -p blastn -d ${DATA}/mircea.fa -i velvet-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refvqu
	blastall -p blastn -d ${DATA}/mircea.fa -i velvet-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refvdu
	blastall -p blastn -d ${DATA}/mircea.fa -i velvet-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refvp
	blastall -p blastn -d ${DATA}/mircea.fa -i idba-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refiqu
	blastall -p blastn -d ${DATA}/mircea.fa -i idba-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refidu
	blastall -p blastn -d ${DATA}/mircea.fa -i idba-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refipu
	blastall -p blastn -d ${DATA}/mircea.fa -i spades-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refsqu
	blastall -p blastn -d ${DATA}/mircea.fa -i spades-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refsdu
	blastall -p blastn -d ${DATA}/mircea.fa -i spades-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refspu
	blastall -p blastn -d ${DATA}/mircea.fa -i megahit-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refmqu
	blastall -p blastn -d ${DATA}/mircea.fa -i megahit-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refmdu
	blastall -p blastn -d ${DATA}/mircea.fa -i megahit-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ZZRefmpu	
#--------------------------------------Quasting Unaligned reads to Unaligned IDBA reads ---------------------------------------------------------------------
unaligned-idba-unaligned:
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o velvet-quality-unaligned/ velvet-quality-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o velvet-diginorm-unaligned/ velvet-diginorm-unaligned.fa   
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o velvet-partition-unaligned/ velvet-partition-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o idba-diginorm-unaligned/ idba-diginorm-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o idba-partition-unaligned/ idba-partition-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o spades-quality-unaligned/ spades-quality-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o spades-diginorm-unaligned/ spades-diginorm-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o spades-partition-unaligned/ spades-partition-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o megahit-quality-unaligned/ megahit-quality-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o megahit-diginorm-unaligned/ megahit-diginorm-unaligned.fa 
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o megahit-partition-unaligned/ megahit-partition-unaligned.fa

#----------------------------------------------------Trying Different min-contig in QUAST parameters --------------------------------------------------------
change-min-contig:
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o vqc-conting-$(i)/ velvet-quality-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o iqc-conting-$(i)/ idba-quality-assembly.fa --min-contig=$(i); )  
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o sqc-conting-$(i)/ spades-quality-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o mqc-conting-$(i)/ megahit-quality-assembly.fa --min-contig=$(i); )
 
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

#---------------------------------------------------------------Cleaning ------------------------------------------------------------------------------------	
clean: *.list *.list.unique
	rm *.list 
	rm *.list.unique  
