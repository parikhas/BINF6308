#!/usr/bin/perl
use warnings;
use strict;

my %hash = ();
my %last12hash = ();
#Call subroutine to load the sequence
my $sequenceRef = loadSequence('/scratch/Drosophila/dmel-all-chromosome-r6.02.fasta');
my $windowSize = 21;  #Set size of the sliding window
my $stepSize = 1;     #Set the step size

for (
	#The moving start position of the sliding window starts at 0
	my $windowStart = 0;
	#Keep going as long as my window doesn't go past the end of the file
	$windowStart <= (length($$sequenceRef) - $windowSize);
	#Advance the window by the step size
 	$windowStart += $stepSize
	)
{
	#Get the substring starting at the window start for length $windowStart
	my $windowSeq = substr($$sequenceRef, $windowStart ,$windowSize);
	processKmer($windowSeq);
}

printkmer ();

sub loadSequence {
	#Get my sequence file name from the parameter array
	my ($sequenceFile) = @_;
	#Initialize my sequence to the empty string
	my $sequence = "";
	#Open the sequence file
	unless (open (FASTA, "<", $sequenceFile)) {
		die $!;
	}
	#Loop through the file line-by-line
	while (<FASTA>) {
	#Assign the line to a named variable for readability
	my $line = $_;
	#Chomp to get rid of end-of-line characters
	chomp($line);
	#Check to see if it is a FASTA header line
	if ($line !~ /^>/) {
		#If it's not a header line append it to my sequence
		$sequence .= $line;
		}
	}
	#Return a reference to the sequence
	return \$sequence;
}

sub processKmer {
	#Get the kmers
	my ($kmer) = @_;
	my $seq = "[ATGC]{9}([ATGC]{10}GG)";
	if ($kmer =~ /$seq/) {
		if (exists $last12hash{$1}) {
			$last12hash{$1}++;
		}
		else {
			$last12hash{$1} = 1;
			$hash{$1} = $kmer;
		}
	}
}

sub printkmer {
	#Open file uniqueKmersEndingGG.fasta for writing
	open (FILE, ">", 'unique12KmersEndingGG.fasta') or die $!;
	my $count = 1;
	#Look through the hash
	foreach my $last12 (keys %last12hash) {
		if ($last12hash{$last12} == 1) {
		#Print kmer and its counts to uniqueKmersEndingGG.fasta
		print FILE ">crispr_$count\n";
		print FILE "$hash{$last12}\n";
		$count++;
	}
	
	}

}
