#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

my $inc = 0;
my $prev = <>;
while (<>) {
    if ($_ > $prev) {
        $inc++;
    }
    $prev = $_;
}

say $inc;
