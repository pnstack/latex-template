#!/usr/bin/env bash
# Wait for the GitHub Actions PDF build of the current HEAD and download the PDF into <out>.
# Usage: build.sh [project-dir] [out-dir]
set -euo pipefail

cd "${1:-.}"
OUT=${2:-build}
SHA=$(git rev-parse HEAD)

RUN=""
for _ in $(seq 1 30); do
  RUN=$(gh run list --workflow latex.yml --commit "$SHA" --limit 1 --json databaseId --jq '.[0].databaseId // empty')
  [[ -n $RUN ]] && break
  sleep 5
done
if [[ -z $RUN ]]; then
  echo "error: no 'Render LaTeX to PDF' run found for $SHA — is it pushed?" >&2
  exit 1
fi

if ! gh run watch "$RUN" --exit-status --interval 15 >/dev/null; then
  echo "error: build failed — LaTeX log:" >&2
  gh run view "$RUN" --log-failed | tail -80 >&2
  exit 1
fi

rm -rf "$OUT"
gh run download "$RUN" --name pdf --dir "$OUT"
ls "$OUT"/*.pdf
