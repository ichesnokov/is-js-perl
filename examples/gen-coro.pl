#!/usr/bin/env perl
use v5.12;
use warnings;
use Coro;
use Coro::AnyEvent;

async {
    my $counter = 1;
    say $counter++;
    cede();
    say $counter++;
    cede();
    say $counter++;
    cede();
};
Coro::AnyEvent::idle;
