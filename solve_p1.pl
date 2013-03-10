#!/usr/bin/perl
##
## solve_p1.pl
##
## This is the first part of Solve.pm
## It takes a vcf annotated by Annovar
## and extracts the gene symbols
## Then you run $ uniq -u on the output
## and get a file of the unique gene
## symbols
## The second part of Solve.pm submits that
## list to GEDI for further annotation
##
## Written 9 Mar 2013

use strict;
use warnings;

my $file = shift;
open my ( $F ), $file;
LINE: while ($_=<$F>) {
    my @line = split /\t/;
    my @gene_symbol = $line[1];

    my $printme = 0;
    ++$printme if @gene_symbol;
                   
    print join(qq/\t/, @gene_symbol, qq/\n/) if $printme;
}

print STDERR "Part 1 done.\n";

