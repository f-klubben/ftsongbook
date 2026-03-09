# F-Klubbens sangbog skreven i Typst (WIP)



## Req.

- typst 0.14.2
- ImageMagick
- GhostScript (used by ImageMagick)
- Typst
- texlive-binextra (for pdfbook2)
- libpaper (because, because)
- curl + unzip (for font downloading)

```bash
sudo pacman -S typst imagemagick ghostscript texlive-binextra libpaper curl unzip
```

It might be that you have not listed A4 paper in you paper sizes (known issue on wsl). 
For this do the followin: `echo "a4" | sudo tee /etc/papersize`

### Fonts

Fonts are **not** included in the repo. They are downloaded automatically from their
official open-source releases the first time you run any compile target.

The following fonts are used:
- [Source Serif 4](https://github.com/adobe-fonts/source-serif) (Adobe)
- [Source Sans 3](https://github.com/adobe-fonts/source-sans) (Adobe)
- [Courier Prime](https://github.com/quoteunquoteapps/CourierPrime)  (quoteunquoteapps)

They are downloaded into `fonts/` (which is git-ignored) and cached via a
`fonts/.downloaded` sentinel file — so they are only fetched once.

To force a re-download:



## Building from source

Here, for Debian- and Arch-based systems

1. Fetch source code
```bash
git clone #INSERT LINK HERE
```
2. Install prerequisites
```bash
#Debian
sudo apt install typst imagemagick ghostscript 

#Arch
sudo pacman -S typst imagemagick ghostscript libpaper curl unzip
``` 
4. Build the sangbog make `kontinuertpdf` for non-booklet (continuous) format, `make bookletpdf` for booklet format. (Fonts downlaod automatically).


## Make Usage

### Basic Conversion

```bash
make png    # Convert EPS files to PNG (default, 300 DPI)
make svg    # Convert EPS files to SVG
make pdf    # Convert EPS files to PDF
```

### Typst Compilation

```bash
make kontinuertpdf    # Download fonts + convert to PNG + compile main.typ
make bookletpdf       # Download fonts + convert to PNG + compile + booklet processing
make watch            # Download fonts + convert to PNG + start typst watch mode
```

### Cleanup

```bash
make clean            # Remove all converted files and output
make clean-png        # Remove PNG files only
make clean-svg        # Remove SVG files only
make clean-pdf        # Remove PDF files only
```

### Fonts

```bash
make clean-fonts
make fonts   # or just run any compile target
```

## Adding Songs
