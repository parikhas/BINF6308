#!/usr/bin/perl
use warnings;
use strict;


my $readingfile = '/scratch/SampleDataFiles/example.sp';

open (FILE,"<",$readingfile) or die $!;


sub findpattern {
	
	my $acline;
	my $osline;
	my $oxline;
	my $gnline;
	my $sqline;
	my $seq;
	
	while (<FILE>) {
		chomp;
		my $line = $_;
		
		if ($line =~ /^AC\s+(.+);/g) {
			$acline = $1;
	 	}

		if ($line =~ /^OS\s+(.*)./g) {
			$osline = $1;
		}
                
		if ($line =~ /^OX\s+(.*)/g) {
			$oxline = $1;
		}

		if ($line =~ /^SQ.*\s+(\d+\sAA)/g) {
			$sqline = $1;
		}

		if ($line =~ /^GN\s+(\w+.*)/g) {
			$gnline = $1;
		}

		if ($line =~ /^\s+(.*)/) {

			my $tmp = $1;
			$tmp =~ s/\s//g;
			$seq = $seq.$tmp
		}
	
	}		
	print ">$acline | $osline | $oxline | $sqline | $gnline\n";
	print "$seq\n";
}
findpattern();



