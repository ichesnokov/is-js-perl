#!/usr/bin/env perl
use uni::perl;

my @features = (
    [
        'Default function parameters',
        <<'JS',
"use strict";

function add (x, y = 7, z = 42) {
    return x + y + z;
}
console.log(add(1));
JS
        <<'PERL',
use v5.22;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

sub add($x, $y = 7, $z = 42) {
    return $x + $y + $z;
}
say add(1);
PERL
    ],
    [
        'Remaining parameters',
	<<'JS',
"use strict";

function f (x, y, ...a) {
    return (x + y) * a.length
}
console.log(f(1, 2, "hello", true, 7));
JS
	<<'PERL',
use v5.12;
use warnings;

sub f {
    my ($x, $y, @args) = @_;

    return ($x + $y) * scalar(@args);
}
say f(1, 2, "hello", 1, 7);
PERL
    ],
    [
        'Spread operator',
	<<'JS',
"use strict";

var params = [ "hello", true, 7 ];
var other = [ 1, 2, ...params ];
console.log(other);
JS
	<<'PERL',
use v5.12;
use warnings;

my @params = qw(hello true 7);
my @other = (1, 2, @params);
say "@other";
PERL
	'Spread operator can also be used to split strings to chars. We have a split() function for that.',
    ],
    [
        'Template literals, multiline strings',
	<<'JS',
"use strict";

let customer = { name: "Foo" };
let card = { amount: 7,
    product: "Bar",
    unitprice: 42 };
let message = `Hello ${customer.name},
want to buy ${card.amount} ${card.product} for
a total of ${card.amount * card.unitprice} bucks?`
console.log(message);
JS
	<<'PERL',
use v5.12;
use warnings;

my $customer = { name => "Foo" };
my $card = { amount => 7,
    product => "Bar",
    unitprice => 42 };
my $message = <<"MESSAGE";
Hello $customer->{name},
want to buy $card->{amount} $card->{product} for
a total of @{[ $card->{amount} * $card->{unitprice} ]} bucks?
MESSAGE
say $message;
PERL
	'Also introduces a "babycart" operator (see perldoc perlsecret)'
    ],
    [
        'Binary and Octal literals',
	<<'JS',
"use strict";

let binary = 0b1000;
let octal  = 0o10;
console.log(binary, octal);
JS
	<<'PERL',
use v5.12;
use warnings;

my $binary = 0b1000;
my $octal  = 010;
say "$binary $octal";
PERL
    ],
    [
        'Better Unicode support, including regexes',
        <<'JS',
"use strict";

console.log("Length of 𠮷: "
    + "𠮷".length);
console.log(
    "Length of matched part: "
    +  "𠮷".match(/./u)[0].length
);
JS
        <<'PERL',
use v5.14;
use warnings;
use utf8;
use feature qw(unicode_strings);

say "Length of 𠮷: " . length("𠮷");
say "Length of matched part: " . length($1) if "𠮷" =~ /(.)/u;
PERL
    ],
    [
        'Regular Expression Sticky Matching',
	<<'JS',
"use strict";

let str = "a1b2c3";
let re = /[a-z]\d+/y;
let matched;
while (matched = re.exec(str)) {
    console.log(matched[0]);
}
JS
	<<'PERL',
use v5.12;
use warnings;

my $str = "a1b2c3";
while ($str =~ /\G([a-z]\d+)/gc) {
    say $1;
}
PERL
    ],
    [
'Destructuring assignment: Array matching',
<<'JS',
"use strict";

var list = [1, 2, 3];
var [a, , b] = list;
console.log(a, b);
[b, a] = [a, b];
console.log(a, b);
JS
<<'PERL',
use v5.12;
use warnings;

my @list = (1, 2, 3);
my ($a, undef, $b) = @list;
say "$a $b";
($b, $a) = ($a, $b);
say "$a $b";
PERL
    ],
    [
'Destructuring assignments: object matching, shorthand notation',
<<'JS',
"use strict";

var obj = { x: 1, y: 5, z: 500 };
var { x, y, z } = obj;
console.log(x, y, z);
JS
<<'PERL',
use v5.12;
use warnings;

my %obj = (x => 1, y => 5, z => 500);
no strict;
no warnings "once";
map { $$_ = $obj{$_} } keys %obj;
say "$x $y $z";
PERL
    ],
    [
        'Weak-link data structures',
	<<'JS',
JS
	<<'PERL',
PERL
    ],
);
