
import numpy
import screed
import sys

def _load_coords(filename, only=None):
    lines = [ x.strip() for x in (open(filename)) ]
    assert lines[1].startswith('NUCMER'), lines[0]

    coords = []
    for line_no in range(5, len(lines)):
        line = lines[line_no].split()
        s1, e1 = int(line[0]), int(line[1])
        s2, e2 = int(line[3]), int(line[4])
        ident = float(line[9])
        name1, name2 = line[11], line[12]
        s1, e1 = min(s1, e1), max(s1, e1)
        s2, e2 = min(s2, e2), max(s2, e2)

        yield (s1, e1, s2, e2, ident, name1, name2)

def load_refsizes(filename):
    d = {}
    for record in screed.open(filename):
        d[record.name.split()[0]] = len(record.sequence)
    return d

def load_sequence(filename): 
    d = {}
    for record in screed.open(filename):
	       d[record.name.split()[0]] = record.sequence
    return d


class GenomeIntervalsContainer(object):
    def __init__(self, refsizes):
        self.names = refsizes.keys()
        self.refsizes = refsizes
        trees = {}
        for k in self.names:
            trees[k] = numpy.zeros(refsizes[k])
        self.trees = trees

    def load_coords(self, filename, min_length=100, min_ident=99.0):
        trees = self.trees
        for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
            if name1 in trees:
                tree = trees[name1]
                if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    tree[s1 - 1:e1] = numpy.ones(e1 - s1 + 1)

    def calc_uncov(self):
        uncov_d = {}
        for name in self.refsizes:
            length = self.refsizes[name]
            cov = sum(self.trees[name])


            uncov = length - cov
            uncov_d[name] = uncov
        return uncov_d

	
def main():

    assembly =sys.argv[1]
    ref =sys.argv[2]
    coords= sys.argv[3]

    print 'loading refsizes'
    refsizes = load_refsizes(ref)
    
    print 'loading coords'
    
    reference =load_sequence(assembly)

    gic = GenomeIntervalsContainer(refsizes)
    gic.load_coords(coords)

    uncov_d = gic.calc_uncov()
    total_bp = sum(gic.refsizes.values())
    total_uncov = sum(uncov_d.values())
   
    print 'Total base pairs of', assembly, ' = ', total_bp 
    print 'Total uncovered of', assembly, ' = ',  total_uncov/total_bp *100, '%' 
    print 'Genome Fraction of', assembly, ' = ', 100-(total_uncov/total_bp *100), '%'

if __name__ == '__main__':
    main()
