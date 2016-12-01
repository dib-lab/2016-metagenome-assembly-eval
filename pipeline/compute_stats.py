import numpy
import screed
import sys


def load_assembly(filename):
    d = {}
    for record in screed.open(filename):
              d[record.name.split()[0]] = len(record.sequence)
    return d

def n50(d): 
    ncontigs =sorted(d.values(),reverse=True)
    total =sum(ncontigs)
    print 'Assembly has',total, 'base pairs'   
    nfifty =0
    for i in ncontigs: 
        nfifty +=i
        if nfifty >= total/2: 
   	     nfifty =i  
             break 
    return nfifty  

def ng50(assem, ref): 
     ncontigs =sorted(assem.values(), reverse=True) 
     total =sum(ref.values())
     print 'Reference has',total, 'base pairs'
     ngfifty =0 
     for i in ncontigs: 
	 ngfifty +=i
         if ngfifty >=total/2: 
               ngfifty =i
               break 
     return ngfifty 
 
       
     


def main():
    filename1 =sys.argv[1]
    filename2 =sys.argv[2]
   
    print 'loading assembly'
    d =load_assembly(filename1)
    ref =load_assembly(filename2) 
   
    nfifty =n50(d)
    ngfifty =ng50(d, ref)
    print  'N50 equals:',  nfifty 
    print  'NG50 equals:', ngfifty     

if __name__ == '__main__':
    main()
