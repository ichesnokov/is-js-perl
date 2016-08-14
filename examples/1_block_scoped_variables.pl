use v5.12;
use warnings;

my $x = 1;
{
    my $x = 5;
}
say "x = $x";
