#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

use List::Util qw();

my @pos = (0,0);
while (<>) {
    if ( /forward (\d+)/ ) {
        $pos[0] += $1;
    }
    if ( /down (\d+)/ ) {
        $pos[1] += $1;
    }
    if ( /up (\d+)/ ) {
        $pos[1] -= $1;
    }
}

my $result = $pos[0] * $pos[1];
say $result;
