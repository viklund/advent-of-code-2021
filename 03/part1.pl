#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

#use List::Util qw( sum0 min max );
#use List::MoreUtils qw( any minmax firstidx duplicates uniq singleton );

my $result;
my @counts;
while (<>) {
    chomp;
    my @values = split //, $_;
    for my $idx (0..$#values) {
        $counts[$idx]++ if $values[$idx];
    }
}

for my $idx (0..$#counts) {
    if ( $counts[$idx] > $./2 ) {
        $result .= 1;
    }
    else {
        $result .= 0;
    }
}


say $result;

my $r1 = oct("0b$result");
$result =~ tr/01/10/;
my $r2 = oct("0b$result");

say $r1*$r2;
