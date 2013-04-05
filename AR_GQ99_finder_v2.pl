#!/usr/bin/perl
#
# AR_GQ99_finder_v2.pl
# Finds variants that are homozygous or compound heterozygous in proband 
# and heterozygous in parents.
# Reads unannotated vcf from gatk: proband, parent1, parent2
# Uses GQ 99
# April 4, 2013
#
use strict;
use warnings;

my $file = shift;
open my ( $F ), $file;
LINE: while ($_=<$F>){
	next if /^##/;
		my @line = split /\t/;
			next if $line[10] =~ m{1/1};
			next if $line[11] =~ m{1/1};		
			
			next if (($line[9] =~ m{0/1}) && ($line[10] =~ m{0/1}) && ($line[11] =~ m{0/1}));#gets rid of variants inherited from both parents  	

			my $printme = 0;
			++ $printme if (($line[9] =~ m{1/1}) && ($line[9] =~ m{:99:}));#proband genotype and quality score
			++ $printme if (($line[9] =~ m{1/0}) && ($line[9] =~ m{:99:}) && ($line[10] =~ m{0/0}) && ($line[11] =~ m{0/1}));
			++ $printme if (($line[9] =~ m{0/1}) && ($line[9] =~ m{:99:}) && ($line[10] =~ m{0/0}) && ($line[11] =~ m{0/1}));	
			++ $printme if (($line[9] =~ m{1/0}) && ($line[9] =~ m{:99:}) && ($line[10] =~ m{0/1}) && ($line[11] =~ m{0/0}));
			++ $printme if (($line[9] =~ m{0/1}) && ($line[9] =~ m{:99:}) && ($line[10] =~ m{0/1}) && ($line[11] =~ m{0/0}));	

print join(qq/\t/, @line) if $printme;
}
print STDERR "Done.\n";
