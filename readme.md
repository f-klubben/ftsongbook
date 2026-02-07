
typst 0.14.2

TODO:
- kapitler
- kapitel tal-headings F G H osv.
- forord
- alternate covers


## Req.

- typst >= 0.13.1
- imagemagick

```bash
sudo pacman -S typst imagemagick ghostscript
```

## Usage

### Basic Conversion
```bash
make png    # Convert EPS files to PNG (default, 300 DPI)
make svg    # Convert EPS files to SVG
make pdf    # Convert EPS files to PDF
```

### Typst Compilation
```bash
make kontinuertpdf    # Convert to PNG + compile main.typ
make bookletpdf       # Convert to PNG + compile + booklet processing (TODO)
make watch            # Convert to PNG + start typst watch mode
```

### Cleanup
```bash
make clean            # Remove all converted files
make clean-png        # Remove PNG files only
make clean-svg        # Remove SVG files only
make clean-pdf        # Remove PDF files only
```

### Other
```bash
make list    # Show all EPS files found
make help    # Show help
```

## Structure

- Input: `assets/*.eps`
- Output: `assets/eps2png/`, `assets/eps2svg/`, `assets/eps2pdf/`

## Requirements

- ImageMagick
- GgostScript (used by ImageMagick)
- Typst