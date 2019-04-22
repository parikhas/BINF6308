#!/usr/bin/perl
use warnings;
use strict;

#ask user for input
my $seq = <STDIN>; 

#if no user input, then use default sequence given here
if ($seq =~ "") {
	$seq = 'AATGGTTTCTCCCATCTCTCCATCGGCATAAAAATACAGAATGATCTAACGAA';
	} 

print "Sequence: $seq\n";

#if the sequence matches the coding region, then print it
while ($seq =~ /((ATG)(.*?)(TAA|TAG|TGA))/g){
	print "Coding sequence: $1\n";
	} 
