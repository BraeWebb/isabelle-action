#!/usr/bin/env bash

set -eo pipefail

# Copy Heap Images from Cache to Local
# This command uses `isabelle env` for populating a new shell with Isabelle environment variables,
# and 'EOC' flood the shell with the following commands, while preventing the variables from
# begin substitued by the outer shell (that does not have the environment variables).
/Isabelle2023/bin/isabelle env bash << 'EOC'
if [ -n "$HEAP_CACHE_DIR" -a -d "$HEAP_CACHE_DIR" ]; then
  mkdir -p "$ISABELLE_HEAPS"
  cp -r "$HEAP_CACHE_DIR"/* "$ISABELLE_HEAPS"
fi
EOC

# Run Isabelle
sh -c "/Isabelle2023/bin/isabelle $*"

# Copy Heap Images from Local to Cache
/Isabelle2023/bin/isabelle env bash << 'EOC'
if [ -n "$HEAP_CACHE_DIR" -a -d "$ISABELLE_HEAPS" ]; then
  mkdir -p "$HEAP_CACHE_DIR"
  cp -r "$ISABELLE_HEAPS"/* "$HEAP_CACHE_DIR"
fi
EOC
