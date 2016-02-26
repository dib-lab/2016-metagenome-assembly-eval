import numpy
import screed
import sys


def load_assembly(filename,fileout,  min_contig):
    d = {}
    fp =open(fileout, 'a+')    
    for record in screed.open(filename):
 	 if len(record.sequence) >= int(min_contig):
                print >>fp, ">"+record.name
                print >>fp, record.sequence
                

	
def main():

    assembly =sys.argv[1]
    out =sys.argv[2]
    min_contig =sys.argv[3]
  
    load_assembly(assembly, out, min_contig)

if __name__ == '__main__':
    main()
