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

# Questions?

---

# Thanks!

<br/>
<br/>
<p style="font-size: x-large;">
Ilya Chesnokov &lt;<a href="mailto:chesnokov.ilya@gmail.com">chesnokov.ilya@gmail.com</a>&gt;<br/>
for YAPC::EU 2016
</p>
