# Configuration
INPUT_DIR := assets
DPI := 300
IM_CMD := $(shell command -v magick || command -v convert)

# Font sources (downloaded on demand, not stored in repo)
FONTS_DIR := fonts
SOURCE_SERIF_URL  := https://github.com/adobe-fonts/source-serif/releases/download/4.005R/source-serif-4.005_Desktop.zip
SOURCE_SANS_URL   := https://github.com/adobe-fonts/source-sans/releases/download/3.052R/OTF-source-sans-3.052R.zip
COURIER_PRIME_URL := https://quoteunquoteapps.com/courierprime/downloads/courier-prime.zip

# Output directories
PNG_DIR := $(INPUT_DIR)/eps2png
SVG_DIR := $(INPUT_DIR)/eps2svg
PDF_DIR := $(INPUT_DIR)/eps2pdf
OUTPUT_DIR := output

# Find all EPS files
EPS_FILES := $(wildcard $(INPUT_DIR)/*.eps)

# Generate output file lists
PNG_FILES := $(patsubst $(INPUT_DIR)/%.eps,$(PNG_DIR)/%.png,$(EPS_FILES))
SVG_FILES := $(patsubst $(INPUT_DIR)/%.eps,$(SVG_DIR)/%.svg,$(EPS_FILES))
PDF_FILES := $(patsubst $(INPUT_DIR)/%.eps,$(PDF_DIR)/%.pdf,$(EPS_FILES))

# Default target
.PHONY: all
all: png

# ================
# FONT DOWNLOADING
# ================

.PHONY: fonts
fonts: $(FONTS_DIR)/.downloaded

$(FONTS_DIR)/.downloaded:
	@echo "Downloading fonts..."
	@mkdir -p $(FONTS_DIR)
	@echo "  -> Source Serif 4"
	@curl -L --fail "$(SOURCE_SERIF_URL)" -o /tmp/source-serif.zip
	@unzip -q -o /tmp/source-serif.zip "*/OTF/*.otf" -d /tmp/source-serif-extracted
	@find /tmp/source-serif-extracted -name "*.otf" -exec cp {} $(FONTS_DIR)/ \;
	@rm -rf /tmp/source-serif.zip /tmp/source-serif-extracted
	@echo "  -> Source Sans 3"
	@curl -L --fail "$(SOURCE_SANS_URL)" -o /tmp/source-sans.zip
	@unzip -q -o /tmp/source-sans.zip "*.otf" -d /tmp/source-sans-extracted
	@find /tmp/source-sans-extracted -name "*.otf" -exec cp {} $(FONTS_DIR)/ \;
	@rm -rf /tmp/source-sans.zip /tmp/source-sans-extracted
	@echo "  -> Courier Prime"
	@curl -L --fail "$(COURIER_PRIME_URL)" -o /tmp/courier-prime.zip
	@unzip -q -o /tmp/courier-prime.zip "*.ttf" -d /tmp/courier-prime-extracted
	@find /tmp/courier-prime-extracted -name "*.ttf" -exec cp {} $(FONTS_DIR)/ \;
	@rm -rf /tmp/courier-prime.zip /tmp/courier-prime-extracted
	@touch $(FONTS_DIR)/.downloaded
	@echo "Fonts ready."

# ====================== 
# IMAGE CONVERSION RULES 
# ====================== 

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
	@$(IM_CMD) -density $(DPI) $< -flatten $@

# Conversion rules for SVG
$(SVG_DIR)/%.svg: $(INPUT_DIR)/%.eps | $(SVG_DIR)
	@echo "Converting $< to $@"
	@$(IM_CMD) $< $@

# Conversion rules for PDF
$(PDF_DIR)/%.pdf: $(INPUT_DIR)/%.eps | $(PDF_DIR)
	@echo "Converting $< to $@"
	@$(IM_CMD) $< $@

# =====================
# TYPST COMPILE TARGETS 
# =====================

.PHONY: kontinuertpdf
kontinuertpdf: fonts png
	@echo "Compiling main.typ (kontinuert mode)"
	@mkdir -p $(OUTPUT_DIR)
	@typst c --font-path $(FONTS_DIR) --ignore-system-fonts main.typ $(OUTPUT_DIR)/sangbog.pdf

.PHONY: bookletpdf
bookletpdf: kontinuertpdf
	@echo "Compiling main.typ (booklet mode)"
	@echo "If running locally"
	@python3 -m pip install --user --quiet pypdf
	@python3 utils/generate_booklet.py $(OUTPUT_DIR)/sangbog.pdf $(OUTPUT_DIR)/sangbog-booklet.pdf

.PHONY: watch
watch: fonts png
	@echo "Starting typst watch mode"
		@typst watch --font-path $(FONTS_DIR) --ignore-system-fonts main.typ

# ======= 
# CLEANUP 
# ======= 

.PHONY: clean
clean:
	@echo "Removing all conversion directories and output"
	@rm -rf $(PNG_DIR) $(SVG_DIR) $(PDF_DIR) $(OUTPUT_DIR)

.PHONY: clean-all
clean-all: 
	@echo "Removing all conversion directories, fonts and output"
	@rm -rf $(PNG_DIR) $(SVG_DIR) $(PDF_DIR) $(OUTPUT_DIR) ${FONTS_DIR}


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

.PHONY: clean-output
clean-output:
	@echo "Removing $(OUTPUT_DIR)"
	@rm -rf $(OUTPUT_DIR)

.PHONY: clean-fonts
clean-fonts:
	@echo "Removing fonts directory"
	@rm -rf $(FONTS_DIR)
