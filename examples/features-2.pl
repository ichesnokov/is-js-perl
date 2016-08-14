#!/usr/bin/env perl
use uni::perl;

my @features = (
    [
        'Object Property Assignment',
        <<'JS',
"use strict";

let dst  = { quux: 0 }
let src1 = { foo: 1, bar: 2 }
let src2 = { foo: 3, baz: 4 }
Object.assign(dst, src1, src2)
console.log(dst);
JS
        <<'PERL',
use v5.12;
use Data::Dump qw(pp);

my $dst  = { quux => 0 };
my $src1 = { foo => 1, bar => 2 };
my $src2 = { foo => 3, baz => 4 };
$dst = { %$dst, %$src1, %$src2 };
say pp($dst);
PERL
	'There is Hash::Merge / clone modules for more complex cases'
    ],
    [
        'Array Element Finding',
        <<'JS',
"use strict";

let item = [1, 3, 4, 2].find(x => x > 3); // 4
console.log(item);
JS
        <<'PERL',
use v5.12;
use List::Util qw(first);

my $item = first { $_ > 3 } (1, 3, 4, 2);
say $item;
PERL
    ],
    [
        'String repeating',
        <<'JS',
"use strict";

console.log("foo".repeat(3));
JS
        <<'PERL',
use v5.12;

say "foo" x 3;
PERL
    ],
    [
        'String Searching',
        <<'JS',
"use strict";

console.log( "hello".startsWith("ello", 1)  );
console.log( "hello".endsWith("hell", 4)    );
console.log( "hello".includes("ell")        );
console.log( "hello".includes("ell", 1)     );
console.log( "hello".includes("ell", 2)     );
JS
        <<'PERL',
use v5.12;

say substr("hello", 1) =~ /^ello/ ? "true" : "false";
say substr("hello", 0, 4) =~ /hell$/ ? "true" : "false";
say index("hello", "ell") >= 0 ? "true" : "false";
say index("hello", "ell", 1) >= 0 ? "true" : "false";
say index("hello", "ell", 2) >= 0 ? "true" : "false";
PERL
    ],
);
