#!/usr/bin/env bash
# Scaffold a LaTeX project in <dir> for the GitHub repo <owner/name>.
# Usage: new-project.sh <dir> <owner/name>
set -euo pipefail

DIR=${1:?usage: new-project.sh <dir> <owner/name>}
REPO=${2:?usage: new-project.sh <dir> <owner/name>}

REF="$(cd "$(dirname "$0")/.." && pwd)/skills/latex-vietnamese/references"

if [[ -e $DIR && -n $(ls -A "$DIR") ]]; then
  echo "error: $DIR exists and is not empty" >&2
  exit 1
fi

mkdir -p "$DIR/chapters" "$DIR/.github/workflows"
cp "$REF/main.tex.template" "$DIR/main.tex"
cp "$REF/latex.yml" "$DIR/.github/workflows/latex.yml"
cp "$REF/gitignore" "$DIR/.gitignore"
printf '# %s\n\nPDF được build tự động bằng GitHub Actions (tab Actions → artifact `pdf`).\n' "${REPO#*/}" > "$DIR/README.md"

echo "Scaffolded $DIR"
