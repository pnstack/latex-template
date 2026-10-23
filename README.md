# latex-template

Template repo để viết tài liệu LaTeX và render PDF tự động bằng GitHub Actions (XeLaTeX, hỗ trợ tiếng Việt).

## Dùng template

1. Bấm **Use this template** để tạo repo mới.
2. Viết tài liệu trong `example/` (hoặc đổi tên thư mục và sửa `example` trong [`.github/workflows/latex.yml`](.github/workflows/latex.yml)).
3. Push lên `main` hoặc mở PR → tải PDF ở tab **Actions** → artifact `pdf`.

`example/` chứa một tài liệu mẫu (tổng hợp công thức ma trận) để kiểm thử workflow — thay bằng nội dung của bạn.

## Workflow

[`latex.yml`](.github/workflows/latex.yml) dùng [`xu-cheng/latex-action`](https://github.com/xu-cheng/latex-action):

- **Tự động**: push lên `main` / PR thay đổi `example/**`.
- **Thủ công**: *Actions → Render LaTeX to PDF → Run workflow*, với các input:

| Input               | Mặc định   | Ý nghĩa                                         |
| ------------------- | ---------- | ----------------------------------------------- |
| `branch`            | (default)  | Branch cần build                                |
| `working_directory` | `example`  | Thư mục chứa file `.tex`                        |
| `root_files`        | `main.tex` | Các file gốc, phân tách bằng dấu phẩy/xuống dòng |
| `artifact_name`     | `pdf`      | Tên artifact upload                             |

## Build local

```bash
cd example && latexmk -xelatex main.tex
```
