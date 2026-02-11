# Configuration
INPUT_DIR := assets
DPI := 300

# Output directories
PNG_DIR := $(INPUT_DIR)/eps2png
SVG_DIR := $(INPUT_DIR)/eps2svg
PDF_DIR := $(INPUT_DIR)/eps2pdf

# Find all EPS files
EPS_FILES := $(wildcard $(INPUT_DIR)/*.eps)

# Generate output file lists
PNG_FILES := $(patsubst $(INPUT_DIR)/%.eps,$(PNG_DIR)/%.png,$(EPS_FILES))
SVG_FILES := $(patsubst $(INPUT_DIR)/%.eps,$(SVG_DIR)/%.svg,$(EPS_FILES))
PDF_FILES := $(patsubst $(INPUT_DIR)/%.eps,$(PDF_DIR)/%.pdf,$(EPS_FILES))

# Default target
.PHONY: all
all: png

# Main conversion targets
.PHONY: png
png: $(PNG_FILES)

.PHONY: svg
svg: $(SVG_FILES)

.PHONY: pdf
pdf: $(PDF_FILES)

# Create output directories
$(PNG_DIR) $(SVG_DIR) $(PDF_DIR):
	@mkdir -p $@

# Conversion rules for PNG
$(PNG_DIR)/%.png: $(INPUT_DIR)/%.eps | $(PNG_DIR)
	@echo "Converting $< to $@"
	@magick -density $(DPI) $< -flatten $@

# Conversion rules for SVG
$(SVG_DIR)/%.svg: $(INPUT_DIR)/%.eps | $(SVG_DIR)
	@echo "Converting $< to $@"
	@magick $< $@

# Conversion rules for PDF
$(PDF_DIR)/%.pdf: $(INPUT_DIR)/%.eps | $(PDF_DIR)
	@echo "Converting $< to $@"
	@magick $< $@

# Precursor targets
.PHONY: kontinuertpdf
kontinuertpdf: png
	@echo "Compiling main.typ (kontinuert mode)"
	@mkdir -p output
	@typst c --font-path fonts --ignore-system-fonts main.typ output/sangbog.pdf

.PHONY: bookletpdf
bookletpdf: png
	@echo "Compiling main.typ (booklet mode)"
	@mkdir -p output
	@typst c --font-path fonts --ignore-system-fonts main.typ output/sangbog.pdf
	# add --signature=64, to change signature
	@LC_ALL=C LANG=C pdfbook2 --paper a4 -o 10 -i 10 -t 10 -b 10 output/sangbog.pdf

.PHONY: watch
watch: png
	@echo "Starting typst watch mode"
	@typst watch --font-path fonts --ignore-system-fonts main.typ

# Clean targets
.PHONY: clean
clean:
	@echo "Removing all conversion directories"
	@rm -rf $(PNG_DIR) $(SVG_DIR) $(PDF_DIR)

.PHONY: clean-png
clean-png:
	@echo "Removing $(PNG_DIR)"
	@rm -rf $(PNG_DIR)

.PHONY: clean-svg
clean-svg:
	@echo "Removing $(SVG_DIR)"
	@rm -rf $(SVG_DIR)

.PHONY: clean-pdf
clean-pdf:
	@echo "Removing $(PDF_DIR)"
	@rm -rf $(PDF_DIR)

# Help target
.PHONY: help
help:
	@echo "EPS Conversion Makefile"
	@echo ""
	@echo "Conversion targets:"
	@echo "  make png               # Convert all EPS to PNG"
	@echo "  make svg               # Convert all EPS to SVG"
	@echo "  make pdf               # Convert all EPS to PDF"
	@echo ""
	@echo "Typst compilation targets:"
	@echo "  make kontinuertpdf     # Convert to PNG, then compile main.typ"
	@echo "  make bookletpdf        # Convert to PNG, compile main.typ, then booklet processing"
	@echo "  make watch             # Convert to PNG, then start typst watch mode"
	@echo ""
	@echo "Clean targets:"
	@echo "  make clean             # Remove all conversion directories"
	@echo "  make clean-png         # Remove PNG directory only"
	@echo "  make clean-svg         # Remove SVG directory only"
	@echo "  make clean-pdf         # Remove PDF directory only"
	@echo ""
	@echo "Configuration:"
	@echo "  INPUT_DIR: $(INPUT_DIR)"
	@echo "  DPI: $(DPI)"

# Print detected files
.PHONY: list
list:
	@echo "EPS files found in $(INPUT_DIR):"
	@for file in $(EPS_FILES); do echo "  $$file"; done
	@echo ""
	@echo "Output directories:"
	@echo "  PNG: $(PNG_DIR)"
	@echo "  SVG: $(SVG_DIR)"
	@echo "  PDF: $(PDF_DIR)"