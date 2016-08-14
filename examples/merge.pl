use v5.12;
use Data::Dump qw(pp);

my $dst  = { quux => 0 };
my $src1 = { foo => 1, bar => 2 };
my $src2 = { foo => 3, baz => 4 };
$dst = { %$dst, %$src1, %$src2 };
say pp($dst);
