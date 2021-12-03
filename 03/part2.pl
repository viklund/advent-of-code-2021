#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

#use List::Util qw( sum0 min max );
#use List::MoreUtils qw( any minmax firstidx duplicates uniq singleton );

my @all_values;
while (<>) {
    chomp;
    my @values = split //, $_;
    push @all_values, \@values;
}

my $max_idx = $#{ $all_values[0] };

my @new_values = @all_values;
for my $idx (0..$max_idx) {
    my $result = calculate_most_common( @new_values );
    my $v = substr $result, $idx, 1;
    @new_values = grep { $_->[$idx] == $v } @new_values;
}

my $r1 = oct( "0b" . join("", @{$new_values[0]}) );

@new_values = @all_values;
for my $idx (0..$max_idx) {
    my $result = calculate_most_common( @new_values );
    my $v = substr $result, $idx, 1;
    @new_values = grep { $_->[$idx] != $v } @new_values;
    last if @new_values == 1;
}

my $r2 = oct( "0b" . join("", @{$new_values[0]}) );

say $r1*$r2;


sub calculate_most_common {
    my @vs = @_;
    my @counts;
    for my $value (@vs) {
        for my $idx (0..$#$value) {
            $counts[$idx]++ if $value->[$idx];
        }
    }
    my $result;
    for my $idx (0..$#counts) {
        $counts[$idx] //= 0;
        if ( $counts[$idx] >= @vs/2 ) {
            $result .= 1;
        }
        else {
            $result .= 0;
        }
    }
    return $result;
}
