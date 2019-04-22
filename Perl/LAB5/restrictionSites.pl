#!/usr/bin/perl
use warnings;
use strict;

my $dna1 =
'AACAGCACGGCAACGCTGTGCCTTGGGCACCATGCAGTACCAAACGGAACGATAGTGAAAACAATCACGA
ATGACCAAATTGAAGTTACTAATGCTACTGAGCTGGTTCAGAGTTCCTCAACAGGTGAAATATGCGACAG
TCCTCATCAGATCCTTGATGGAGAAAACTGCACACTAATAGATGCTCTATTGGGAGACCCTCAGTGTGAT
GGCTTCCAAAATAAGAAATGGGACCTTTTTGTTGAACGCAGCAAAGCCTACAGCAACTGTTACCCTTATG
ATGTGCCGGATTATGCCTCCCTTAGGTCACTAGTTGCCTCATCCGGCACACTGGAATTTAACAATGAAAG
CTTCAATTGGACTGGAGTCACTCAAAATGGAATCAGCTCTGCTTGCAAAAGGAGATCTAATAACAGTTTC
TTTAGTAGATTGAATTGGTTGACCCACTTAAAATTCAAATACCCAGCATTGAACGTGACTATGCCAAACA
ATGAAAAATTTGACAAATTGTACATTTGGGGGGTTCACCACCCGGGTACGGACAATGACCAAATCTTCCT
GTATGCTCAAGCATCAGGAAGAATCACAGTCTCTACCAAAAGAAGCCAACAGACTGTAATCCCGAATATC
GGATCTAGACCCAGAGTAAGGAATATCCCCAGCAGAATAAGCATCTATTGGACAATAGTAAAACCGGGAG
ACATACTTTTGATTAACAGCACAGGGAATTTAATTGCTCCTAGGGGTTACTTCAAAATACGAAGTGGGAA
AAGCTCAATAATGAGATCAGATGCACCCATTGGCAAATGCAATTCTGAATGCATCACTCCAAATGGAAGC
ATTCCCAATGACAAACCATTTCAAAATGTAAACAGGATCACATATGGGGCCTGGCCCAGATATGTTAAGC
AAAACACTCTGAAATTGGCAACAGGGATGCGAAATGTACCAGAGAAACAAACTAGAGGCATATTTGGCGC
AATCGCGGGTTTCATAGAAAATGGTTGGGAAGGAATGGTGGATGGTTGGTACGGTTT';

$dna1 =~ s/\s//g;



print 'Looking for pattern1 = CAC...',"\n";
while ($dna1 =~ /(CAC...)/g){

	my $pos = pos($dna1) - (length $1) + 1;
	print "$1 matched at residue $pos","\n";
}

print "\n",'Looking for pattern2 = GCC[AT]GG',"\n";
while ($dna1 =~ /(GCC[AT]GG)/g){

	my $pos = pos($dna1) - (length $1) + 1;
	print "$1 matched at residue $pos","\n";
}
