#!/bin/bash

function filter
{
    sed -E '/^module;$/d'                                                     | \

    sed -E 's:^import[[:space:]]+(<.*>|".*")+:#include \1:'                   | \

    sed -E '/^export[[:space:]]+module.*;$/d'                                 | \
	    
    sed -E 's:^export[[:space:]]+import[[:space:]]+(<.*>|".*")?:#include \1:' | \

    sed -E '/^export$/d'                                                      | \

    sed -E 's:^export[[:space:]]+namespace[[:space:]]+:namespace :'           | \
	    
    sed -E '/^module[[:space:]]+:[[:space:]]+private[[:space:]]+;$/d'
}

function include
{
    if [ -n "${2}" ]; then
	sed --in-place \
	    '/.*/{H;$!d}
	    ; x
	    ; s:^:#ifndef __GUARD__\n#define __GUARD__\n:
	    ; s:$:\n\n#endif // __GUARD__:' \
	    ${1}

	sed --in-place "s:__GUARD__:${2}:" ${1}

    else
	sed --in-place '/.*/{H;$!d} ; x ; s:^:#pragma once\n:' ${1}
	
    fi
}

INPUT=$1
OUTPUT=$2
GUARD=$3

cat ${INPUT} | filter > ${OUTPUT} && include ${OUTPUT} ${GUARD}
