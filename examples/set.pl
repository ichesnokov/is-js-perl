use v5.12;
use warnings;
use Set::Object;

my $s = Set::Object->new;
$s->insert("hello");
$s->insert("bye");
$s->insert("hello");
say $s->size;

say for @$s;
