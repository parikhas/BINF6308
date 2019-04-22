#!/usr/bin/perl
use warnings;
use strict;
 
sub nameLastFirst {
my ($first, $last) = @_;
# $lastNameLength is only in scope inside this subroutine.
my $lastNameLength = length($last);
print $lastNameLength, "\t",$last, ", ", $first,"\n";
}
nameLastFirst ("Rosalind", "Franklin");
nameLastFirst ("Margaret", "Dayhoff");
nameLastFirst ("Barbara", "McClintock");

# Uncomment the line below to see what happens with an out of scope variable.
# Comment it out again to resolve the warning.

#print $lastNameLength;

