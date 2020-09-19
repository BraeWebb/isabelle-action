#!/usr/bin/env bash

set -eo pipefail

echo "$*"
echo "$HEAP_CACHE_DIR"

ls -al .

# Copy Heap Images from Cache to Local
# This command uses `isabelle env` for populating a new shell with Isabelle environment variables,
# and 'EOC' flood the shell with the following commands, while preventing the variables from
# begin substitued by the outer shell (that does not have the environment variables).
/Isabelle2020/bin/isabelle env bash << 'EOC'
if [ -n "$HEAP_CACHE_DIR" -a -d "$HEAP_CACHE_DIR" ]; then
  ls -al "$HEAP_CACHE_DIR"
  cp -r "$HEAP_CACHE_DIR" "$ISABELLE_HEAPS"
fi
EOC

/Isabelle2020/bin/isabelle env bash << 'EOC'
if [ -n "$HEAP_CACHE_DIR" -a -d "$ISABELLE_HEAPS" ]; then
  ls -al "$ISABELLE_HEAPS"
fi
EOC

# Run Isabelle
sh -c "/Isabelle2020/bin/isabelle $*"

# Copy Heap Images from Local to Cache
/Isabelle2020/bin/isabelle env bash << 'EOC'
if [ -n "$HEAP_CACHE_DIR" -a -d "$ISABELLE_HEAPS" ]; then
  cp -r "$ISABELLE_HEAPS" "$HEAP_CACHE_DIR"
  ls -al "$HEAP_CACHE_DIR"
fi
EOC