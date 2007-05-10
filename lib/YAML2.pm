## Next Generation YAML Tools For Perl
# 
# YAML2 is a backwards compatible rewrite of YAML.pm. When YAML2 is done and
# stable, the code will be duplicated as YAML.pm, and YAML2 will be
# deprecated. At that point, you can simply `s/YAML2/YAML/g` in your code, and
# everything will work out.
# 
# YAML2 includes pure Perl code and Extensions of libyaml.
#
# NOTE: This implementation now has a rudimentary binding to libyaml
# (YAML2::LibYaml) that seems to work for plain hashes, arrays and
# scalars. This should cover all of JSON since JSON is a strict subset
# of YAML.
#
# Copyright (c) 2007. Ingy döt Net <ingy@cpan.org>. All rights reserved.
#
# Licensed under the same terms as Perl itself.

package YAML2;
use 5.005003;
use YAML2::Base -base;
use strict;
use warnings;
use XXX;
use base 'Exporter';

$YAML2::VERSION = '0.02';
@YAML2::EXPORT = qw'Dump Load';
@YAML2::EXPORT_OK = qw'DumpFile LoadFile freeze thaw';
%YAML2::EXPORT_TAGS = (all => [qw'Dump Load DumpFile LoadFile']);

sub import {
    my $class = shift;
    my @export = grep { not /^-/ } @_;
    $class->export_to_level(1, $class, @export);
}

field dumper_class =>
    -init => '$YAML2::DumperClass || "YAML2::Dumper"';
field dumper =>
    -init => '$self->create("dumper")';

field loader_class =>
    -init => '$YAML2::LoaderClass || "YAML2::Loader"';
field loader =>
    -init => '$self->create("loader")';

sub Dump {
    return YAML->new->dumper->dump(@_);
}

sub Load {
    return YAML->new->loader->load(@_);
}

{
    no warnings 'once';
    *YAML::freeze = \ &Dump;
    *YAML::thaw   = \ &Load;
}

sub DumpFile {
    my $OUT;
    my $filename = shift;
    if (ref $filename eq 'GLOB') {
        $OUT = $filename;
    }
    else {
        my $mode = '>';
        if ($filename =~ /^\s*(>{1,2})\s*(.*)$/) {
            ($mode, $filename) = ($1, $2);
        }
        open $OUT, $mode, $filename
          or YAML::Base->die('YAML_DUMP_ERR_FILE_OUTPUT', $filename, $!);
    }  
    local $/ = "\n"; # reset special to "sane"
    print $OUT Dump(@_);
}

sub LoadFile {
    my $IN;
    my $filename = shift;
    if (ref $filename eq 'GLOB') {
        $IN = $filename;
    }
    else {
        open $IN, $filename
          or YAML::Base->die('YAML_LOAD_ERR_FILE_INPUT', $filename, $!);
    }
    return Load(do { local $/; <$IN> });
}


1;

## IDEAS:
#
# * Support JSON
# * Use all tests from YAML.pm and YAML::Syck
# * Support all options from YAML.pm and YAML::Syck
# * Use tests from pyyaml
# * Include YAML::Syck
# * Include YAML::Lite
# * Support `use YAML -foo` such that Load uses YAML::Loader::Foo and Dump...
# 



























=for perldoc
This POD generated by Perldoc-0.22.
DO NOT EDIT. Your changes will be lost.

=encoding utf8

=head1 NAME

YAML2 - Next Generation YAML Tools For Perl

=head1 DESCRIPTION

YAML2 is a backwards compatible rewrite of YAML.pm. When YAML2 is done and
stable, the code will be duplicated as YAML.pm, and YAML2 will be
deprecated. At that point, you can simply C<s/YAML2/YAML/g> in your code, and
everything will work out.

YAML2 includes pure Perl code and Extensions of libyaml.

NOTE: This implementation now has a rudimentary binding to libyaml
(YAML2::LibYaml) that seems to work for plain hashes, arrays and
scalars. This should cover all of JSON since JSON is a strict subset
of YAML.

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2007. Ingy döt Net. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
