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
