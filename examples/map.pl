use v5.12;
use Scalar::Util qw(weaken);
use Data::Dump qw(pp);

my $foo = { id => 1 };
my @isMarked = ($foo);

say '@isMarked: ',  pp(\@isMarked), ', $foo: ', pp($foo);
say 'Weakening $isMarked[0]...';
weaken($isMarked[0]);
say '@isMarked: ',  pp(\@isMarked), ', $foo: ', pp($foo);
say 'Deleting foo...';
undef $foo;
say '@isMarked: ',  pp(\@isMarked), ', $foo: ', pp($foo);
