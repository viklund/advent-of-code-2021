#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

use List::Util qw( sum0 min max );
#use List::MoreUtils qw( any minmax firstidx duplicates uniq singleton );

my $result;
my %fish;
while (<>) {
    chomp;
    my @fish = split ',';
    for my $f ( @fish ) {
        $fish{$f}++;
    }
}

for ( 1..256 ) {
    my %new_fish;
    for my $f ( keys %fish ) {
        if ($f==0) {
            $new_fish{6} += $fish{0};
            $new_fish{8} += $fish{0};
        }
        else {
            $new_fish{$f-1} += $fish{$f};
        }
    }
    %fish = %new_fish;
}

$result = sum0 values %fish;

say $result;
