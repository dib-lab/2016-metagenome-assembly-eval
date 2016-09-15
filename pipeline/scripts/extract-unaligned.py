#!/usr/bin/env python
"""
Write reads from a BAM file to a FASTQ file.

Quality scores are written as-is from the BAM file, thus in Sanger (Phred+33)
ASCII representations.


Based on https://github.com/martijnvermaat/bio-playground/blob/master/bam-to-fastq/bam_to_fastq.py
"""


import os

import argparse
import pysam


# DNA base complements
COMPLEMENT = {'A': 'T',
              'T': 'A',
              'C': 'G',
              'G': 'C',
              'N': 'N'}


def main(bam_file, output_file=None, output_type='fastq', bam_flag=None):
    """
    Open involved files and write BAM reads to FASTQ files.
    """
    name, _ = os.path.splitext(bam_file)
    if not output_file:
        output_file = ".".join([name, output_type])
    with pysam.Samfile(bam_file, 'rb') as bam:
        with open(output_file, 'w') as output:
            process_bam(bam, output, output_type, bam_flag)


def process_bam(bam, output, output_type, flag=None):
    """
    Get reads from open BAM file and write them to an open FASTQ
    file. Duplicate reads (by name) are only written once.
    """
    for read in bam:
        if (flag is None) or (read.flag & flag):
            write_read(output, read, output_type)


def write_read(output, read, output_type):
    """
    Write read to open FASTQ file.
    """
    info = {'name':  read.qname}

    quality = read.qual
    if quality is None:
        # ASCII 34, e.g 75% chance of incorrect read
        quality = '\"' * len(read.seq)

    if read.is_reverse:
        info.update({'quality':  quality[::-1],
                     'sequence': reverse_complement(read.seq)})
    else:
        info.update({'quality':  quality,
                     'sequence': read.seq})

    if output_type == 'fasta':
        output.write('>{name}\n{sequence}\n'.format(**info))
    else:
        output.write('@{name}\n{sequence}\n+\n{quality}\n'.format(**info))


def reverse_complement(sequence):
    """
    Return reverse complement of DNA sequence.
    """
    return ''.join(COMPLEMENT[b] for b in sequence[::-1])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=__doc__.split('\n\n\n')[0])
    group = parser.add_argument_group()
    group.add_argument('bam_file', metavar='BAM_FILE',
                       help='file in BAM format to extract reads from')
    group.add_argument('-o', dest='output_file', help='file to'
                       ' write reads to (default: BAM_FILE.fastq)')
    group.add_argument('--format', dest='filetype', help='output format,'
                       ' FASTA or FASTQ (default: fastq)',
                       type=str, default='fastq', choices=["fasta", "fastq"])
    group.add_argument('-f', dest='flag', type=int, help='Extract only reads'
                       'matching this flag (default: 4, unmapped reads)',
                       default=4)
    args = parser.parse_args()
    main(args.bam_file, args.output_file, args.filetype, args.flag)
