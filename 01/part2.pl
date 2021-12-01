#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

use List::Util qw/ sum /;

my $count = 0;
my @sums;
my @window;
while (<>) {
    push @window, $_;
    shift @window if (@window > 3);

    next if @window < 3;

    my $s = sum @window;
    push @sums, $s;

    shift @sums if @sums > 2;
    if (@sums==2 && $sums[1] > $sums[0]) {
        $count++;
    }
}
say $count;
