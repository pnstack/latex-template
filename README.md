# Tổng hợp công thức ma trận

Sách LaTeX tổng hợp công thức ma trận (tiếng Việt), build PDF tự động bằng GitHub Actions.

## Cấu trúc

- `math/main.tex` — file gốc, include các chương `01_…` → `10_…`
- `.github/workflows/latex.yml` — build PDF bằng `xu-cheng/latex-action` (XeLaTeX)

## Build

- **Tự động**: mỗi push lên `main` / PR thay đổi `math/**` → tải PDF ở tab *Actions* → artifact `matrix-formulas`.
- **Thủ công**: *Actions → Render LaTeX to PDF → Run workflow* (có thể chọn branch, thư mục, root files).
- **Local**:

```bash
cd math && latexmk -xelatex main.tex
```
