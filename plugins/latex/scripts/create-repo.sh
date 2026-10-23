#!/usr/bin/env bash
# Commit <dir>, create the GitHub repo <owner/name> from it and push (this triggers the first PDF build).
# Usage: create-repo.sh <dir> <owner/name> [--public|--private]
set -euo pipefail

DIR=${1:?usage: create-repo.sh <dir> <owner/name> [--public|--private]}
REPO=${2:?usage: create-repo.sh <dir> <owner/name> [--public|--private]}
VISIBILITY=${3:---public}

cd "$DIR"
[[ -d .git ]] || git init -q -b main
git add -A
git commit -q -m "Initial LaTeX project" || true
gh repo create "$REPO" "$VISIBILITY" --source . --remote origin --push
