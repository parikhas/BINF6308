#!/usr/bin/perl
use warnings;
use strict;

# ask user for input
my $seq  = <STDIN>;

# if no user input, then use default sequence given here
if ($seq =~ "") {
	$seq = 'AATGGTTTCTCCCATCTCTCCATCGGCATAAAAATACAGAATGATCTAACGAA' ;
	}

print "Sequence: $seq\n";

# if sequence matches the intron, then print the intron
if ($seq =~ /(GT(.*?)AG)/) {
	print "Intron is: $1\n";
	}
