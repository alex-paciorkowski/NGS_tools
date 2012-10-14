#!/usr/bin/perl
#
# AR_finder_multivcf.pl
# Finds AR pattern variants in an unfortunate multisample vcf
# but you only care about a particular trio
# Modify the $line[..] accordingly
# Unfortunately this multisample vcf given does not share if variants
# are homozygous or heterozygous in the given samples. 
# These are variants that are shared 
# by proband and parents
#
# Written  14 Oct 2012

use strict;
use warnings;

my $file = shift;
open my $F, $file;
LINE: while ($_=<$F>) {
	my @line = split /\t/;
	# keeps known SNPs for now, otherwise remove comment on next line
	# next if $line[8] >0;
	my $printme = 0;
	++$printme if ($line[18] =~ m/$line[25]/); # matches proband to the father
	# print "The string in the father is $line[18] and in the proband is $line[25] \n"; # Sanity check
	++$printme if ($line[19] =~ m/$line[25]/); # matches proband to the mother
	# print "The string in the mother is $line[19] and in the proband is $line[25] \n"; # Sanity check
	print join(qq/\t/, @line) if $printme;
}
print STDERR "Done.\n";

