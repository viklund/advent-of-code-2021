#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

#use List::Util qw( sum0 min max );
#use List::MoreUtils qw( any minmax firstidx duplicates uniq singleton );

my %map;
my $result;
while (<>) {
    chomp;
    my ($x1,$y1, $x2,$y2) = m/^(\d+),(\d+) -> (\d+),(\d+)$/;
    if ( ! defined $y2 ) {
        die "Can't parse file on line $.\n LINE: <$_>";
    }

    if ( $x1 == $x2 ) {
        if ( $y1 > $y2 ) { ($y1,$y2) = ($y2,$y1) }
        for ($y1..$y2) {
            $map{$x1}{$_}++;
        }
    }
    if ( $y1 == $y2 ) {
        if ( $x1 > $x2 ) { ($x1,$x2) = ($x2,$x1) }
        for ($x1..$x2) {
            $map{$_}{$y1}++;
        }
    }
}


for my $x ( keys %map ) {
    for my $y ( keys %{ $map{$x} } ) {
        if ($map{$x}{$y} >= 2) {
            $result++;
        }
    }
}

say $result;



sub show_map {
    for my $y (0..9) {
        for my $x (0..9) {
            if ( ! exists $map{$x} || ! exists $map{$x}{$y} ) {
                print '.';
            }
            else {
                print $map{$x}{$y};
            }
        }
        print "\n";
    }
}
