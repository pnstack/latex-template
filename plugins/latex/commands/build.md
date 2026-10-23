---
description: Push the LaTeX project, wait for the GitHub Actions build and download the PDF
argument-hint: [project-dir]
allowed-tools: Bash, Read, Edit
---

Build the PDF of the LaTeX project in `$ARGUMENTS` (the current directory if
empty) on GitHub Actions.

1. If there are uncommitted changes, commit them with a message describing the
   change, then `git push`. If nothing is new and HEAD is already pushed, just
   reuse the existing run.
2. Run `${CLAUDE_PLUGIN_ROOT}/scripts/build.sh <dir>` (in the background if
   your harness supports it).
3. On failure, read the printed LaTeX log, fix the `.tex` files, commit, push and
   run step 2 again. Never install or run LaTeX locally.
4. Report the PDF path (`<dir>/build/*.pdf`) and the Actions run URL.
