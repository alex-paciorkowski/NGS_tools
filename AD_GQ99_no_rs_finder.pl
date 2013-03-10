#!/usr/bin/perl
#
# AD finder that also cares about GQ scores
# Pulls from a single VCF only variants called as het
# with GQ 99
#
# Written 28 Feb 2013
# Modified 1 Mar 2013

use strict;
use warnings;

my $file = shift;
open my $F, $file;
print "##fileformat=VCFv4.1\n";
LINE: while ($_=<$F>) {
	my @line = split /\t/;
	next if $line[2] =~ m{rs}; # Drops if known SNP
	next if $line[9] =~ m{1/1}; # Drops if proband is a homozygote
	next if $line[10] =~ m{1/0}; # Drops if parent 1 is a het
	next if $line[10] =~ m{0/1}; # Drops if parent 1 is a het
	next if $line[10] =~ m{1/1}; # Drops if parent 1 is a homozygote
	next if $line[11] =~ m{1/0}; # Drops if parent 2 is a het
	next if $line[11] =~ m{0/1}; # Drops if parent 2 is a het
	next if $line[11] =~ m{1/1}; # Drops if parent 2 is a homozygote

	my $printme = 0;
	++$printme if ($line[9] =~ m{:99:});

	print join(qq/\t/, @line) if $printme;
}
print STDERR "Done.\n";

