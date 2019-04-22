#!/usr/bin/perl
use warnings;
use strict;

my $dna1 = 'atggttt';
reverseSequence ($dna1);

sub reverseSequence {
	my ($sequence) = @_;
	my $revcom = reverse $sequence;
	return ($revcom);
}

print "dna1 = ",$dna1,"\n";
print "dna1 reversed = ",reverseSequence($dna1),"\n";

