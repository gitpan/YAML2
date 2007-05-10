#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"
#include <yaml.h>

MODULE = YAML2::LibYaml		PACKAGE = YAML2::LibYaml		

PROTOTYPES: DISABLE

void
Load (yaml_str)
	char*	yaml_str
        PPCODE:
        PL_markstack_ptr++;
        Load(yaml_str);
        return;

