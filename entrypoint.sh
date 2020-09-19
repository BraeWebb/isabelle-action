#!/usr/bin/env bash

set -eo pipefail

echo "$*"

# Run Isabelle
sh -c "/Isabelle2020/bin/isabelle $*"

# Copy Heap
# This command uses `isabelle env` for populating a new shell with Isabelle environment variables,
# and 'EOC' flood the shell with the following commands, while preventing the variables from
# begin substitued by the outer shell (that does not have the environment variables).
/Isabelle2020/bin/isabelle env bash << 'EOC'
if [ -d $ISABELLE_HEAPS ]; then
   cp -r "$ISABELLE_HEAPS" "$GITHUB_WORKSPACE/heaps"
fi
EOC