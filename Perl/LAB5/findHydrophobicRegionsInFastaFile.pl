#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;

open (FILE, "<", "/scratch/SampleDataFiles/test.fasta") or die $!;

$/ = ">";

my $total = 0;
my $matchcount = 0;

my $header;
my $sequence;
my $headerlen;

while (<FILE>) {
	chomp;
	my $input = $_;
	my $entered_while_loop;
	
	#match header to input
	if ($input =~ /(.*?).^(.*)$/ms){
	         $total++;
		 $header = $1;	
	}
	
	#match one or more sequences
	while ($input =~ /([VILMFWCA]{8,})/g) { 
	
		$entered_while_loop = 1;
		$sequence = $1;
		
			#make sure header is only printed once for a sequence
			if ($header) {
			$matchcount++;
			print "Hydrophobic region found in $header","\n";
			$headerlen = length $header;
			$header = "";
		}
		
		#define the position of the amino acids in the sequence
		my $pos = pos($input) - (length $1) - $headerlen;
		print "$sequence is at position $pos","\n";
	}


	#print new line after matched sequences
	if ($entered_while_loop) {
		print"\n";
	}
}	

print "Hydrophobic region(s) found in $matchcount out of $total sequences.\n";	 			





