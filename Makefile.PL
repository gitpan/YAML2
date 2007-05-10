use inc::Module::Install;

name            'YAML2';
all_from        'lib/YAML2.pm';

requires        'Class::Field' => 0;

use_test_base;
use_perldoc;
build_subdirs    'LibYaml';

WriteAll;
