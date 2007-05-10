use t::TestYAML tests => 22;

package A;
use YAML2;

package B;
use YAML2 -libyaml;

package C;
use YAML2 -syck;

package D;
use YAML2 -tiny;

package E;
use YAML2 -old;

package F;
use YAML2 qw'LoadFile DumpFile';

package G;
use YAML2 -libyaml => qw'LoadFile DumpFile';

package H;
use YAML2 qw':all';

package I;
use YAML2 qw':all' => -tiny;

package main;

for my $package ('A' .. 'E', 'H' .. 'I') {
    ok defined(&{"${package}::Dump"}),
        "Dump function defined in package $package";
    ok defined(&{"${package}::Load"}),
        "Load function defined in package $package";
}

for my $package ('F' .. 'G') {
    ok defined(&{"${package}::DumpFile"}),
        "DumpFile function defined in package $package";
    ok defined(&{"${package}::LoadFile"}),
        "LoadFile function defined in package $package";
    ok not(defined(&{"${package}::Dump"})),
        "Dump not function defined in package $package";
    ok not(defined(&{"${package}::Load"})),
        "Load not function defined in package $package";
}
