#!/usr/bin/perl
use warnings;
use strict;

my $readingfile = '/scratch/SampleDataFiles/sampleBlastOutput.txt';

my $targetfile = 'firstFourBlastColumns.txt';

open (BLAST, "<",$readingfile) or die $!;

open (BLAST_REWRITE,">",$targetfile) or die $!;

while (<BLAST>) {
	chomp;
	my @blastFieldArray = split();

	my $percentIdentity = $blastFieldArray[2];
	my $queryId = $blastFieldArray[0];
	my $subjectId = $blastFieldArray[1];
	my $alignmentLength = $blastFieldArray[3];

		if ($percentIdentity>70) {
			print BLAST_REWRITE $queryId,"\t",$subjectId,"\t",$percentIdentity,"\t",$alignmentLength,"\n";
		
}
}

close(BLAST_REWRITE);
close(BLAST);
	






