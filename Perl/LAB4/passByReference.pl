#!/usr/bin/perl
use warnings;
use strict;

my $readingfile = '/scratch/Drosophila/oligos.fasta';

open (BLAST,"<",$readingfile) or die $!;
my@file = <BLAST>;

passByReference (\@file);
sub passByReference {
	my ($file) = @_;
	$file->[0] = "changed\n";
	print "The array inside the sub", "\n";
	print $file->[0];
	print $file->[1];
	print $file->[2];
	print"\n";

}

print "The array outside the sub","\n",@file[0..2]; 
