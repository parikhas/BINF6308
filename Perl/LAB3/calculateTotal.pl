#!/usr/bin/perl
use warnings;
use strict;

#Initialize a hash to allow lookup of a grocery item to get the corresponding price
my %inventory = (
'orange' => '.75',
'apple' => '.60',
'banana' => '.25',
'bread' => '3.99',
'eggs' => '3.10',
'milk' => '3.50',
'butter' => '2.75',
'tomato' => '1.99',
'spinach' => '2.99',
'chicken' => '3.89'
);

#Initialize an array for storing list of grocery items required
my @groceryList = qw(pasta eggs butter apple squash spinach chicken);

my $total = 0;
my @unavailable;

#Loop through the prices of the items in the inventory hash as per the items in the grocery list array.
#Declare value of the grocery list array to $var
foreach my $var (@groceryList) {
        if ($inventory{$var}){
		
		#Add prices of items in grocery list which correspond to items in the inventory hash
                $total+=$inventory{$var};}
		#Recover items in the grocery list which are not there in the inventory hash
        else {
                push (@unavailable, ($var));
                }
		
}


print "Total: \$$total","\n";
print "Items not available: @unavailable","\n";


