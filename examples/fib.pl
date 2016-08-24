use v5.12;
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
