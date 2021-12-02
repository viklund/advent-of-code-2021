#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

use List::Util qw();

my @pos = (0,0);
my $aim = 0;
while (<>) {
    if ( /forward (\d+)/ ) {
        $pos[0] += $1;
        $pos[1] += $1 * $aim;
    }
    if ( /down (\d+)/ ) {
        $aim += $1;
    }
    if ( /up (\d+)/ ) {
        $aim -= $1;
    }
}

my $result = $pos[0] * $pos[1];
say $result;
