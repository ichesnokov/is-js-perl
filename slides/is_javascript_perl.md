# Is JavaScript Perl?

<br/>

Ilya Chesnokov

YAPC::EU 2016

Note:
Let's start with a foreword.
JavaScript relies on a ECMAScript standard.
ECMAscript is managed by ECMAScript technical committee (TC39).

---

## ECMAScript Technical Committee (TC39)

* Decided to move to a yearly release schedule. https://tc39.github.io/process-document/

---

## Released
* ES6 (ECMAScript 2015) - June 2015
  * A lot of new features (http://es6-features.org)
* ES7 (ECMAScript 2016) - June 2016

---

## Some of these changes look very familiar...
## ...for a Perl developer ;) <!-- .element: class="fragment" data-fragment-index="1" -->

---

## Let's have an overview.

Note:
And prove that people who say that no other languages borrow from Perl are liars!
---

### Constants

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
const PI = 3.14;
</code></pre>

</div>

<div class="col-md-6 fragment" data-fragment-index="1">
Perl
<pre><code class="perl">
use constant PI => 3.14;
</code></pre>

<pre class="fragment" data-fragment-index="2"><code class="perl">
use Const::Fast qw(const);

const my $PI       => 3.14;
const my @alphabet => ('a' .. 'z');
const my %hotness  => (
    Moss => 1,
    Roy  => 3,
    Jen  => 6,
);
</code></pre>
</div>

---

### Block-scoped variables

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
'use strict';

let x = 1;
{
    let x = 5;
}
console.log(x);
</code></pre>
<pre>
x = 1
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.12;
use warnings;

my $x = 1;
{
    my $x = 5;
}
say "x = $x";
</code></pre>
<pre>
x = 1
</pre>
</div>

---

### Block-scoped functions

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
'use strict';

{
    function hello() {
        console.log('Hi, world!');
    }
    hello();
}
hello();
</code></pre>
<pre>
Hi, world!
2_block_scoped_functions.js:9
hello();
^

ReferenceError: hello is not defined
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.18;
use warnings;
use experimental 'lexical_subs';

{
    my sub hello {
        say 'Hi, world!';
    }
    hello();
}
hello();
</code></pre>
<pre>
Hi, world!
Undefined subroutine &main::hello called at 2_block_scoped_functions.pl line 11.
</pre>
</div>

---

### Arrow functions

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
'use strict';

let evens = [2, 4, 6];
let odds  = evens.map(v => v + 1);
console.log(odds);
</code></pre>
<pre>
[3, 5, 7]
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.12;
use warnings;

my @evens = (2, 4, 6);
my @odds  = map { $_ + 1 } @evens;
say "@odds";
</code></pre>
<pre>
3 5 7
</pre>
</div>

Note:
@_ (vim fix)
And we also have prototypes to let our own functions accept blocks instead of
functions.


---

### Default function parameters

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
"use strict";

function add (x, y = 7, z = 42) {
    return x + y + z;
}
console.log(add(1));
</code></pre>
<pre>
50
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.22;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

sub add($x, $y = 7, $z = 42) {
    return $x + $y + $z;
}
say add(1);
</code></pre>
<pre>
50
</pre>
</div>

Note:


---

### Remaining parameters

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
"use strict";

function f (x, y, ...a) {
    return (x + y) * a.length
}
console.log(f(1, 2, "hello", true, 7));
</code></pre>
<pre>
9
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.12;
use warnings;

sub f {
    my ($x, $y, @args) = @_;

    return ($x + $y) * scalar(@args);
}
say f(1, 2, "hello", 1, 7);
</code></pre>
<pre>
9
</pre>
</div>

Note:


---

### Spread operator

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
"use strict";

var params = [ "hello", true, 7 ];
var other = [ 1, 2, ...params ];
console.log(other);
</code></pre>
<pre>
[ 1, 2, 'hello', true, 7 ]
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.12;
use warnings;

my @params = qw(hello true 7);
my @other = (1, 2, @params);
say "@other";
</code></pre>
<pre>
1 2 hello true 7
</pre>
</div>

Note:
Spread operator can also be used to split strings to chars. We have a split() function for that.

---

### Template literals, multiline strings

<div>
JavaScript
<pre><code class="javascript">
"use strict";

let customer = { name: "Foo" };
let card = { amount: 7, product: "Bar", unitprice: 42 };
let message = \`Hello ${customer.name},
want to buy ${card.amount} ${card.product} for
a total of ${card.amount * card.unitprice} bucks?\`
console.log(message);
</code></pre>
<pre>
Hello Foo,
want to buy 7 Bar for
a total of 294 bucks?
</pre>
</div>

---
### Template literals, multiline strings

<div>
Perl
<pre><code class="perl">
use v5.12;
use warnings;

my $customer = { name => "Foo" };
my $card = { amount => 7, product => "Bar", unitprice => 42 };
my $message = <<"MESSAGE";
Hello $customer->{name},
want to buy $card->{amount} $card->{product} for
a total of @{[ $card->{amount} * $card->{unitprice} ]} bucks?
MESSAGE
say $message;
</code></pre>
<pre>
Hello Foo,
want to buy 7 Bar for
a total of 294 bucks?
</pre>
</div>

Note:
Also introduces a "babycart" operator (see perldoc perlsecret)

---

### Binary and Octal literals

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
"use strict";

let binary = 0b1000;
let octal  = 0o10;
console.log(binary, octal);
</code></pre>
<pre>
8 8
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.12;
use warnings;

my $binary = 0b1000;
my $octal  = 010;
say "$binary $octal";
</code></pre>
<pre>
8 8
</pre>
</div>

Note:


---

### Better Unicode support, including regexes

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
"use strict";

console.log("Length of 𠮷: "
    + "𠮷".length);
console.log(
    "Length of matched part: "
    +  "𠮷".match(/./u)[0].length
);
</code></pre>
<pre>
Length of 𠮷: 2
Length of matched part: 2
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.14;
use warnings;
use utf8;
use feature qw(unicode_strings);

say "Length of 𠮷: " . length("𠮷");
say "Length of matched part: " . length($1) if "𠮷" =~ /(.)/u;
</code></pre>
<pre>
Length of 𠮷: 1
Length of matched part: 1
</pre>
</div>

Note:


---

### Regular Expression Sticky Matching

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
"use strict";

let str = "a1b2c3";
let re = /[a-z]\d+/y;
let matched;
while (matched = re.exec(str)) {
    console.log(matched[0]);
}
</code></pre>
<pre>
a1
b2
c3
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.12;
use warnings;

my $str = "a1b2c3";
while ($str =~ /\G([a-z]\d+)/gc) {
    say $1;
}
</code></pre>
<pre>
a1
b2
c3
</pre>
</div>

Note:


---

### Destructuring assignment: Array matching

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
"use strict";

var list = [1, 2, 3];
var [a, , b] = list;
console.log(a, b);
[b, a] = [a, b];
console.log(a, b);
</code></pre>
<pre>
1 3
3 1
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use v5.12;

my @list = (1, 2, 3);
my ($a, undef, $b) = @list;
say "$a $b";
($b, $a) = ($a, $b);
say "$a $b";
</code></pre>
<pre>
1 3
3 1
</pre>
</div>

Note:


---

### Destructuring assignments: object matching, shorthand notation

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
"use strict";

var obj = { x: 1, y: 5, z: 500 };
var { x, y, z } = obj;
console.log(x, y, z);
</code></pre>
<pre>
1 5 500
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use feature qw(say);

my %obj = (x => 1, y => 5, z => 500);
map { $$\_ = $obj{$\_} } keys %obj;
say "$x $y $z";
</code></pre>
<pre>
1 5 500
</pre>
</div>

Note:

---

### Weak-Link Data structures

<div>
JavaScript
<pre><code class="javascript">
"use strict";

let isMarked     = new WeakSet()
class Node {
    constructor (id)   { this.id = id                  }
    mark        ()     { isMarked.add(this)            }
    unmark      ()     { isMarked.delete(this)         }
}
let foo = new Node("foo")
foo.mark() // add to isMarked set 
console.log(\`isMarked.has(foo): ${isMarked.has(foo)}\`);
foo = null  // remove only reference to foo
console.log(\`isMarked.has(foo): ${isMarked.has(foo)}\`);
</code></pre>
<pre>
isMarked.has(foo): true
Deleting foo...
isMarked.has(foo): false
</pre>
</div>

---

### Weak-Link Data structures

<div>
Perl
<pre><code class="perl">
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
</code></pre>
<pre>
@isMarked: [{ id => 1 }], $foo: { id => 1 }
Weakening $isMarked[0]...
@isMarked: [{ id => 1 }], $foo: { id => 1 }
Deleting foo...
@isMarked: [undef], $foo: undef
</pre>
</div>

Note:

---




---

# Questions?

---

# Thanks!

<br/>
<br/>
<p style="font-size: x-large;">
Ilya Chesnokov &lt;<a href="mailto:chesnokov.ilya@gmail.com">chesnokov.ilya@gmail.com</a>&gt;<br/>
for YAPC::EU 2016
</p>