#!/usr/bin/perl
use warnings;
use strict;

open (FILE1, "<", '/scratch/Drosophila/fb_synonym_fb_2014_05.tsv') or die $!;

open (FILE2, "<", '/scratch/Drosophila/FlyRNAi_data_baseline_vs_EGF.txt') or die $!;

open (FILE3, "<", '/scratch/Drosophila/gene_association.goa_fly') or die $!;

open (OUTFILE1, ">", 'FlyRNAi_data_baseline_vs_EGFSymbol.txt') or die $!; 

open (OUTFILE2, ">", 'FlyRNAi_data_baseline_vs_EGF_GO.txt') or die $!;

#create two hashes
my (%hash1, %hash2);

#loop through FILE1
while(<FILE1>) {
	chomp;	
	#find 1st & 2nd columns in FILE1 and make hash1 with 1st column as keys and 2nd column as values of that keys  	
	if ($_ =~ /^FB/) {
		#split the file into columns
		my @data = split("\t");
		my ($id, $gs) = @data;
		#put $id as keys and $gs as values in hash1
		$hash1{$id} = $gs;	
	}	
}


#loop through FILE3 
while(<FILE3>) {
	chomp;
	#find 3rd & 5th columns in FILE3 and make hash2 with 3rd column as key and 5th column as values oh that keys 
	if ($_ =~ /^Uni/) {
		#split the file into columns
		my @data = split("\t");
		my ($genesymbol) = $data[2];
		my ($GO) = $data[4];
		#put $genesymbol as keys and $GO as values in hash1
		$hash2{$genesymbol} = $GO;
	}
}

#loop through FILE2
while (<FILE2>) {
	chomp;
	if ($_ =~ /^FB/) {
		#split the file into columns
		my @data = split("\t");
		my ($newid, $dataval1, $dataval2) = @data;
		#match $newid to $id in hash1 and get the corresponding value
		my $symbol = $hash1{$newid};
		if ($symbol) {
			print OUTFILE1 $symbol,"\t",$dataval1,"\t",$dataval2,"\n";
			#match $symbol to $genesymbol in hash2 and get the corresponding values
			my $FINALGO = $hash2{$symbol};
			if ($FINALGO) {
				print OUTFILE2 $FINALGO,"\t",$dataval1,"\t",$dataval2,"\n";		
			}
		}
	}		
}
