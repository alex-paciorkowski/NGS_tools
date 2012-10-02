#!/usr/bin/perl
#
# indel_parser.pl
#
# This pulls indels from the original VCFs in case 
# they are mixed with SNVs
# Usually we like separate VCFs for SNVs and indels
#
# Written 20 Sep 2012

use strict;
use warnings;

my $file = shift;
open my $F, $file;
print "##fileformat=VCFv4.0\n"; # Reattaches fileformat header so SeattleSeq won't complain
LINE: while ($_=<$F>) {
	next if /^##/; # Gets rid of all the other headers
	my @line = split /\t/;

	my $printme = 0;
	
	++$printme if ($line[4] =~ m{^A[ATGC]});
	++$printme if ($line[4] =~ m{^T[ATGC]});
	++$printme if ($line[4] =~ m{^G[ATGC]});
	++$printme if ($line[4] =~ m{^C[ATGC]});

	print join(qq/\t/,@line) if $printme;
}
print STDERR "Done.\n";

