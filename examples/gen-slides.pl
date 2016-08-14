#!/usr/bin/env perl
use uni::perl;

my $features_script = shift
    or die "Usage: $0 <script_with_features>\n";

my @features = do $features_script;
for my $feature (@features) {
    my ($title, $js, @perls) = @$feature;

    while (chomp $js) { }
    my $js_result    = eval_js($js);
    #say "js result: $js_result";

    my $note = '';
    if ($perls[-1] !~ /^use /) {
        $note = pop @perls;
    }
    my @perl_results = map {
        while (chomp $_) { };
        eval_perl($_);
    } @perls;
    #say "perl results: $_" for @perl_results;

    # Escape characters that Markdown tries to interpolate
    $js =~ s{`}{\\`}g;
    s{\$_}{\$\\_}g for @perls;

    print <<"SLIDE";
---

## $title

<div class="col-md-6">
JavaScript
<pre><code class="javascript">
$js
</code></pre>
<pre>
$js_result
</pre>
</div>

<div class="col-md-6 fragment" data-fragment-index="1">
Perl
SLIDE

    for my $i (0 .. $#perls) {
        print <<"PERL_RESULT";
<pre><code class="perl">
$perls[$i]
</code></pre>
<pre class="fragment" data-fragment-index="@{[ $i + 2 ]}">
$perl_results[$i]
</pre>
PERL_RESULT
    }

    say <<"SLIDE_FOOTER";
</div>

Note:
$note
SLIDE_FOOTER
}

sub eval_js {
    my ($code) = @_;

    chomp(my $result = `node -e '$code'`);
    return $result;
}

sub eval_perl {
    my ($code) = @_;

    chomp(my $result = `perl -e '$code'`);
    return $result;
}
