#!/usr/bin/perl
use warnings;
use strict;

my $readingfile = '/scratch/Drosophila/oligos.fasta';

open (BLAST,"<",$readingfile) or die $!;
my @file = <BLAST>;

passByCopy (@file);
sub passByCopy {
	my @inputArr = @_;

	
	#my ($file) = @_;
	
	#my ($item) = @inputArr;
	#print $item;
#	$item = "changed\n";

	$inputArr[0] = "changed\n";
	

	print "The array inside the sub","\n",@inputArr[0..2],"\n";
}
print "The array outside the sub","\n",@file[0..2];

