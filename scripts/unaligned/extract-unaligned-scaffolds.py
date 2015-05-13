#! /usr/bin/env python
import sys
import screed

unaligned = sys.argv[1]
assembly = sys.argv[2]

un = set()
for line in open(unaligned):
    x = line.split('.', 1)[1]
    #print x 
    #x = x.split('.')[0]
    #print x
    #x = x.split('_')[:4]
    #x = "_".join(x)
    #print x 
    un.add(x)


for record in screed.open(assembly): 
    d = record.description
    n =record.name
    y =n +'_'+d 
    y=y.split('.',1)[1]
    y= y+'\n'
    #print y
    if y in un: 
      print '>%s %s\n%s' % (record.name, record.description, record.sequence)
#
"""
for record in screed.open(assembly):
    d = record.description
    print d
    d = d.split('_')[:4]
    d = "_".join(d)
    d=d+'\n'
    #if d in un:
     #  print '>%s %s\n%s' % (record.name, record.description, record.sequence)
"""
