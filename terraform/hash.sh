#!/bin/bash

# 
# Calculates hash of lambda aplication code

set -e

source_path=${1:-.}

# Hash all source files
# Exclude Python cache files, dot files
file_hashes="$(
    cd "$source_path" \
    && find . -type f -not -name '*.pyc' -not -path './.**' -exec md5sum {} \;
)"

hash="$(echo "$file_hashes" | md5sum | cut -d' ' -f1)"

echo '{ "hash": "'"$hash"'" }'
