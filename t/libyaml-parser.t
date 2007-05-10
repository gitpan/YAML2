use t::TestYAML tests => 4;
use blib;

spec_file('t/data1.t');
filters {
    yaml => ['parse_to_byte'],
    perl => ['eval'],
};

run_is_deeply yaml => 'perl';

sub parse_to_byte {
    require YAML2::LibYaml;
    YAML2::LibYaml::Load($_);
}
