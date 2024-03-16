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

INPUT=$1
OUTPUT=$2

cat ${INPUT} | filter > ${OUTPUT}
