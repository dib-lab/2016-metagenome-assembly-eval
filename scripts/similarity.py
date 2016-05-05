import numpy
import screed
import sys
import argparse

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

    def subtract(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        otrees = other.trees
        
        for name in self.refsizes:
            ttree = self.trees[name]
            otree = otrees[name]
            newtree = ttree - numpy.logical_and(ttree, otree)
            new_gic.trees[name] = newtree

        return new_gic

    def union(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        otrees = other.trees
        
        for name in self.refsizes:
            ttree = self.trees[name]
            otree = otrees[name]
            newtree = numpy.logical_or(ttree, otree)
            new_gic.trees[name] = newtree

        return new_gic
    
    def intersect(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        otrees = other.trees
        
        for name in self.refsizes:
            ttree = self.trees[name]
            otree = otrees[name]
            newtree = numpy.logical_and(ttree, otree)
            new_gic.trees[name] = newtree

        return new_gic


    def window_slide(self, other, win,  cutoff,n):
	total_regions1 ={}
 	total_regions2 ={}
	for i in xrange(0,n):
		total_regions1[i]=0
		total_regions2[i]=0
	window=win
        i =0
        sum1 =0
        sum2 =0 
        index1 =0 
        index2 =0
     	for k in self.trees:
           i=0
           window =win
	   while i < len(self.trees[k]):
		for j in xrange(i,window):
 			if self.trees[k][j] ==1:
				sum1+=1 
                        if other.trees[k][j] ==1:
                                sum2+=1
		i+=window
                window +=win
                #print 'Values are currently :', i,j, window, index1, index2, sum1, sum2
		if sum1 >= cutoff: 
			total_regions1[index1]=1
                        index1+=1
			sum1 =0
                if sum2 >=cutoff: 
			total_regions2[index2]=1
			index2+=1 
			sum2 =0
        f11 =0 
	f10 =0 
        f01 =0 
        f00 =0 

	for i in xrange (0,len(total_regions1)):
	      if total_regions1[i] + total_regions2[i] ==2: 
			f11 +=1
	      elif total_regions1[i] + total_regions2[i] ==0:
			f00 +=1
	      elif (total_regions1[i] ==1) and (total_regions2[i] ==0): 
			f10 +=1
	      elif (total_regions2[i] ==1) and (total_regions1[i] ==0): 
			f01 +=1
        
        
        f1plus =  float(f11 + f10)
        fplus1 =  float (f11 + f01)
        N = f11 +f10 + f01 +f00
        jaccardsim = float(f11) /float (f1plus + fplus1 -f11)
        interest = float(N*f11) / float(f1plus*fplus1)
        oddratio = float(f11*f00)+0.1 /float( (0.1)+(f10*f01)) #la place smoothing to avoid division by zero   
   
	return jaccardsim, interest, oddratio   
		

    def analyze(self, infile, outfile,refsizes):
             fout =open(outfile, 'a')
             self.load_coords(infile)
             gic_uncov_d = self.calc_uncov()
             for name in gic_uncov_d:
                  print >>fout, name, gic_uncov_d[name]
             total_bp = sum(self.refsizes.values())
             total_uncov = sum(gic_uncov_d.values())
             print >>fout, "For ", infile, total_bp, total_uncov, float(total_uncov) / total_bp


    def compare(self, other, outfile, refsizes):

           fout =open(outfile, 'w+')
           refsizes = load_refsizes('mircea.fa')
           gic1 =self
           gic2 =other

           intersect_gic12 = gic1.intersect(gic2)
           print >>fout, 'intersect',  sum(intersect_gic12.calc_uncov().values())

           union_gic12 = gic1.union(gic2)
           print >>fout, 'union',  sum(union_gic12.calc_uncov().values())

           total_bp_intersect = sum(intersect_gic12.refsizes.values()) 
           total_bp_union =sum(union_gic12.refsizes.values())

           nume =  total_bp_intersect - sum(intersect_gic12.calc_uncov().values() )
           denim = total_bp_union - sum(union_gic12.calc_uncov().values() )  
           
           jaccard_sim12= float(nume) / float (denim)

           print >>fout, 'Jaccard Similarity between is:', jaccard_sim12

		
def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('reference')
    parser.add_argument('assem1')
    parser.add_argument('assem2')
    parser.add_argument('assem3')

    args = parser.parse_args()

	
    print 'loading refsizes'
    refsizes = load_refsizes(args.reference)
    reference =load_sequence(args.reference) 

    gic_iqc =GenomeIntervalsContainer(refsizes)
    gic_mqc =GenomeIntervalsContainer(refsizes) 
    gic_sqc =GenomeIntervalsContainer(refsizes) 

    prefix1 = args.assem1.split('.')[0]
    prefix2 = args.assem2.split('.')[0]
    prefix3 = args.assem3.split('.')[0] 
    
    outfile1 = prefix1 + '.analysis'
    outfile2 = prefix2 + '.analysis' 
    outfile3 = prefix3 + '.analysis' 

    gic_iqc.analyze(args.assem1, outfile1, refsizes)
    gic_mqc.analyze(args.assem2, outfile2, refsizes)
    gic_sqc.analyze(args.assem3, outfile3, refsizes)

    outfile4 = prefix1 + '.' + prefix2 
    outfile5 = prefix1 + '.' + prefix3 
    outfile6 = prefix2 + '.' + prefix3  
    
    gic_iqc.compare(gic_sqc, outfile4, refsizes) 
    gic_iqc.compare(gic_mqc, outfile5, refsizes) 
    gic_mqc.compare(gic_sqc, outfile6, refsizes)
 
    """
    js, interest, odd  = gic_iqc.window_slide(gic_mqc, 1000, 800, len(reference)) 
    print "Comparing IQC and MQC we have Jaccard Similarity = " , js 
	
    js, interest, odd = gic_iqc.window_slide(gic_sqc, 1000, 800, len(reference)) 
    print "Comparing IQC and SQC we have Jaccard Similarity = " , js

    js, interest, odd = gic_sqc.window_slide(gic_mqc, 1000, 800, len(reference)) 
    print "Comparing SQC and MQC we have Jaccard Similarity = " , js  
    """

if __name__ == '__main__':
    main()
