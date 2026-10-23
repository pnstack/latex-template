---
name: latex-vietnamese
description: Create LaTeX projects with full Vietnamese language support, each pushed to its own GitHub repo with the PDF built by GitHub Actions (no local TeX install). Use when user requests creating a LaTeX project, math formulas, documents, books or PDFs in Vietnamese. Triggers on keywords like "latex", "tex", "vietnamese latex", "công thức", "toán", "ma trận", "sách", "tài liệu pdf", or any LaTeX document creation task involving Vietnamese text.
---

# LaTeX Vietnamese Project Setup

LaTeX is **never compiled locally** — every project is its own GitHub repo, and
GitHub Actions builds the PDF. Only `git` and an authenticated `gh` (with the
`workflow` scope) are needed on the machine.

## Workflow

1. Scaffold: `${CLAUDE_PLUGIN_ROOT}/scripts/new-project.sh <dir> <owner/name>`
   — creates `main.tex`, `chapters/`, `.gitignore`, `README.md` and
   `.github/workflows/latex.yml`.
2. Write content: fill in `\title`, add `chapters/NN_name.tex`, `\include` them in `main.tex`.
3. Publish: `${CLAUDE_PLUGIN_ROOT}/scripts/create-repo.sh <dir> <owner/name> [--private]`
   — commits, creates the repo, pushes (this triggers the first build).
4. Get the PDF: `${CLAUDE_PLUGIN_ROOT}/scripts/build.sh <dir>` — waits for the
   run of the current `HEAD`, prints the failing LaTeX log on error, downloads
   the PDF into `<dir>/build/`.

For later edits: commit + push, then run step 4 again. If the build fails, fix
the `.tex` from the printed log and push again — don't install TeX to debug.

## Project Layout

```
main.tex                      # preamble + \include list
chapters/01_intro.tex         # content only
.github/workflows/latex.yml   # XeLaTeX build → artifact "pdf"
```

## main.tex Template

Key Vietnamese setup — see `references/main.tex.template` for full file:

```latex
\documentclass[12pt]{article}
\usepackage{fontspec}
\usepackage[vietnamese]{babel}

% TeX Gyre fonts — bundled with TeX Live, no external install
\setmainfont{TeX Gyre Termes}
\setsansfont{TeX Gyre Heros}
\setmonofont{TeX Gyre Cursor}

\usepackage{amsmath, amssymb, geometry}
\geometry{a4paper, margin=2cm}
```

Use `\documentclass{book}` or `report` with `\chapter` for long documents.

### Required Packages

| Package | Purpose |
|---------|---------|
| `fontspec` | XeLaTeX/LuaLaTeX font selection for Unicode |
| `babel` with `[vietnamese]` | Vietnamese hyphenation, diacritics (ơ, ư, ă, etc.) |
| `amsmath, amssymb` | Math typesetting |
| `geometry` | Page layout |

The CI image also ships `texlive-pictures` (TikZ), `texlive-latex-extra` and
`texlive-science`, plus Noto fonts.

### Compiler Requirement

Must use **XeLaTeX** (the workflow runs `latexmk -xelatex`) — `fontspec`
requires it. Never `pdflatex`.

### Sub-file Convention

Each sub-file is an `\include`-able fragment. **No** `\documentclass`, `\begin{document}`, or preamble:

```latex
% chapters/01_basic.tex
\section{Phép cộng}
$(A + B)_{ij} = a_{ij} + b_{ij}$

\section{Phép nhân}
$c_{ij} = \sum_{k} a_{ik} b_{kj}$
```

`main.tex` includes them without `.tex` extension:
```latex
\include{chapters/01_basic}
\include{chapters/02_advanced}
```

## CI (GitHub Actions)

`references/latex.yml` (copied by `new-project.sh`):

- Runs on push to `main`, PRs, and manual dispatch (input `root_files`)
- `xu-cheng/latex-action@v4` with `latexmk_use_xelatex: true`
- Uploads `*.pdf` as artifact `pdf`

## Checklist

- [ ] `\usepackage[vietnamese]{babel}` in preamble
- [ ] TeX Gyre or Noto fonts
- [ ] Sub-files: no preamble, content only
- [ ] `\include{chapters/name}` without `.tex` extension
- [ ] Don't commit PDFs — download them from CI with `build.sh`
