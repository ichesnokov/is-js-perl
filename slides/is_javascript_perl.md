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

Note:
and for developers of other scripting languages.
---

## Let's have an overview.

Note:
I'll show you examples in Javascript, tell how JS guys call that and show the
appropriate examples in Perl.
Let's start.
Hope we'll be able to prove that people who say that no other languages borrow from Perl are liars!

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

Note:
In Perl: for ages (core)

---

### Block-scoped variables

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
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

Note:
In Perl: for ages (core)<br/>
And it's required in 'strict' mode.
---

### Block-scoped functions

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
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

Note:
In Perl: recently (still experimental).
---

### Arrow functions

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
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

<!--
<div class="col-md-6">
JavaScript
<pre><code class="javascript">
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

-->

### (no examples: my browser/OS doesn't support Unicode properly) <!-- .element: class="fragment" data-fragment-index="1" -->


Note:
But Perl does have. Perl had a good Unicode 6.0 support since version 5.14.0.
5.24.0 supports Unicode 8.0 (released June 2015).<br/>
Unicode seems to have a yearly version schedule as well.

---

### Regular Expression Sticky Matching

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
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
\G matches at the start of a previous search<br/>
/g  Match globally, i.e., find all occurrences.<br/>
/c  Do not reset search position on a failed match when /g is in effect.<br/>

---

### Destructuring assignment: Array matching

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
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

### Destructuring assignments: Object matching, shorthand notation

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
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

### Set data structure

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
let s = new Set();
s.add("hello");
s.add("bye");
s.add("hello");
console.log(s.size);
</code></pre>
<pre>
2
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use Set::Object;

my $s = Set::Object->new;
$s->insert("hello");
$s->insert("bye");
$s->insert("hello");
say $s->size;
</code></pre>
<pre>
2
</pre>
</div>

Note:
JavaScript has Map and Set data structures now. Map is similar to a hash
(object in JS), Set is similar to array with unique keys. The difference
between Map and object / hash is that you can use objects as keys. In Perl we
can do similar thing using Scalar::Util::refaddr()

In Perl: CPAN

---

### Map data structure

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
let m = new Map()
let s = {x:10};
m.set("hello", 42)
m.set(s, "object")
console.log(m);
</code></pre>
<pre>
Map { 'hello' => 42, { x: 10 } => 'object' }
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="2">
Perl
<pre><code class="perl">
use Scalar::Util qw(refaddr);
use Data::Dump qw(pp);

my $m = { hello => 42 };
my $s = { x => 10 };
$m->{refaddr($s)} = 'object';
say pp($m);
</code></pre>
<pre>
{ 30131080 => "object", hello => 42 }
</pre>
</div>

Note:
It's a bit more complicated in Perl: you need to do some manual fuckery to
translate object to a refaddr or refaddr to an actual object, but I'm pretty
sure that there is something for that on CPAN.<br/>
In Perl: Manual fuckery (can be on CPAN)

---

### Weak-Link Data structures: JavaScript

<div>
<pre><code class="javascript">
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

Note:

---

### Weak-Link Data structures (?): Perl

<div>
<pre><code class="perl">
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

## Built-in methods

---

### Object Property Assignment

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
let dst  = { quux: 0 }
let src1 = { foo: 1, bar: 2 }
let src2 = { foo: 3, baz: 4 }
Object.assign(dst, src1, src2)
console.log(dst);
</code></pre>
<pre>
{ quux: 0, foo: 3, bar: 2, baz: 4 }
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="1">
Perl
<pre><code class="perl">
use Data::Dump qw(pp);

my $dst  = { quux => 0 };
my $src1 = { foo => 1, bar => 2 };
my $src2 = { foo => 3, baz => 4 };
$dst = { %$dst, %$src1, %$src2 };
say pp($dst);
</code></pre>
<pre>
{ bar => 2, baz => 4, foo => 3, quux => 0 }
</pre>
</div>

Note:
Such a complex name in JS. In Perl it would be something like "Hash
assignment".<br/>
There is Hash::Merge / clone modules for more complex cases<br/>
In Perl: core

---

### Array Element Finding

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
let item = [1, 3, 4, 2].find(x => x > 3); // 4
console.log(item);
</code></pre>
<pre>
4
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="1">
Perl
<pre><code class="perl">
use List::Util qw(first);

my $item = first { $\_ > 3 } (1, 3, 4, 2);
say $item;
</code></pre>
<pre>
4
</pre>
</div>

Note:
In Perl: core

---

### String repeating (oh, really?!?! WTF :)

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
console.log("foo".repeat(3));
</code></pre>
<pre>
foofoofoo
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="1">
Perl
<pre><code class="perl">
say "foo" x 3;
</code></pre>
<pre>
foofoofoo
</pre>
</div>

Note:
In Perl: core

---

### String Searching

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
console.log( "hello".startsWith("ello", 1)  );
console.log( "hello".endsWith("hell", 4)    );
console.log( "hello".includes("ell")        );
console.log( "hello".includes("ell", 1)     );
console.log( "hello".includes("ell", 2)     );
</code></pre>
<pre>
true
true
true
true
false
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="1">
Perl
<pre><code class="perl">
say substr("hello", 1) =~ /^ello/ ? "true" : "false";
say substr("hello", 0, 4) =~ /hell$/ ? "true" : "false";
say index("hello", "ell") >= 0 ? "true" : "false";
say index("hello", "ell", 1) >= 0 ? "true" : "false";
say index("hello", "ell", 2) >= 0 ? "true" : "false";
</code></pre>
<pre>
true
true
true
true
false
</pre>
</div>

Note:
There are some shorthand operators, which we can imitate in Perl using regexes
and / or index() / substr().

---

## More advanced stuff

---

### Iterators and Generators: generating sequences

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
let fibonacci = {
    \*\[Symbol.iterator\]() {
        let pre = 0, cur = 1
        for (;;) {
            [ pre, cur ] = [ cur, pre + cur ]
            yield cur
        }
    }
}
let numbers = [];
for (let n of fibonacci) {
    if (n > 1000)
        break
    numbers.push(n);
}
console.log(numbers);
</code></pre>
<pre>
[ 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987 ]
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="1">
Perl
<pre><code class="perl">
use FAST::List::Gen;

my $fib = do {
    my ($pre, $cur) = (0, 1);
    iterate {
        ($pre, $cur) = ($cur, $pre + $cur);
        return $cur;
    }
};
my @numbers;
for my $n (@$fib) {
    last if $n > 1000;
    push @numbers, $n;
}
say "@numbers";
</code></pre>
<pre>
1 2 3 5 8 13 21 34 55 89 144 233 377 610 987
</pre>
</div>

Note:
In Perl: CPAN

---

### Generators: coroutines

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
function\* task() {
  let counter = 1;
  yield counter++;
  yield counter++;
  yield counter++;
}

var iterator = task();

let res = iterator.next();
while (!res.done) {
    console.log(res.value);
    res = iterator.next();
}
</code></pre>
<pre>
1
2
3
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="1">
Perl
<pre><code class="perl">
use Coro;
use Coro::AnyEvent;

async {
    my $counter = 1;
    say $counter++;
    cede();
    say $counter++;
    cede();
    say $counter++;
    cede();
};
Coro::AnyEvent::idle;
</code></pre>
<pre>
1
2
3
</pre>
</div>

Note:
In Perl: CPAN (<= v5.20)<br/>

---

### Generators: coroutines

| JavaScript | Perl |
|---|---|
|Allows to pass / return values with yield()|Doesn't allow to pass / values with cede() |
|Built into a core|Not in Perl core (unfortunately) |
|Requires manual fiddling and control of the flow (libraries that make this job easier possibly exist)|Control flow requires some learning / understanding, but eventually requires writing fewer lines of code|

Note:

---

### Promises: JavaScript

<div>
<pre><code class="javascript">
function msgAfterTimeout(msg, who, timeout) {
    return new Promise(
        (resolve, reject) => {
            setTimeout(() => resolve(\`${msg} Hello ${who}!\`), timeout)
        }
    )
}
msgAfterTimeout("", "Foo", 500).then(
    (msg) =>
        msgAfterTimeout(msg, "Bar", 1000)
).then(
    (msg) => {
        console.log(\`Done after 1500ms:${msg}\`)
    }
)
</code></pre>
<pre>
Done after 1500ms: Hello Foo! Hello Bar!
</pre>
</div>

---

### Promises: Perl

<div>
<pre><code class="perl" style="max-height:700px;">
use Promises qw(deferred);
use AE;

my @timers;
my $cv = AE::cv;

sub msgAfterTimeout {
    my ($msg, $who, $timeout\_ms) = @\_;

    my $deferred = deferred;
    $cv->begin;
    push @timers, AE::timer $timeout\_ms / 1000, 0, sub {
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
</code></pre>
<pre>
Done after 1500ms: Hello Foo! Hello Bar!
</pre>
</div>

Note:
In Perl: CPAN

---

## Is Javascript Perl?
## No.              <!-- .element: class="fragment" data-fragment-index="1" -->
## But it's close!  <!-- .element: class="fragment" data-fragment-index="2" -->
### ...and it's now better than before ;)  <!-- .element: class="fragment" data-fragment-index="3" -->

---

# Questions?
## Notes?
### Criticism?
#### Rotten tomatoes?

---

# Thanks!

<br/>
<br/>
<p style="font-size: x-large;">
Ilya Chesnokov &lt;<a href="mailto:chesnokov.ilya@gmail.com">chesnokov.ilya@gmail.com</a>&gt;<br/>
for YAPC::EU 2016
</p>
