#!/usr/bin/env bash

set -eo pipefail

echo "$*"

# Run Isabelle
sh -c "/Isabelle2020/bin/isabelle $*"

# Copy Heap
if [ -d /root/.isabelle/Isabelle2020/heaps ]; then
   env "$(/Isabelle2020/bin/isabelle getenv ISABELLE_HEAPS)" sh -c 'cp -r "$ISABELLE_HEAPS" "$GITHUB_WORKSPACE/heaps"' 
fi