#!/usr/bin/perl
use warnings;
use strict;

open (GFF3, ">", 'crisprWithOffTarget.gff3') or die $!;

my %off = ();
my %CRISPR = ();

blastOligos();
printGFF3();

sub blastOligos {

#Put my BLAST command and all the parama in an array

	my @commandAndParams = ('blastn', '-task blastn', '-db DrosophilaAllChroms', '-query unique12KmersEndingGG.fasta', '-outfmt 6');

	#Print the BLAST command for debugging purposes
	print "@commandAndParams\n";

	open (BLAST, "@commandAndParams |");

	#Process the BLAST output line-by-line using the filehandle named BLAST
	while (<BLAST>) {
	#Get rid of end-of-line characters
	chomp;
	#Assign the line of output from the default variable $_ to named variable blastOutputLine
	my $blastOutputLine = $_;
	processBlastOutputLine($blastOutputLine);
	}
}

sub processBlastOutputLine {
	my ($blastOutputLine) = @_;
	#If the output line isn't a comment line
	if ($blastOutputLine !~ /^#/) {
		my @blastColumns = split("\t", $blastOutputLine);
		#Assign the column positions to meaningfully named variables
		my ( $queryId, $chrom, $identity, $length, $mismatches, $gaps, $qStar, $qEnd, $start, $end) = @blastColumns;
		my $miss = 21 - $length + $mismatches;	
		if ($identity == 100.0 && $length == 21 && not defined $CRISPR{$queryId}) {	
		my $strand = '+';
		my $gffStart = 0;
		my $gffEnd = 0;
		if ($start > $end) {
			$strand = '-';
			$gffStart = int $end;
			$gffEnd = int $start;
		}
		else {
			$gffStart = int $start;
			$gffEnd = int $end;
		}
		my @rowArray;
		@rowArray = ( $chrom, ".", 'OLIGO', $gffStart, $gffEnd, ".", $strand, ".", "Name=$queryId;");

		$CRISPR{$queryId} = \@rowArray;

	} elsif ($identity < 100.0 && $miss <=3) {
		$off{$queryId}++;
		}
	}
}

#Go and loop through the CRISPR hash to print the information out in the GFF3 file

sub printGFF3 {
	foreach my $val (keys %CRISPR) {
		my @data = @{$CRISPR{$val}};
		my $count = 0;
		if (defined $off{$val}) {
			$count = $off{$val};
		}
		local $, = "\t";
	print GFF3 @data;
	print GFF3 "Note=$count off-target matches\n";
	}
}
