#!/usr/bin/perl
#
# AD_finder.pl
# Finds variants that are heterozygous in the proband
# and absent in the parents.
# Reads a VCF
#
# Written 4 Oct 2012
use strict;
use warnings;

my $file = shift;
open my $F, $file;
print "##fileformat=VCFv4.1\n"; # reattaches header so SeattleSeq will take the file
LINE: while ($_=<$F>) {
	next if /^##/;
	my @line = split /\t/;
	next if $line[2] =~ /^rs/;	# ignores known SNPs, but you can disable this by commenting it out
	next if $line[9] =~ m{^1/1}; # ignores if homozygous in proband
	next if $line[10] =~ m{^1/1}; # ignores SNVs shared with parents
	next if $line[10] =~ m{^1/0}; 
	next if $line[10] =~ m{^0/1}; 
	next if $line[11] =~ m{^1/1};
	next if $line[11] =~ m{^1/0};
	next if $line[11] =~ m{^0/1};
	
	my $printme = 0;
	++$printme if ($line[9] =~ m{^1/0}); 
	++$printme if ($line[9] =~ m{^0/1});
	
	print join(qq/\t/, @line) if $printme;
}
print STDERR "Done.\n";

