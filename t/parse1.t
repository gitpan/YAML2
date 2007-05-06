use t::TestYAML tests => 1;
use diagnostics;

$TestYAML::Parser = 'YAML2::Parser::LibYaml';

spec_file('t/data1.t');
filters {
    yaml => ['parse_to_byte']
};

run_is yaml => 'canon';

sub parse_to_byte {
    eval "require $TestYAML::Parser; 1" or die $@;
    require YAML2::Emitter::TestForm;

    my $e = YAML2::Emitter::TestForm->new;
    my $p = $TestYAML::Parser->new(
        input => $_,
        receiver => $e,
    );
    $p->parse;
    $_ = $e->output;
}
