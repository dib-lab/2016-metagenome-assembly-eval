#! /usr/bin/env python
from __future__ import print_function
import argparse

import numpy
import screed
import sys
from collections import defaultdict

# load a .coords file output by nucmer
def _load_coords(filename, only=None):
    lines = [ x.strip() for x in (open(filename)) ]
    assert lines[1].startswith('NUCMER'), lines[0]
    
    # process each line into (s1, e1, _, s2, e2, ..., % ident, _, name1, name2)
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

# load reference sequences into two dicts, one (name: len), other (name: seq)
def load_reference(filename):
    d = {}
    s = {}
    for record in screed.open(filename):
        d[record.name.split()[0]] = len(record.sequence) 
        s[record.name.split()[0]] = record.sequence
    return d, s 

# load the assembly in - @CTB this is identical to load_reference, right?
def load_assembly(assembly): 
    d = {}
    s = {}
    for record in screed.open(assembly):
        d[record.name.split()[0]] = len(record.sequence)
        s[record.name.split()[0]] = record.sequence
    return d, s 


def best_hit(a, b):
    return a >=  b

def no_overlaps(a, b):
    return a == b
  
class GenomeIntervalsContainer(object):
    def __init__(self, refsizes, assemblysize, assembly):
        self.names = refsizes.keys()
        self.refsizes = refsizes
        self.contigs = assemblysize.keys()
        self.assemsizes =assemblysize
        self.sequences = assembly
        covered = {}
        aligned = {} 
        regions = {} 
        overlaps_s1 = {} 
        overlaps_e1 = {} 
        overlaps_s2 = {} 
        overlaps_e2 = {} 
        overlaps_identity = {} 
        contigs_overlaps = {}
        overlaps_genome = {} 
        regions = {}
        for k in self.names:
            covered[k] = numpy.zeros(refsizes[k])
            regions[k] = numpy.zeros(refsizes[k])
        
        self.covered = covered
        for k in self.contigs:
            aligned[k] = numpy.zeros(assemblysize[k])
            overlaps_s1[k] = 0 
            overlaps_s2[k] = 0 
            overlaps_e1[k] = 0
            overlaps_e2[k] = 0 
            overlaps_identity[k] = 0       
            contigs_overlaps[k] = 0
            overlaps_genome[k] = "null"

        self.overlaps_s1 = overlaps_s1
        self.overlaps_s2 = overlaps_s2 
        self.overlaps_e1 = overlaps_e1
        self.overlaps_e2 = overlaps_e2 
        self.overlaps_identity = overlaps_identity
        self.contigs_overlaps = contigs_overlaps 
        self.overlaps_genome = overlaps_genome  
        self.regions = regions  
 
        self.aligned = aligned

    # used for 'besthit' calculation.
    def load_overlaps(self, filename, min_ident, comparison=best_hit,
                      min_length=100):
        covered = self.covered
        aligned = self.aligned
        
        # here, name2 is the name of the assembly contig
        for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
            if ident < min_ident:
                continue

            # first time seeing this overlap?
            if name1 in covered and name2 in aligned \
                   and self.contigs_overlaps[name2] == 0:
                self.overlaps_s1[name2] = s1
                self.overlaps_e1[name2] = e1
                self.overlaps_s2[name2] = s2
                self.overlaps_e2[name2] = e2
                self.overlaps_genome[name2] = name1
                self.overlaps_identity[name2] = ident
                self.contigs_overlaps[name2] += 1
 
            # no, seen an overlap before --
            elif name1 in covered and name2 in aligned and \
                   self.contigs_overlaps[name2] > 0:

                # we already know the identity is >= min_ident, but be safe!
                assert ident >= min_ident

                oldlen = self.overlaps_e1[name2] - self.overlaps_s1[name2]
                newlen = e1 - s1

                if oldlen < newlen: # replace with longer!
                    print(e1 - s1, oldlen, ident, self.overlaps_identity[name2])
                    self.overlaps_s1[name2] = s1
                    self.overlaps_e1[name2] = e1
                    self.overlaps_s2[name2] = s2
                    self.overlaps_e2[name2] = e2
                    self.overlaps_genome[name2] = name1  
                    self.overlaps_identity[name2] = ident
                    self.contigs_overlaps[name2] +=1  

        # iterate over all the overlaps,
        for name2 in self.overlaps_s1:

            # get the best (longest that is over min_identity) overlap
            name1 = self.overlaps_genome[name2]
            
            # @CTB when would name1/name2 not be in covered/aligned?
            # here 'comparison' is configurable to require either
            # exactly 1 (no-misassemblies) or >= 1 (besthit) matches.
            if (name1 in covered) and (name2 in aligned) and \
                (name1 != "null") and \
                comparison(self.contigs_overlaps[name2], 1):
                 cov = covered[name1]
                 align = aligned[name2]
                 s1 = self.overlaps_s1[name2]
                 e1 = self.overlaps_e1[name2]
                 s2 = self.overlaps_s2[name2]
                 e2 = self.overlaps_e2[name2]
                 ident = self.overlaps_identity[name2]

                 # ok, add coverage/# of alignments if alignment passes.
                 if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    for i in range(s1 - 1, e1):
                        cov[i] += 1
                    for j in range(s2 - 1, e2):
                        align[j] +=1

    # load_coords: used for 'ambiguous' calculation.
    def load_coords(self, filename, min_ident, min_length=100):
        covered = self.covered
        aligned = self.aligned

        for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
            if name1 in covered and name2 in aligned:
                cov = covered[name1]
                align = aligned[name2]

                if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    for i in range(s1 -1, e1):
                        cov[i] += 1
                    for j in range(s2-1, e2):
                        align[j] +=1

    # load_contigs_uniq:
    def load_contigs_uniq(self, filename, min_ident, min_length=100):
        """
        return only the alignments uniqifed by longest match - 
         * sort by match length against contig
         * return the first (longest) alignment of that contig
         * only return additional alignments if they are to different portions
           of the contig.
        """
        covered = self.covered
        aligned = self.aligned
        total = 0

        # store contigs by name
        contig_ival_list = defaultdict(list)
        for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
            if name1 in covered and name2 in aligned:
                if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    x = contig_ival_list[name2]
                    x.append([s1, e1, s2, e2, ident, name1, name2])
                    total += 1

        # now, for each contig name, sort the list by length (top down)
        def sort_matches_by_length(a, b):
            l1 = a[1] - a[0] + 1
            l2 = b[1] - b[0] + 1
            if l1 == l2:
                return -cmp(a[4], b[4]) # secondary sort on identity
            else:
                return -cmp(l1, l2)

        def get_length_ident(a):
            return (-(a[1] - a[0] + 1), -a[4])

        # go through and eliminate matches where the same part of one
        # contig matches to multiple genomic regions.
        keep = []
        skipped = 0
        for k in contig_ival_list:
            contig_ival_list[k].sort(key=get_length_ident)

            # dumb and expensive but simple
            this_contig_cov = {}
            for (s1, e1, s2, e2, ident, gname, cname) in contig_ival_list[k]:
                this_contig_cov[cname] = numpy.zeros(self.assemsizes[cname])

            for (s1, e1, s2, e2, ident, gname, cname) in contig_ival_list[k]:
                ccov = this_contig_cov[cname]
                cov = sum(ccov[s2 - 1:e2]) / float(e2 - s2+ 1)
                if cov == 1.0: # complete overlap? skip this alignment.
                    skipped += 1
                    continue

                # record that we're keeping this alignment
                for i in range(s2 - 1, e2):
                    ccov[i] = 1

                keep.append((s1, e2, s2, e2, ident, gname, cname))

        print('skipped:', skipped, 'of', total, file=sys.stderr)
        return keep


    def calc_uncov(self):
        uncov_d = {}
        for name in self.refsizes:
            cov = 0 
            length = self.refsizes[name]
            for i in self.covered[name]: 
                if i > 0: 
                    cov += 1
            uncov = length - cov
            uncov_d[name] = uncov
        return uncov_d

    def calc_unalignments(self, out1, out2, out3): 
       ftotal = open(out1, 'w+') 
       fpartial = open(out2, 'w+')
       funaligned = open(out3, 'w+')  
       unaligned = {} 
       totally_aligned_contigs = 0
       partially_aligned_contigs = 0
       unaligned_contigs = 0
       partiall_aligned_contigs = 0
       align_total_bases = 0 
       palign_total_bases = 0
       unalign_total_bases = 0 
       for name in self.assemsizes:
            align = 0
            length = self.assemsizes[name]
            for i in self.aligned[name]: 
                if i > 0: 
                    align += 1 
            if align == length:
                align_total_bases +=length 
                totally_aligned_contigs +=1
                print(">"+name, file=ftotal)
                print(self.sequences[name], file=ftotal)
            elif align == 0:
                unalign_total_bases +=length 
                unaligned_contigs +=1  
                print(">"+name, file=funaligned)
                print(self.sequences[name] , file=funaligned)
            else:
                l = float (length - align) 
                partiall_aligned_contigs +=1
                palign_total_bases += align  
                #print >>fpartial, ">"+name  #one possible way of printing 
                #print >>fpartial, self.sequences[name], str(l) #one possible way of printing 
                print(length, align, str(l), file=fpartial)
                unalign = length - align
                unaligned[name] = unalign
       print(align_total_bases, file=ftotal)
       print(palign_total_bases, file=fpartial)
       print(unalign_total_bases, file=funaligned)
       return unaligned,  totally_aligned_contigs, partiall_aligned_contigs, unaligned_contigs 

    def calc_duplication_ratio(self): 
          x = 0 
          y = 0
          
          for name1 in self.aligned:
               for i in self.aligned[name1]: 
                   if i > 1: 
                       x += 1 
          for name2 in self.covered: 
              for j in self.covered[name2]: 
                  if j > 1:
                      y += 1
          cdr = y
          adr = x 
          return cdr, adr
    
    
    def subtract(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        ocovered = other.covered
        
        for name in self.refsizes:
            ttree = self.covered[name]
            otree = ocovered[name]
            newtree = ttree - numpy.logical_and(ttree, otree)
            new_gic.covered[name] = newtree

        return new_gic

    def union(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        ocovered = other.covered
        
        for name in self.refsizes:
            ttree = self.covered[name]
            otree = ocovered[name]
            newtree = numpy.logical_or(ttree, otree)
            new_gic.covered[name] = newtree

        return new_gic
    
    def intersect(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        ocovered = other.covered
        
        for name in self.refsizes:
            ttree = self.covered[name]
            otree = ocovered[name]
            newtree = numpy.logical_and(ttree, otree)
            new_gic.covered[name] = newtree

        return new_gic

    def write_common_uncov_bases(self,other1, other2, outfile1): 
        fout1 = open(outfile1, 'w+')
        for k in self.covered: 
            n =">"+k
            count = 0
            print(n, file=fout1)
            for j in range(0, len(self.covered[k])):
                if (self.covered[k][j] ==0) and (other1.covered[k][j] ==0) and (other2.covered[k][j] ==0) :
                    count += 1
                    fout1.write(str (j) )
                    fout1.write(',') 
            fout1.write('\n')
    
    def count_common_uncov(self, other1, other2, outfile):
        fout = open(outfile, 'w+')
        total_uncov =0
        for k in self.covered:
           n =">"+k
           count =0
           for j in range(0, len(self.covered[k])):
                if (self.covered[k][j] ==0) and (other1.covered[k][j] ==0) and (other2.covered[k][j] ==0) :
                    count+=1  
           print(n, count, file=fout)
           total_uncov+=count
        return total_uncov  
     
    def count_diff_uncov(self, other1, other2, outfile): 
        fout =open(outfile, 'w+')  
        diff_uncov =0
        for k in self.covered:
           n =">"+k
           count =0
           for j in range(0, len(self.covered[k])):
                if (self.covered[k][j] ==0) and (other1.covered[k][j] >0 ) and (other2.covered[k][j] > 0) :
                    count+=1
           print(n, count, self.refsizes[k], file=fout)
           diff_uncov+=count
        return diff_uncov


    def count_diff_cov(self, other1, other2, outfile):
        fout =open(outfile, 'w+')
        diff_cov =0
        for k in self.covered:
           n =">"+k
           count =0
           for j in range(0, len(self.covered[k])):
                if (self.covered[k][j] >0) and (other1.covered[k][j] ==0 ) and (other2.covered[k][j] ==0) :
                    count+=1
           print(n, count, self.refsizes[k], file=fout)
           diff_cov+=count
        return diff_cov


    def distribution_alignment(self, s,  outfile): 
        dist = {}
        dist = numpy.zeros(s)
        fout = open(outfile, 'w+')  
        for name in self.aligned: 
            for i in self.aligned[name]:
                i = int(i)      # avoid warning about float index
                dist[i] +=1 
        for i in range(0, len(dist)) :
            if dist[i] == 0:
                break
            print(i, dist[i], file=fout)


    def distribution_coverage(self, s, outfile): 
        dist = {} 
        dist = numpy.zeros(s)
        fout = open(outfile, 'w+')
        for name in self.covered:
            for i in self.covered[name]:
                i = int(i)      # avoid warning about float index
                dist[i] +=1
        for i in range(0, len(dist)) :
            if dist[i] == 0:
                break
            print(i, dist[i], file=fout)

    def analyze_regions(self, file_all, file_max, window =20000 ):
        regions = self.regions
        fall = open(file_all, 'w+') 
        fmax = open(file_max, 'w+') 
        for name in self.covered: 
             for i in range(0, len(self.covered[name])): 
                   if self.covered[name][i] ==0:
                       regions[name][int(i/window)] +=1
                       #print i, self.covered[name][i], window, int(i/window), regions[name][int(i/window)]
            
        for i in self.regions:
            max = -1
            id = -1
            x = 0 
            y = 0 
            fall.write(str(i))
            fall.write('\n') 
            for j in range(0, len(self.regions[i])):
                if self.regions[i][j] > 0 :
                    fall.write( str(self.regions[i][j]))
                    fall.write(',') 

                if self.regions[i][j] > max: 
                    max =self.regions[i][j] 
                    id = j 
                if self.regions[i][j] > 0: 
                    x += 1
                if self.covered[i][j] > 0:     
                    y += 1
                #print len(self.regions[i]), len(self.covered[i]), x, y, max, id
                  
            print(i, id, max, file=fmax)
        fall.close() 

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('reference')
    parser.add_argument('assem1')
    parser.add_argument('assem2')
    parser.add_argument('assem3')
    parser.add_argument('coords1')
    parser.add_argument('coords2')
    parser.add_argument('coords3')
    parser.add_argument('treatment')
    parser.add_argument('minident')
    parser.add_argument('-a', '--ambiguity', dest='ambiguity', type=bool, default=False) 
    parser.add_argument('-b', '--best-hit', dest='besthit', type=bool, default=False)
    parser.add_argument('-c', '--nooverlap', dest='nooverlap', type=bool, default= False) 
    args = parser.parse_args()
    print('loading refsizes')
    refsizes, reference = load_reference(args.reference)

    print('Loading Coords')
 
    prefix1 = args.coords1.split('.')[0]
    prefix2 = args.coords2.split('.')[0]
    prefix3 = args.coords3.split('.')[0]  
  
    a, aseq = load_assembly(args.assem1)
    b, bseq = load_assembly(args.assem2) 
    c, cseq = load_assembly(args.assem3) 
    
    #------------------------------------------------------------------------------------------------------------------------------
    #Building Containers 
    #---------------------
 
    gic_a = GenomeIntervalsContainer(refsizes, a, aseq)
    gic_b = GenomeIntervalsContainer(refsizes, b, bseq)
    gic_c = GenomeIntervalsContainer(refsizes, c, cseq) 

    print(args.ambiguity, args.besthit)
    if args.ambiguity:
        assert not args.besthit
        assert not args.nooverlap

        print('......Running ambiguous analysis')
        gic_a.load_coords(args.coords1, float(args.minident))
        gic_b.load_coords(args.coords2, float(args.minident))
        gic_c.load_coords(args.coords3, float(args.minident))

    elif args.besthit:
        assert not args.ambiguity
        assert not args.nooverlap

        print('.....Running best hit analysis')
        gic_a.load_overlaps(args.coords1, float(args.minident))
        gic_b.load_overlaps(args.coords2, float(args.minident))
        gic_c.load_overlaps(args.coords3, float(args.minident))
    elif args.nooverlap:
        assert not args.ambiguity
        assert not args.besthit

        print('.... Running no overlaps analysis')
        gic_a.load_overlaps(args.coords1, float(args.minident), no_overlaps)
        gic_b.load_overlaps(args.coords2, float(args.minident), no_overlaps)
        gic_c.load_overlaps(args.coords3, float(args.minident), no_overlaps)
  
    #gic_a.analyze_regions(prefix1+".regions.all", prefix1+".regions.max")
    #gic_b.analyze_regions(prefix2+".regions.all", prefix2+".regions.max")
    #gic_c.analyze_regions(prefix3+".regions.all", prefix3+".regions.max") 
    
 
    ref_total_length = sum(refsizes.values()) 
    a_total_bases = sum(gic_a.assemsizes.values())
    b_total_bases = sum(gic_b.assemsizes.values())
    c_total_bases = sum(gic_c.assemsizes.values())

    a_dist_align = prefix1 +'.align.dist' + args.minident  
    b_dist_align = prefix2 +'.align.dist' + args.minident 
    c_dist_align = prefix3 +'.align.dist' + args.minident
   
    a_dist_cov = prefix1 +'.cov.dist' + args.minident 
    b_dist_cov = prefix2 +'.cov.dist' + args.minident   
    c_dist_cov = prefix3 +'.cov.dist' + args.minident   
    
    gic_a.distribution_alignment(a_total_bases, a_dist_align)
    gic_b.distribution_alignment(b_total_bases, b_dist_align) 
    gic_c.distribution_alignment(c_total_bases, c_dist_align)


    gic_a.distribution_coverage(ref_total_length, a_dist_cov)
    gic_b.distribution_coverage(ref_total_length, b_dist_cov)
    gic_c.distribution_coverage(ref_total_length, c_dist_cov)

    #------------------------------------
    #Open output file 
    fout = open('assemblies.stats.'+args.treatment, 'w+')

    print('Min ident used is:' , args.minident, file=fout)
    #Printing some general analysis: 
    print("Total bases in Reference is: ", ref_total_length , file=fout)
    print("Total bases in", prefix1, str(args.treatment) , "is" , a_total_bases, "with", len(a) ,"contigs", file=fout)
    print("Total bases in", prefix2, str(args.treatment) , "is" , b_total_bases, "with", len(b) ,"contigs", file=fout)
    print("Total bases in", prefix3, str(args.treatment) , "is" , c_total_bases, "with", len(c) ,"contigs", file=fout)
     
    #----------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of unalignments 
    #-----------------------------
    alignoutfile1 = prefix1 + '.' + args.treatment +'.aligned'
    alignoutfile2 = prefix2 + '.' + args.treatment +'.aligned'
    alignoutfile3 = prefix3 + '.' + args.treatment +'.aligned' 
    
    unalignoutfile1 = prefix1 + '.' + args.treatment +'.unaligned'
    unalignoutfile2 = prefix2 + '.' + args.treatment +'.unaligned'
    unalignoutfile3 = prefix3 + '.' + args.treatment +'.unaligned'
    
    

    print("Analysis of unalignments", file=fout)
    print("=========================", file=fout)
   
    a_unaligned, a_totally_aligned_contigs, a_partially_aligned, a_unaligned  = gic_a.calc_unalignments(alignoutfile1, alignoutfile1 + '.partial', unalignoutfile1)
    a_total_unaligned = a_unaligned #sum(a_unaligned.values())

    b_unaligned, b_totally_aligned_contigs, b_partially_aligned, b_unaligned = gic_b.calc_unalignments(alignoutfile2, alignoutfile2 + '.partial', unalignoutfile2)
    b_total_unaligned = b_unaligned #sum(b_unaligned.values())
    
    c_unaligned, c_totally_aligned_contigs , c_partially_aligned, c_unaligned = gic_c.calc_unalignments(alignoutfile3, alignoutfile3 + '.partial', unalignoutfile3)
    c_total_unaligned = c_unaligned #sum(c_unaligned.values()) 

    print('QC \t  Total Bases \t Total Aligned \t Percentage to Assembly \t Total Unaligned \t Percentage to Assembly', file=fout)
    print(prefix1, args.treatment, a_total_bases, '\t', (a_total_bases - a_total_unaligned), '\t', float(a_total_bases - a_total_unaligned)/a_total_bases * 100, '\t', a_total_unaligned, '\t', float(a_total_unaligned)/a_total_bases *100  , file=fout)
    print(prefix2, args.treatment, b_total_bases, '\t', (b_total_bases - b_total_unaligned), '\t', float(b_total_bases - b_total_unaligned)/b_total_bases * 100, '\t', b_total_unaligned, '\t', float(b_total_unaligned)/b_total_bases *100, file=fout)
    print(prefix3, args.treatment, c_total_bases, '\t', (c_total_bases - c_total_unaligned), '\t', float(c_total_bases - c_total_unaligned)/c_total_bases * 100, '\t', c_total_unaligned, '\t', float(c_total_unaligned)/c_total_bases *100, file=fout)
  


    print(prefix1, args.treatment, "has",  a_totally_aligned_contigs, "totally aligned contigs ~", float(a_totally_aligned_contigs)/len(a) * 100, file=fout)
    print(prefix2, args.treatment, "has",  b_totally_aligned_contigs, "totally aligned contigs ~", float(b_totally_aligned_contigs)/len(b) * 100, file=fout)
    print(prefix3, args.treatment, "has",  c_totally_aligned_contigs, "totally aligned contigs ~", float(c_totally_aligned_contigs)/len(c) * 100, file=fout)


    print(prefix1, args.treatment, "has",  a_partially_aligned, "partially aligned contigs ~", float(a_partially_aligned)/len(a) * 100, file=fout)
    print(prefix2, args.treatment, "has",  b_partially_aligned, "partially aligned contigs ~", float(b_partially_aligned)/len(b) * 100, file=fout)
    print(prefix3, args.treatment, "has",  c_partially_aligned, "partially aligned contigs ~", float(c_partially_aligned)/len(c) * 100, file=fout)
  

    print(prefix1, args.treatment, "has",  a_unaligned, "unaligned contigs ~", float(a_unaligned)/len(a) * 100, file=fout)
    print(prefix2, args.treatment, "has",  b_unaligned, "unaligned contigs ~", float(b_unaligned)/len(b) * 100, file=fout)
    print(prefix3, args.treatment, "has",  c_unaligned, "unaligned contigs ~", float(c_unaligned)/len(c) * 100, file=fout)
    
    #---------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of uncovered regions
    #------------------------------ 

    a_uncov_d = gic_a.calc_uncov()
    b_uncov_d = gic_b.calc_uncov()
    c_uncov_d = gic_c.calc_uncov()
    
    a_total_uncov = sum(a_uncov_d.values())
    b_total_uncov = sum(b_uncov_d.values())
    c_total_uncov = sum(c_uncov_d.values())

    print(a_total_uncov, b_total_uncov, c_total_uncov)
    print(a_uncov_d)

    a_uncov_per = float(a_total_uncov)/ref_total_length*100
    b_uncov_per = float(b_total_uncov)/ref_total_length*100
    c_uncov_per = float(c_total_uncov)/ref_total_length*100

    a_cov_per = float(ref_total_length - a_total_uncov) /ref_total_length * 100
    b_cov_per = float(ref_total_length - b_total_uncov) /ref_total_length * 100
    c_cov_per = float(ref_total_length - c_total_uncov) /ref_total_length * 100


    xa, ya  = gic_a.calc_duplication_ratio()
    xb, yb  = gic_b.calc_duplication_ratio()
    xc, yc = gic_c.calc_duplication_ratio()
    
   
    print('Assembler \t ', 'In Reference \t' , 'In Alignments \t Percentages ', file=fout)
    print(prefix1, "duplication ratio:", xa, ya, float(xa)/(ref_total_length - a_total_uncov) *100, float(ya)/(a_total_bases - a_total_unaligned) *100, file=fout)
    print(prefix2, "duplication ratio:", xb, yb, float(xb)/(ref_total_length - b_total_uncov) *100, float(yb)/(b_total_bases - b_total_unaligned) *100, file=fout)
    print(prefix3, "duplication ratio:", xc, yc, float(xc)/(ref_total_length - c_total_uncov) *100, float(yc)/(c_total_bases - c_total_unaligned)*100  , file=fout)


    print('Uncovered regions analysis', file=fout)
    print('==========================', file=fout)
    print('QC \t  Total base pairs \t Percentage of Covered  \t Percentage of uncovered' , file=fout)
    print(prefix1, args.treatment, ref_total_length, '\t', a_cov_per, '\t', a_uncov_per  , file=fout)
    print(prefix2, args.treatment, ref_total_length, '\t', b_cov_per, '\t', b_uncov_per   , file=fout)
    print(prefix3, args.treatment, ref_total_length, '\t', c_cov_per, '\t', c_uncov_per   , file=fout)

   
    #--------------------------------------------------------------------------------------------------------------------------------------------------- 
    #More analysis of Uncovered regions 
    #------------------------------------
    common_uncovered_bases = args.treatment + '.' +'uncovered.bases' 
    common_uncovered_count = args.treatment + '.' + 'uncovered'
    uncovoutfile1 = prefix1 + '.' + args.treatment + '.count.uncovered' 
    uncovoutfile2 = prefix2 + '.' + args.treatment + '.count.uncovered'
    uncovoutfile3 = prefix3 + '.' + args.treatment + '.count.uncovered'

    covoutfile1 = prefix1 + '.' + args.treatment + '.count.covered'
    covoutfile2 = prefix2 + '.' + args.treatment + '.count.covered'
    covoutfile3 = prefix3 + '.' + args.treatment + '.count.covered'

    unique_cov_a = gic_a.count_diff_cov(gic_b, gic_c, covoutfile1)
    unique_cov_b = gic_b.count_diff_cov(gic_a, gic_c, covoutfile2)
    unique_cov_c = gic_c.count_diff_cov(gic_b, gic_a, covoutfile3)


    print("Bases that are covered by", prefix1, args.treatment, "only: ", unique_cov_a, "~", float(unique_cov_a)/ref_total_length *100, "%", file=fout)
    print("Bases that are covered by", prefix2, args.treatment, "only: ", unique_cov_b, "~", float(unique_cov_b)/ref_total_length *100, "%", file=fout)
    print("Bases that are covered by", prefix3, args.treatment, "only: ", unique_cov_c, "~", float(unique_cov_c)/ref_total_length *100, "%", file=fout)

    
    gic_a.write_common_uncov_bases(gic_b, gic_c, common_uncovered_bases)
    total_common_uncov =gic_a.count_common_uncov(gic_b, gic_c, common_uncovered_count)
    unique_uncov_a = gic_a.count_diff_uncov(gic_b, gic_c, uncovoutfile1)
    unique_uncov_b = gic_b.count_diff_uncov(gic_a, gic_c, uncovoutfile2)
    unique_uncov_c = gic_c.count_diff_uncov(gic_b, gic_a, uncovoutfile3)
    print("Common uncovered bases among", prefix1, prefix2, prefix3 , "using", args.treatment, "is: ",total_common_uncov, file=fout)
    print("Bases that are uncovered by", prefix1, args.treatment, "only: ", unique_uncov_a, "~", float(unique_uncov_a)/ref_total_length *100, "%", file=fout)
    print("Bases that are uncovered by", prefix2, args.treatment, "only: ", unique_uncov_b, "~", float(unique_uncov_b)/ref_total_length *100, "%", file=fout)
    print("Bases that are uncovered by", prefix3, args.treatment, "only: ", unique_uncov_c, "~", float(unique_uncov_c)/ref_total_length *100, "%", file=fout)
 

if __name__ == '__main__':
    main()
