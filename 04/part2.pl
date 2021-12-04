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

NUMBER:
for my $n (@numbers) {
    my @to_remove = ();
    #printf "N:%2d (%3d)\n", $n, scalar(@boards);
    BOARD:
    for my $bidx ( 0..$#boards ) {
        my $b = $boards[$bidx];
        mark_number($b, $n);
        if ( check_win($b) ) {
            if ( @boards > 1 ) {
                push @to_remove, $bidx;;
                next BOARD;
            }
            elsif ( @boards == 1 ) {
                $result = calculate_result($b, $n);
                last NUMBER;
            }
        }
    }
    if ( @to_remove == @boards ) {
        say "Will remove all boards? ", scalar(@boards);
    }
    if ( @to_remove ) {
        for my $idx ( reverse @to_remove ) {
            splice @boards, $idx, 1;
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

sub display_board {
    my $b = shift;

    for my $r (0..$SQUARE-1) {
        for my $c (0..$SQUARE-1) {
            my $e = $b->[$r][$c]{m} ? '_' : ' ';
            printf " %s%2d%s", $e, $b->[$r][$c]{n}, $e;
        }
        print "\n";
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
