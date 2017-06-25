import random

def make_random_genome(L):
    nt = ['A', 'C', 'T', 'G']

    genome = nt*int(L/4)
    random.shuffle(genome)
    genome = "".join(genome)
    return genome

def make_contigs(genome, ivals):
    x = []
    for (start, length) in ivals:
        assert start >= 0 and start < len(genome)
        contig = genome[start:start + length]
        x.append(contig)
    return x

def write_genome_and_contigs(dirname, genomes, contigs):
    import os, shutil
    shutil.rmtree(dirname, ignore_errors=True)
    os.mkdir(dirname)
    
    fp = open('%s/genome.fa' % (dirname,), 'w')
    for n, genome in enumerate(genomes):
        print >>fp, ">genome%d\n%s" % (n, genome,)
    fp.close()

    fp = open('%s/contigs.fa' % (dirname,), 'w')
    for i in range(len(contigs)):
        print >>fp, ">contig%d\n%s" % (i, contigs[i])
    fp.close()
