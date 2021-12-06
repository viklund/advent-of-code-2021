#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

#use List::Util qw( sum0 min max );
#use List::MoreUtils qw( any minmax firstidx duplicates uniq singleton );

my $result;
my @fish;
while (<>) {
    chomp;
    @fish = split ',';
}

for (1..80) {
    my @new_fish;
    for my $f ( @fish ) {
        if ($f==0) {
            push @new_fish, 6,8;
        }
        else {
            push @new_fish, $f-1;
        }
    }
    @fish = @new_fish;
}

$result = @fish;

say $result;
