#!/usr/bin/perl
#
# AD finder that also cares deeply about GQ scores
# Pulls from a single VCF only variants called as het
# with GQ 99
#
# Written 12 Feb 2013

use strict;
use warnings;

my $file = shift;
open my $F, $file;
LINE: while ($_=<$F>) {
	my @line = split /\t/;
	next if $line[9] =~ m{1/1}; # ignores homozygotes

	my $printme = 0;
	++$printme if ($line[9] =~ m{0/1:99});
	++$printme if ($line[9] =~ m{1/0:99});

	print join(qq/\t/, @line) if $printme;
}
print STDERR "Done.\n";

