#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

my $SQUARE=5;

use List::Util qw( sum0 min max );
#use List::MoreUtils qw( any minmax firstidx duplicates uniq singleton );
my $result;
my @numbers = split /,/, <>;
<>; # Skip one more line

my @boards = ([]);
while (<>) {
    if (/^\s*$/) {
        push @boards, [];
        next;
    }
    chomp;
    my @b = map { {n=>$_,m=>''} } split;
    push @{$boards[-1]}, \@b;
}

#use Data::Dumper; say Dumper($boards[0]); exit;

NUMBER:
for my $n (@numbers) {
    for my $b (@boards) {
        mark_number($b, $n);
        if ( check_win($b) ) {
            $result = calculate_result($b, $n);
            last NUMBER;
        }
    }
}


say $result;

sub calculate_result {
    my ($b, $n) = @_;
    return $n * sum0( map { $_->{n} } grep { !$_->{m} } map { @$_ } @$b );
}

sub check_win {
    my $b = shift;
    for my $idx (0..$SQUARE-1) {
        my @marked = grep { $b->[$idx][$_]{m} } 0..4;
        if ( @marked == $SQUARE ) {
            return 1;
        }
        @marked = grep { $b->[$_][$idx]{m} } 0..4;
        if ( @marked == $SQUARE ) {
            return 1;
        }
    }
}

sub mark_number {
    my ($b, $n) = @_;
    my $m=0;
    for my $r ( 0..$SQUARE-1 ) {
        for my $c (0..$SQUARE-1) {
            if ($b->[$r][$c]{n} == $n) {
                $b->[$r][$c]{m} = 1;
                $m++;
            }
        }
    }
}
