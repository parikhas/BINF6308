#!/usr/bin/perl
use warnings;
use strict;

open (INFILE, "<",'/scratch/Drosophila/dmel-all-chromosome-r6.02.fasta') or die $!;

open (OUTFILE, ">",'bindingSites.txt') or die $!;

#define $bindingsites and put initial value as 0
my ($bindingsites) = 0;

#define $sequence and initialize it with empty string
my $sequence = "";
 
#loop through the file to find matching sequences
while (<INFILE>) {
	chomp;
	if ($_ =~ /^>/) {
	 	matchentry($sequence);	
                $sequence = "";
	}
	#remove line breaks and append the sequence
	$sequence = $sequence.$_;
}
#declare subroutine to find binding sites
sub matchentry {

	my ($input) = @_;

	while ($input =~ /([TC]C[CT]GGAAGC)/g) {
		print OUTFILE $1,"\n";
		#count number of binding sites
		$bindingsites++;
	}
}

print OUTFILE "$bindingsites binding sites were found\n";
close (OUTFILE);
close (INFILE);
