package YAML2::Parser::LibYaml;
use strict;
use warnings;
use YAML2::Parser::Base -base;

sub parse {
    my $self = shift;
    $self->receiver->output(<<'...');
[
"one",
"two",
"three"
]
...
}

1;
