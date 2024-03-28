#!/bin/bash

function filter
{
    sed -E '/^module;$/d'                                                     | \

    sed -E 's:^import[[:space:]]+(<.*>|".*")+:#include \1:'                   | \

    sed -E '/^export[[:space:]]+module.*;$/d'                                 | \

    sed -E 's:^export[[:space:]]+import[[:space:]]+(<.*>|".*")+:#include \1:' | \

    sed -E '/^export$/d'                                                      | \

    sed -E 's:^export[[:space:]]+namespace[[:space:]]+:namespace :'           | \

    sed -E '/^module[[:space:]]+:[[:space:]]+private[[:space:]]+;$/d'         | \

    cat --squeeze-blank
}

function include
{
    if [ -n "${2}" ]; then
	sed --in-place \
	    '/.*/{H;$!d}
	    ; x
	    ; s:^:#ifndef GUARD_NAME\n#define GUARD_NAME:
	    ; s:$:\n\n#endif // GUARD_NAME:' \
	    ${1}

	sed --in-place "s:GUARD_NAME:${2}:" ${1}

    else
	sed --in-place '/.*/{H;$!d} ; x ; s:^:#pragma once:' ${1}
	
    fi
}

INPUT=$1
OUTPUT=$2
GUARD_NAME=$3

cat ${INPUT} | filter > ${OUTPUT} && include ${OUTPUT} ${GUARD_NAME} && \
    grep --color=auto --line-number --initial-tab --extended-regexp "^(export|import)" ${OUTPUT}
