---
description: Create a new LaTeX project as its own GitHub repo and build the PDF on GitHub Actions
argument-hint: <repo-name> <topic / description>
allowed-tools: Bash, Read, Write, Edit
---

Create a new LaTeX project: $ARGUMENTS

Follow the `latex-vietnamese` skill. Steps:

1. Parse the repo name (first word) and the topic (rest). If the repo has no
   `owner/` prefix, use the owner of the current repo's `origin` remote, else
   the authenticated `gh` user. Create the project in `./<repo-name>` unless the
   user gave a path. Default to a public repo unless the user asked for private.
2. Check `gh auth status` shows the `workflow` scope; if not, tell the user to
   run `gh auth refresh -h github.com -s workflow` and stop.
3. Run `${CLAUDE_PLUGIN_ROOT}/scripts/new-project.sh <dir> <owner/name>`.
4. Write the document: set `\title`, write the chapters in `chapters/`, and
   `\include` them in `main.tex`. Write Vietnamese with full diacritics unless
   the topic asks for another language.
5. Run `${CLAUDE_PLUGIN_ROOT}/scripts/create-repo.sh <dir> <owner/name> [--private]`.
6. Run `${CLAUDE_PLUGIN_ROOT}/scripts/build.sh <dir>` (in the background if
   your harness supports it — the build takes a few minutes). If it fails, fix
   the `.tex` from the printed log, commit, push and run it again.
7. Report the repo URL, the Actions run URL and the local PDF path.

Never install or run LaTeX locally.
