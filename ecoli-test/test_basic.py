from create_data import make_random_genome, make_contigs, \
     write_genome_and_contigs

from utils import TempStuff

def test_basic():
    genome = make_random_genome(1e5)

    contig_ivals = [(0, int(1e5))]
    contigs = make_contigs(genome, contig_ivals)

    write_genome_and_contigs('test_basic', [genome], contigs)

def test_basic2():
    L2 = 10000
    genome = make_random_genome(1e5)

    contig_ivals = [(10000, L2), (50000, L2)]
    contigs = make_contigs(genome, contig_ivals)

    write_genome_and_contigs('test_basic2', [genome], contigs)

test_basic()
test_basic2()
