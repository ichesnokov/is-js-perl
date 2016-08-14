use v5.12;
use warnings;

my $str = "a1b2c3";
while ($str =~ /\G([a-z]\d+)/gc) {
    say $1;
}
