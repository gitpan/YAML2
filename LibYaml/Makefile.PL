use ExtUtils::MakeMaker;
use strict;
use Config;

my $obj_files = join ' ', map {
    my $c = $_;
    $c =~ s/\.c$/$Config::Config{_o}/;
    $c;
} glob("*.c"), 'LibYaml.c';

WriteMakefile(
    NAME => 'YAML2-LibYaml',
#     VERSION_FROM => 'lib/YAML2/LibYaml.pm',
    PREREQ_PM => {},
    DEFINE => '-DHAVE_CONFIG_H',
    LIBS => [''], # e.g., '-lm'
    INC => '-I. -Iinclude',
    OBJECT => $obj_files,
    ABSTRACT_FROM => 'lib/YAML2/LibYaml.pm',
    AUTHOR => 'Ingy döt Net <ingy@cpan.org>',
);
