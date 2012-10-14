#!/usr/bin/perl
#
# AD_finder_multivcf.pl
# Finds AD/de novo pattern variants in an unfortunate multisample vcf
# when you only care about a particular trio
# Modify the $line[..] accordingly
# Unfortunately this multisample vcf given does not share if variants
# are homozygous or heterozygous in the given sample
# (i.e. [0/1] or [1/1] allele frequency information)
#
# Written 14 Oct 2012

use strict;
use warnings;

my $file = shift;
open my $F, $file;
LINE: while ($_=<$F>) {
	my @line = split /\t/;
	# keeps known SNPs for now, otherwise remove comment on next line
	# next if $line[8] >0;
	next if ($line[18] =~ m/$line[25]/); # excludes if proband matches father
	next if ($line[19] =~ m/$line[25]/); # excludes if proband matches mother

	my $printme = 0;
	++$printme if ($line[18] !~ m/$line[25]/);
	# print "Father is $line[18] and proband is $line[25].\n"; # Sanity check
	++$printme if ($line[19] !~ m/$line[25]/);
	# print "Mother is $line[19] and proband is $line[25].\n"; # Sanity check

	print join(qq/\t/, @line) if $printme;
}
print STDERR "Done.\n";

