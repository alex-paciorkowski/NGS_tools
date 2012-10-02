#!usr/bin/perl
#
# AR_finder.pl
# Finds variants that are homozygous or compound het in proband
# and het in parents
# Reads a VCF file
#
# Last edit 1 Oct 2012

use strict;
use warnings;

my $file = shift;
open my $F, $file;
LINE: while ($_=<$F>) {
	next if /^##/; # Gets rid of the headers
	my @line = split /\t/;
	next if $line[2] =~ /^rs/; # Gets rid of known SNPs
	my $printme = 0; 
	if ($line[9] =~ m{^1/1}) {
		foreach (@line[10..$#line]) {
			++$printme unless m{^0/0}
		}
	}
	print join(qq/\t/,@line) if $printme;
}
print STDERR "Done.\n";

