#!/usr/bin/perl
use warnings;
use strict;

open (GFF3, ">", 'crispr.gff3') or die $!;
open (FILE, ">", 'offTarget.txt') or die $!;

blastOligos();

sub blastOligos {

#Put my BLAST command and all the parama in an array

	my @commandAndParams = ('blastn', '-task blastn', '-db Drosophila2L', '-query uniqueKmersEndingGG.fasta', '-outfmt 6');

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
		@rowArray = ( $chrom, ".", 'OLIGO', $gffStart, $gffEnd, ".", $strand, ".", "Name=$queryId;Note=Some info on this oligo");
		local $, = "\t";
		if ($identity < 100.00) {
			print FILE $blastOutputLine,"\n";
		} else {		
			
		print GFF3 @rowArray,"\n";
		}
	}

}

 
