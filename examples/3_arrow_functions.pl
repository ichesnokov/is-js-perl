use v5.12;
use warnings;

my @evens = (2, 4, 6);
my @odds  = map { $_ + 1 } @evens;
say "@odds";
