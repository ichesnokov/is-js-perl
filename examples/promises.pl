#!/usr/bin/env perl
use v5.12;
use warnings;
use Promises qw(deferred);
use AE;

my @timers;
my $cv = AE::cv;

sub msgAfterTimeout {
    my ($msg, $who, $timeout_ms) = @_;

    my $deferred = deferred;
    $cv->begin;
    push @timers, AE::timer $timeout_ms / 1000, 0, sub {
        $deferred->resolve("$msg Hello $who!");
        $cv->end;
    };
    $deferred->promise;
}

msgAfterTimeout("", "Foo", 500)->then(sub {
    my $msg = shift;
    msgAfterTimeout($msg, 'Bar', 1000);
})->then(sub {
    my $msg = shift;
    say "Done after 1500ms:$msg";
});
$cv->recv;
