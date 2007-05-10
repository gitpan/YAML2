package YAML2::Base;
use strict;
use Class::Field 0.10 qw'field const';

sub import {
    my $class = shift;
    my $flag = $_[0] || '';
    my $package = caller;
    if ($flag eq '-base') {
        no strict 'refs';
        push @{$package . "::ISA"}, $class;
        *{$package . "::$_"} = \&$_
          for qw'io field const WWW XXX YYY ZZZ';
    }
}

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    while (my ($field, $value) = splice @_, 0, 2) {
        $self->$field($value);
    }
    return $self;
}

1;
