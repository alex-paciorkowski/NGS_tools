#!/usr/bin/perl
#
# Compares a list of genes in file 1 with a list of genes in file 2
# Use case is to compare genelist output from indels and snvs 
# to help find compound het indel/snv combinations
#
# Written April 4, 2013

use strict;
use warnings;

my %a;
open F, shift;
while (<F>) {chomp;$a{$_}++}
open F, shift;
while (<F>) {chomp;print if $a{$_};
print"\n";}
print"\n";
