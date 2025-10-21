
typst 0.13.1

songs to add - diverse fra https://fklub.dk/sange/start (Eksaerminatornes kort)

NYE SANGE der skal TILFØJET:
- Brødsangen
- De to luciasange
- Alle Dat'er er glade for porter
- Mini Blir Bortført (Alle dat'er er meget glade for Mini)
- Hvad skal vi kode i nat

TODO:
- resten af sange
- kapitler
- kapitel tal-headings F G H osv.
- forord
- alternate covers



OG rækkefølge:

- F-Klub Sange
  - en målrettet vise
  - en meget nostalgisk vise
  - RUDIN billede
  - Introduktionsvise
  - Masser af CC
  - en kort en lang
  - Livet
  - du må få min c compiler
  - Danskernes sange glæde
  - den lilel grønne frø
  - hvem sidder foran skærmen
  - vi er ikek humanister (tågekammeret lol)
  - regnsangen
  - dat62(1/2)/80slagsang
  - ma'matik
  - Jeg er en nørd
  - Fytteturssangen
  - På Cassiopeia til FooBart
  - Fit er frit
  - Flagsangen
  - CLRS
- Lejerbålssange (lejerbålsbillede)
  - costa del sol
  - i en lille båd der gynder
  - til ungdommen
  - whiskey in the jar
  - svantes lykkelige dag
  - den røde tråd
  - Der er noget galt i Danamrk
  - Meyers vise
  - Hjemmebrænderiet
  - (samme side, calvin comic)
  - Hvalborg
  - Joanna
  - Vi har lejerbål her
  - Se venedig og dø
- Festsange (Dream big bilelde)
  - Skull bilelde - alle sømænd er glade for piger
  - Bright sdide of life
  - Der var en skikkelig bondemand (bilelde med mand og hest på samme side)
  - Himmelhunden
  - Drunken sailor (med xkcd comic)
  - McArne
  - Imagine
  - Bubbibjørn
  - Puff den magiske drage
  - Buster
  - Der er et ølrigt land
  - Drunken boand
  - boand
- Julesange
  - Søren Banjomus
  - et barn er født i bethlehem
  - Julemad og drikke - dur ej for nissen
  - Jingle bell rock
  - let it snow
  - på loftet sidder nissen
  - Santa claus is coming to town
  - Til Julebal i nisseland
- Grå sange (sex billede)
  - en mand faldt ned fra første sal
  - lille prinsesse


## Req.

- typst >= 0.13.1
- imagemagick

```bash
sudo pacman -S typst imagemagick
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

- ImageMagick (`convert` command)
- Typst (for compilation targets)