#!/usr/bin/perl
#
# AR finder that also cares about GQ scores
# Pulls from a single VCF only variants called as het
# with GQ 99
#
# Written 28 Feb 2013
# Modified 1 Mar 2013

use strict;
use warnings;

my $file = shift;
open my $F, $file;
print "##fileformat=VCFv4.1\n"; # reattaches header so SeattleSeq will take file
LINE: while ($_=<$F>) {
	next if /^##/; # Gets rid of the other headers
	my @line = split /\t/;
	next if $line[2] =~ m{rs}; # Throws if known SNP
	next if $line[9] =~ m{0/0}; # Throws if proband not a carrier
	next if $line[10] =~ m{1/1}; # Throws if parent 1 is homozygous -- this is unlikely
	next if $line[11] =~ m{1/1}; # Throws if parent 2 is homozygous -- this is unlikely

	my $printme = 0;
	++$printme if ($line[9] =~ m{:99:});

	print join(qq/\t/, @line) if $printme;
}
print STDERR "Done.\n";

