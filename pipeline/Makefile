# Targets:
#
#    mircea.fa - putative references for mock community
#    mircea.rm13.fa - references that are > 99% present at k=51
#    assemblies.stats.QC.AMBIGUOUS.99 - reference-based assembly stats
#
#    unmapped-qc-to-ref.fq - reads that don't map to mircea.fa
#    unmapped-qc-to-ref-rm.fq - reads that don't map to mircea.rm13.fa
#    unmapped-mqc-assembly500.fa - megahit assembly of unmapped-qc-to-ref-rm.fq
#
#    unmapped-assemblies - build/count reads that don't map to assemblies
#
#    %.fa.pe.mapped.fa.gz - reads mapped to individual genomes

FULL_REFERENCE=mircea.fa
REFERENCE=mircea.rm13.fa
MYSCRIPTS=./
SPADES=metaspades.py
THREADS=16
MEGAHIT_MEMORY=1e+10

### top level targets

all: install download trim assemble stats analysis

install:
	conda install -y trimmomatic==0.38 khmer==2.1.2 megahit==1.1.3 \
		spades==3.12.0 idba==1.1.3 mummer==3.23 bwa==0.7.17 \
		samtools==1.9 numpy==1.15
	pip2 install screed

download: SRR606249_1.fastq.gz SRR606249_2.fastq.gz genomes/

trim: SRR606249.se.qc.fq.gz SRR606249.pe.qc.fq.gz

run-assembly: idba-quality-assembly.fa spades-quality-assembly.fa \
	megahit-quality-assembly.fa

assemble: idba-quality-assembly500.fa spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa

stats: idba.stats spades.stats megahit.stats

ref-analysis: mircea.fa mircea.rm13.fa ref.x.self.coords \
	assemblies.stats.QC.AMBIGUOUS.99 \
	assemblies.stats.QC.BESTHIT.99 \
	assemblies.stats.QC.NOOVERLAP.99 \
	chimera.sqc50k.txt

read-analysis: unmapped-qc-to-ref-rm.fq unmapped-mqc-assembly500.fa \
	SRR606249.qc.coverage \
	mq-unmapped.count

### download targets

# raw data files
SRR606249_1.fastq.gz:
	curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR606/SRR606249/SRR606249_1.fastq.gz
	chmod a-w SRR606249_1.fastq.gz

SRR606249_2.fastq.gz:
	curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR606/SRR606249/SRR606249_2.fastq.gz
	chmod a-w SRR606249_2.fastq.gz

# SPAdes assembly
spades-quality: SRR606249.pe.qc.fq.gz \
	SRR606249.spades.d/scaffolds.fasta \
	spades-quality-assembly.fa 

# IDBA assembly
idba-quality: SRR606249.pe.qc.fq.gz \
	SRR606249.pe.fa \
	SRR606249.idba.d.qc/scaffold.fa \
	idba-quality-assembly.fa 
# MEGAHIT quality
megahit-quality: SRR606249.pe.qc.fq.gz \
	megahit.qc.pe/final.contigs.fa \
	megahit-quality-assembly.fa

# assembly -> reference-based analysis 
analysis: idba-quality-assembly500.fa spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa \
	mqc500.coords \
	assemblies.stats.QC.AMBIGUOUS.99 \
	assemblies.stats.QC.AMBIGUOUS.95 \
	stats 

#calculate reads coverage 
readcoverage: SRR606249.pe.qc.fq.gz \
	qc-ref.sam \
	unmapped-qc-to-ref \
	SRR606249.qc.coverage
 
### quality trimming

# adapters that come with trimmomatic
TruSeq2-PE.fa:
	cp /opt/miniconda/pkgs/trimmomatic-*/share/trimmomatic-*/adapters/TruSeq2-PE.fa .

# interleaved PE reads
SRR606249.pe.qc.fq.gz:
	interleave-reads.py s1_pe s2_pe | gzip -9c > SRR606249.pe.qc.fq.gz

# orphaned reads
SRR606249.se.qc.fq.gz:
	cat s1_se s2_se | gzip -9c > SRR606249.se.qc.fq.gz

# PE reads
s1_pe: SRR606249_1.fastq.gz SRR606249_2.fastq.gz TruSeq2-PE.fa
	trimmomatic PE SRR606249_1.fastq.gz SRR606249_2.fastq.gz \
		s1_pe s1_se s2_pe s2_se \
		ILLUMINACLIP:TruSeq2-PE.fa:2:40:15 \
		LEADING:2 TRAILING:2 SLIDINGWINDOW:4:2 MINLEN:25
	chmod a-w s1_pe s1_se s2_pe s2_se

# SPAdes assembly
SRR606249.spades.d/scaffolds.fasta: SRR606249.pe.qc.fq.gz SRR606249.se.qc.fq.gz
	/usr/bin/time -a -o sqc.txt  ${SPADES} --pe1-12 SRR606249.pe.qc.fq.gz --pe1-s SRR606249.se.qc.fq.gz -o SRR606249.spades.d -t ${THREADS}

spades-quality-assembly.fa: SRR606249.spades.d/scaffolds.fasta  
	${MYSCRIPTS}/multi-rename.py assembly SRR606249.spades.d/scaffolds.fasta  > spades-quality-assembly.fa

# IDBA assembly

SRR606249.pe.fa: SRR606249.pe.qc.fq.gz 
	fastq-to-fasta.py -n SRR606249.pe.qc.fq.gz >SRR606249.pe.fa

SRR606249.idba.d.qc/scaffold.fa: SRR606249.pe.fa
	/usr/bin/time -a -o iqc.txt idba_ud --num_threads=${THREADS} --pre_correction -r SRR606249.pe.fa -o SRR606249.idba.d.qc 

idba-quality-assembly.fa: SRR606249.idba.d.qc/scaffold.fa
	${MYSCRIPTS}/multi-rename.py assembly SRR606249.idba.d.qc/scaffold.fa > idba-quality-assembly.fa

# megahit assembly:
megahit.qc.pe/final.contigs.fa: SRR606249.pe.qc.fq.gz  
	/usr/bin/time  -a  -o megqc.txt megahit -f -l 101 --cpu-only --presets meta-large --12 SRR606249.pe.qc.fq.gz -t ${THREADS} -m 1e+10 -r SRR606249.se.qc.fq.gz -o megahit.qc.pe 

megahit-quality-assembly.fa: megahit.qc.pe/final.contigs.fa 
	${MYSCRIPTS}/multi-rename.py assembly megahit.qc.pe/final.contigs.fa > megahit-quality-assembly.fa

# length-filtered assemblies
idba-quality-assembly500.fa:  #idba-quality-assembly.fa
	extract-long-sequences.py -l 500 idba-quality-assembly.fa -o idba-quality-assembly500.fa

spades-quality-assembly500.fa: #spades-quality-assembly.fa
	extract-long-sequences.py -l 500 spades-quality-assembly.fa -o spades-quality-assembly500.fa

megahit-quality-assembly500.fa: #megahit-quality-assembly.fa
	extract-long-sequences.py -l 500 megahit-quality-assembly.fa -o megahit-quality-assembly500.fa

### assembly stats

idba.stats: idba-quality-assembly500.fa
	${MYSCRIPTS}/compute_stats.py idba-quality-assembly500.fa ${REFERENCE} > idba.stats

spades.stats: spades-quality-assembly500.fa ${REFERENCE}
	${MYSCRIPTS}/compute_stats.py spades-quality-assembly500.fa ${REFERENCE} > spades.stats

megahit.stats: megahit-quality-assembly500.fa ${REFERENCE}
	${MYSCRIPTS}/compute_stats.py megahit-quality-assembly500.fa ${REFERENCE} > megahit.stats

### reference-based analysis

# remove 13 genomes for crimes of strain variation
${FULL_REFERENCE}: genomes/?.fa genomes/??.fa
	cat genomes/[0-9].fa genomes/[1-6]?.fa > ${FULL_REFERENCE}

${REFERENCE}: ${FULL_REFERENCE}
	python ./subtract-names.py genome-remove-list.txt ${FULL_REFERENCE} > ${REFERENCE}

ref.x.self.coords: ${REFERENCE}
	nucmer --coords -p ref.x.self ${REFERENCE}  ${REFERENCE}

iqc500.coords: ${REFERENCE} idba-quality-assembly500.fa
	nucmer --coords -p  iqc500  ${REFERENCE}  idba-quality-assembly500.fa

sqc500.coords: ${REFERENCE} spades-quality-assembly500.fa
	nucmer --coords -p  sqc500  ${REFERENCE}  spades-quality-assembly500.fa

mqc500.coords: ${REFERENCE} megahit-quality-assembly500.fa
	nucmer --coords -p  mqc500  ${REFERENCE}  megahit-quality-assembly500.fa

mqc500.full.coords: #megahit-quality-assembly500.fa 
	nucmer --coords -p  mqc500.full  ${FULL_REFERENCE} megahit-quality-assembly500.fa

assemblies.stats.QC.AMBIGUOUS.99: mqc500.coords iqc500.coords sqc500.coords
	${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
         megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.AMBIGUOUS.99 -a True 99 

assemblies.stats.QC.BESTHIT.99: mqc500.coords iqc500.coords sqc500.coords
	${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
         megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.BESTHIT.99 -b True 99

assemblies.stats.QC.NOOVERLAP.99: mqc500.coords iqc500.coords sqc500.coords
	${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
         megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.NOOVERLAP.99 -c True 99

assemblies.stats.QC.AMBIGUOUS.95: mqc500.coords
	${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.AMBIGUOUS.95 -a True 95 
	${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.BESTHIT.95 -b True 95
	${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.NOOVERLAP.95 -c True 95

### read-analysis

qc-ref.bam: qc-ref.pe.bam
	samtools merge  qc-ref.bam  qc-ref.pe.bam  qc-ref.se.bam 

qc-ref.pe.bam: ${FULL_REFERENCE} SRR606249.pe.qc.fq.gz SRR606249.se.qc.fq.gz
	bwa index  ${FULL_REFERENCE} 
	bwa aln  ${FULL_REFERENCE}  SRR606249.pe.qc.fq.gz   >  qc-ref.pe.sai 
	bwa aln  ${FULL_REFERENCE}  SRR606249.se.qc.fq.gz   >  qc-ref.se.sai
	bwa samse ${FULL_REFERENCE}  qc-ref.pe.sai  SRR606249.pe.qc.fq.gz >  qc-ref.pe.sam 
	bwa samse  ${FULL_REFERENCE}  qc-ref.se.sai  SRR606249.se.qc.fq.gz >  qc-ref.se.sam
	samtools faidx  ${FULL_REFERENCE} 
	samtools import  ${FULL_REFERENCE}.fai  qc-ref.pe.sam  qc-ref.pe.bam 
	samtools import  ${FULL_REFERENCE}.fai  qc-ref.se.sam  qc-ref.se.bam 
	-rm qc-ref.bam

qc-ref.sam: qc-ref.bam
	-rm qc-ref.sam
	samtools view -h -o  qc-ref.sam  qc-ref.bam

unmapped-qc-to-ref: qc-ref.pe.bam
	samtools view -h -o  qc-ref.pe.sam  qc-ref.pe.bam
	samtools view -h -c -f 4  qc-ref.pe.bam >> unmapped-qc-to-ref 
	samtools view -h -o  qc-ref.se.sam  qc-ref.se.bam
	samtools view -h -c -f 4  qc-ref.se.bam >> unmapped-qc-to-ref

unmapped-qc-to-ref.fq: qc-ref.bam
	samtools view -f 4 -b qc-ref.bam > unmapped-qc-to-ref.bam
	samtools bam2fq unmapped-qc-to-ref.bam > unmapped-qc-to-ref.fq

qc-ref-rm.sam: ${REFERENCE} SRR606249.pe.qc.fq.gz
	bwa index  ${REFERENCE} 
	bwa aln  ${REFERENCE}  SRR606249.pe.qc.fq.gz   >  qc-ref-rm.pe.sai 
	bwa aln  ${REFERENCE}  SRR606249.se.qc.fq.gz   >  qc-ref-rm.se.sai
	bwa samse ${REFERENCE}  qc-ref-rm.pe.sai  SRR606249.pe.qc.fq.gz >  qc-ref-rm.pe.sam 
	bwa samse  ${REFERENCE}  qc-ref-rm.se.sai  SRR606249.se.qc.fq.gz >  qc-ref-rm.se.sam
	samtools faidx  ${REFERENCE} 
	samtools import  ${REFERENCE}.fai  qc-ref-rm.pe.sam  qc-ref-rm.pe.bam 
	samtools import  ${REFERENCE}.fai  qc-ref-rm.se.sam  qc-ref-rm.se.bam 
	samtools merge  -f qc-ref-rm.bam  qc-ref-rm.pe.bam  qc-ref-rm.se.bam 
	samtools view -h -o  qc-ref-rm.sam  qc-ref-rm.bam

unmapped-qc-to-ref-rm: qc-ref-rm.sam 
#	samtools view -h -o  qc-ref-rm.pe.sam  qc-ref-rm.pe.bam
	samtools view -h -c -f 4  qc-ref-rm.pe.bam >> unmapped-qc-to-ref-rm
#	samtools view -h -o  qc-ref-rm.se.sam  qc-ref-rm.se.bam
	samtools view -h -c -f 4  qc-ref-rm.se.bam >> unmapped-qc-to-ref-rm

unmapped-qc-to-ref-rm.fq: unmapped-qc-to-ref-rm
	cat unmapped-qc-to-ref-rm | grep -v ^@ | awk '{print "@"$1"\n"$10"\n+\n"$11}' > unmapped-qc-to-ref-rm.fq

#	samtools bam2fq unmapped-qc-to-ref-rm.bam > unmapped-qc-to-ref-rm.fq

unmapped-mqc-assembly500.fa: unmapped-qc-to-ref.fq
	megahit -f -l 101 -m 1e+10 --cpu-only --presets meta-large -r unmapped-qc-to-ref.fq -o unmapped-mqc-assembly
	extract-long-sequences.py unmapped-mqc-assembly/final.contigs.fa -l 500 -o unmapped-mqc-assembly500.fa

unmapped-mqc-rm-assembly500.fa: unmapped-qc-to-ref-rm.fq
	megahit -f -l 101 -m 1e+10 --cpu-only --presets meta-large -r unmapped-qc-to-ref-rm.fq -o unmapped-mqc-rm-assembly
	extract-long-sequences.py unmapped-mqc-rm-assembly/final.contigs.fa -l 500 -o unmapped-mqc-rm-assembly500.fa

SRR606249.qc.coverage: qc-ref.sam
	${MYSCRIPTS}/coverage-profile.py  ${REFERENCE}  qc-ref.sam  SRR606249.qc.coverage 

### read mapping analysis

unmapped-assemblies: iq-unmapped.count mq-unmapped.count sq-unmapped.count

iq-unmapped.count:  SRR606249.pe.qc.fq.gz  megahit-quality-assembly500.fa
	bwa index  idba-quality-assembly500.fa 
	bwa aln  idba-quality-assembly500.fa  SRR606249.pe.qc.fq.gz   >  iq.pe.sai 
	bwa aln  idba-quality-assembly500.fa  SRR606249.se.qc.fq.gz   >  iq.se.sai 
	bwa samse  idba-quality-assembly500.fa  iq.pe.sai  SRR606249.pe.qc.fq.gz >  iq.pe.sam 
	bwa samse  idba-quality-assembly500.fa  iq.se.sai  SRR606249.se.qc.fq.gz >  iq.se.sam
	samtools faidx  idba-quality-assembly500.fa 
	samtools import  idba-quality-assembly500.fa.fai  iq.pe.sam  iq.pe.bam 
	samtools import  idba-quality-assembly500.fa.fai  iq.se.sam  iq.se.bam 
	samtools faidx  idba-quality-assembly500.fa 
	samtools import  idba-quality-assembly500.fa.fai  iq.pe.sam  iq.pe.bam 
	samtools import  idba-quality-assembly500.fa.fai  iq.se.sam  iq.se.bam 
	samtools view -c -f 4  iq.pe.bam >  iq-unmapped.count
	samtools view -c -f 4  iq.se.bam >>  iq-unmapped.count 

sq-unmapped.count: SRR606249.pe.qc.fq.gz  megahit-quality-assembly500.fa
	bwa index  spades-quality-assembly500.fa 
	bwa aln  spades-quality-assembly500.fa  SRR606249.pe.qc.fq.gz   >  sq.pe.sai 
	bwa aln  spades-quality-assembly500.fa  SRR606249.se.qc.fq.gz   >  sq.se.sai 
	bwa samse  spades-quality-assembly500.fa  sq.pe.sai  SRR606249.pe.qc.fq.gz >  sq.pe.sam 
	bwa samse  spades-quality-assembly500.fa  sq.se.sai  SRR606249.se.qc.fq.gz >  sq.se.sam 
	samtools faidx  spades-quality-assembly500.fa 
	samtools import  spades-quality-assembly500.fa.fai  sq.pe.sam  sq.pe.bam 
	samtools import  spades-quality-assembly500.fa.fai  sq.se.sam  sq.se.bam 
	samtools view -c -f 4  sq.pe.bam >  sq-unmapped.count
	samtools view -c -f 4  sq.se.bam >>  sq-unmapped.count

mq-unmapped.count: SRR606249.pe.qc.fq.gz megahit-quality-assembly500.fa
	bwa index  megahit-quality-assembly500.fa 
	bwa aln  megahit-quality-assembly500.fa  SRR606249.pe.qc.fq.gz   >  mq.pe.sai 	
	bwa aln  megahit-quality-assembly500.fa  SRR606249.se.qc.fq.gz   >  mq.se.sai 
	bwa samse  megahit-quality-assembly500.fa  mq.pe.sai  SRR606249.pe.qc.fq.gz >  mq.pe.sam 
	bwa samse  megahit-quality-assembly500.fa  mq.se.sai  SRR606249.se.qc.fq.gz >  mq.se.sam 
	samtools faidx  megahit-quality-assembly500.fa 
	samtools import  megahit-quality-assembly500.fa.fai  mq.pe.sam  mq.pe.bam 
	samtools import  megahit-quality-assembly500.fa.fai  mq.se.sam  mq.se.bam 
	samtools view -c -f 4  mq.pe.bam >  mq-unmapped.count
	samtools view -c -f 4  mq.se.bam >>  mq-unmapped.count


#------------------------------------------------------------Kmer Abundance---------------------------------------------------------------------------------
mqc500.dist: SRR606249.pe.qc.fq.gz megahit-quality-assembly500.fa
	gunzip -c SRR606249.pe.qc.fq.gz > SRR606249.pe.qc.fastq 
	gunzip -c SRR606249.se.qc.fq.gz > SRR606249.se.qc.fastq  
	load-into-counting.py -x 2e9 -N 4 -k 20 qc.counts.kh SRR606249.pe.qc.fastq SRR606249.se.qc.fastq 
	abundance-dist.py -s qc.counts.kh ${REFERENCE} SRR606249.qc.dist -s
	cat SRR606249.pe.qc.fastq SRR606249.se.qc.fastq  > SRR606249-qc.fastq 
	abundance-dist.py qc.counts.kh SRR606249-qc.fastq qc.dist -s
	cat idba-quality-assembly500.fa spades-quality-assembly500.fa megahit-quality-assembly500.fa > qc-assembly500.fa 
	abundance-dist.py -s qc.counts.kh qc-assembly500.fa qc500.dist -s
	abundance-dist.py -s qc.counts.kh idba-quality-assembly500.fa  iqc500.dist -s
	abundance-dist.py -s qc.counts.kh spades-quality-assembly500.fa  sqc500.dist -s
	abundance-dist.py -s qc.counts.kh megahit-quality-assembly500.fa mqc500.dist -s

### individual genomes & mapped reads

genomes/:
	mkdir -p genomes
	-rm genomes/{?,??}.fa 
	curl -L -o genomes/podar-reference-genomes-updated-2017.06.10.tar.gz https://osf.io/8uxj9/?action=download
	cd genomes && tar xzf podar-reference-genomes-updated-2017.06.10.tar.gz

%.fa.pe.mapped.fa.gz: genomes/%.fa SRR606249.pe.qc.fq.gz SRR606249.se.qc.fq.gz
	./get-aligned-reads.sh $< SRR606249.pe.qc.fq.gz SRR606249.se.qc.fq.gz

%.fa.se.mapped.fa.gz: %.fa.pe.mapped.fa.gz

%.fa.cov.txt: %.fa.pe.mapped.fa.gz

### chimeric

chimera.sqc50k.txt:
	./analyze_chimeric2.py mircea.rm13.fa megahit-quality-assembly500.fa mqc500.coords -l 500 --save-contigs mqc.chimeric.contigs > chimera.mqc500.txt
	./analyze_chimeric2.py mircea.rm13.fa idba-quality-assembly500.fa iqc500.coords -l 500 --save-contigs iqc.chimeric.contigs > chimera.iqc500.txt
	./analyze_chimeric2.py mircea.rm13.fa spades-quality-assembly500.fa sqc500.coords -l 500 --save-contigs sqc.chimeric.contigs > chimera.sqc500.txt
	./analyze_chimeric2.py mircea.rm13.fa megahit-quality-assembly500.fa mqc500.coords -l 5000 > chimera.mqc5k.txt
	./analyze_chimeric2.py mircea.rm13.fa idba-quality-assembly500.fa iqc500.coords -l 5000 > chimera.iqc5k.txt
	./analyze_chimeric2.py mircea.rm13.fa spades-quality-assembly500.fa sqc500.coords -l 5000 > chimera.sqc5k.txt
	./analyze_chimeric2.py mircea.rm13.fa megahit-quality-assembly500.fa mqc500.coords -l 50000 > chimera.mqc50k.txt
	./analyze_chimeric2.py mircea.rm13.fa idba-quality-assembly500.fa iqc500.coords -l 50000 > chimera.iqc50k.txt
	./analyze_chimeric2.py mircea.rm13.fa spades-quality-assembly500.fa sqc500.coords -l 50000 > chimera.sqc50k.txt

### sourmash stuff / Jaccard comparison foo

sigs: SRR606249.sig mircea.fa.sig SRR606245.sig SRR606249-trimV.sig \
	idba-quality-assembly500.fa.sig \
	megahit-quality-assembly500.fa.sig \
	spades-quality-assembly500.fa.sig SRR606249-hardtrim.sig

SRR606245.sig:
	sourmash compute --scaled 10000 -k 21,31,41,51 SRR606245.fastq.gz -o SRR606245.sig

SRR606249.sig:
	gunzip -c SRR606249.?e.qc.fq.gz | sourmash compute --scaled 10000 -k 21,31,41,51 - -o SRR606249.sig

SRR606249-trimV-foo:
	trim-low-abund.py -k 31 -M 20e9 -C 3 -Z 20 SRR606249.pe.qc.fastq SRR606249.se.qc.fastq --gzip -V

SRR606249-trimV.sig:
	gunzip -c SRR606249.?e.qc.fastq.abundtrim.gz | sourmash compute --scaled 10000 -k 21,31,41,51 - -o SRR606249-trimV.sig

SRR606249-hardtrim:
	trim-low-abund.py -k 31 -M 20e9 -C 5 SRR606249.pe.qc.fastq SRR606249.se.qc.fastq --gzip -o SRR606249.hardtrim.qc.fq.gz

SRR606249-hardtrim.sig: SRR606249-hardtrim
	gunzip -c SRR606249.hardtrim.qc.fq.gz | sourmash compute --scaled 10000 -k 21,31,41,51 - -o SRR606249-hardtrim.sig

mircea.fa.sig: ${FULL_REFERENCE}
	sourmash compute --scaled 10000 -k 21,31,41,51 mircea.fa -o mircea.fa.sig

${REFERENCE}.sig: ${REFERENCE}
	sourmash compute --scaled 10000 -k 21,31,41,51 ${REFERENCE} -o ${REFERENCE}.sig	

idba-quality-assembly500.fa.sig: #idba-quality-assembly500.fa
	sourmash compute --scaled 10000 -k 21,31,41,51 idba-quality-assembly500.fa -o idba-quality-assembly500.fa.sig

megahit-quality-assembly500.fa.sig: #megahit-quality-assembly500.fa
	sourmash compute --scaled 10000 -k 21,31,41,51 megahit-quality-assembly500.fa -o megahit-quality-assembly500.fa.sig

spades-quality-assembly500.fa.sig: #spades-quality-assembly500.fa
	sourmash compute --scaled 10000 -k 21,31,41,51 spades-quality-assembly500.fa -o spades-quality-assembly500.fa.sig

unmapped-mqc-assembly500.fa.sig: unmapped-mqc-assembly500.fa
	sourmash compute --scaled 10000 -k 21,31,41,51 unmapped-mqc-assembly500.fa -o unmapped-mqc-assembly500.fa.sig

unmapped-mqc-rm-assembly500.fa.sig: unmapped-mqc-rm-assembly500.fa
	sourmash compute --scaled 10000 -k 21,31,41,51 unmapped-mqc-rm-assembly500.fa -o unmapped-mqc-rm-assembly500.fa.sig

### garbage targets for Titus.

bar:
	nucmer --coords -p bestunal unaligned/best-matches.fa unmapped-mqc-assembly500.fa

bar-count:
	./summarize-coords.py bestunal.coords

bar2:
	nucmer --coords -p bestunal-vs-mirc mircea.fa unmapped-mqc-assembly500.fa

bar2-count:
	./summarize-coords.py bestunal-vs-mirc.coords

bar3:
	nucmer --coords -p os223-vs-megahit genomes/63.fa megahit-quality-assembly500.fa

bar4:
	nucmer --coords -p os223-vs-os185 genomes/63.fa genomes/47.fa

bar5:
	nucmer --coords -p os185-vs-megahit genomes/47.fa megahit-quality-assembly500.fa

bar6:
	./summarize-coords.py os185-vs-megahit.coords genomes/47.fa
	wc genomes/47.fa
	./summarize-coords.py os223-vs-megahit.coords genomes/63.fa
	wc genomes/63.fa

bar7:
	#for i in genomes/*.fa; do ./summarize-coords2.py mqc500.coords $i > $(basename $i).mqc.aligncov.txt; echo $i; done
	for i in genomes/*.fa; do ./summarize-coords2.py sqc500.coords $i > $(basename $i).sqc.aligncov.txt; echo $i; done
	for i in genomes/*.fa; do ./summarize-coords2.py iqc500.coords $i > $(basename $i).iqc.aligncov.txt; echo $i; done

nga50: sqc.ng50.txt

sqc.ng50.txt: sqc500.coords mircea.rm13.fa spades-quality-assembly500.fa
	./analyze_ng50.py iqc500.coords mircea.rm13.fa idba-quality-assembly500.fa > iqc.ng50.txt
	./analyze_ng50.py mqc500.coords mircea.rm13.fa megahit-quality-assembly500.fa > mqc.ng50.txt
	./analyze_ng50.py sqc500.coords mircea.rm13.fa spades-quality-assembly500.fa > sqc.ng50.txt

bar8:
	sourmash gather unmapped-mqc-assembly500.fa.sig -k 31 ~/dev/sourmash/genbank/genbank-k31.sbt.json -o unmapped-mqc-assembly500.fa.sig.gather.k31.csv > unmapped-mqc-assembly500.fa.sig.gather.k31.txt
