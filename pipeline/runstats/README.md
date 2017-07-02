# Assembler install and execute information + benchmarks

## Download and install SPAdes

```
wget http://cab.spbu.ru/files/release3.10.1/SPAdes-3.10.1-Linux.tar.gz
tar xzf SPAdes-3.10.1-Linux.tar.gz
```

## Run SPAdes

```
/usr/bin/time -v -a -o sqc.txt ~/SPAdes-3.10.1-Linux/bin/metaspades.py -t 16 --p
e1-12 SRR606249.pe.qc.fq.gz --pe1-s SRR606249.se.qc.fq.gz -o podar
```

['time' output file](sqc.txt) - [spades.log](spades/spades.log)

## Download and install IDBA

```
curl -L https://github.com/loneknightpy/idba/releases/download/1.1.3/idba-1.1.3.tar.gz -O
tar xzf idba-1.1.3.tar.gz
cd idba-1.1.3/
./configure
make
```

## Run IDBA
```
fastq-to-fasta.py -n SRR606249.pe.qc.fq.gz | gzip -9c > SRR606249.pe.qc.fa.gz

/usr/bin/time -v -a -o iqc.txt ~/idba-1.1.3/bin/idba_ud --num_threads=16 --pre_c
orrection -r SRR606249.pe.qc.fa -o SRR606249.idba.d.qc
```

['time' output file](iqc.txt) - [log file](idba/log)

## Clone and install MEGAHIT

```
git clone https://github.com/voutcn/megahit.git
cd megahit
make -j 6
```

## Run MEGAHIT

```
/usr/bin/time -v -a -o mqc.txt ~/megahit/megahit -f -l 101 --cpu-only --presets meta-large --12 SRR606249.pe.qc.fq.gz -t 16 -m 1e+10 -r SRR606249.se.qc.fq.gz -o megahit.qc.pe
```

['time' output file](mqc.txt) - [megahit log](megahit/log)
