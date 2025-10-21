#!/bin/bash

# Make it executable
#chmod +x convert_eps.sh

# Convert all EPS files in current directory to PNG
#./convert_eps.sh

# Specify input/output directories
#./convert_eps.sh -i /path/to/eps/files -o /path/to/output

# Convert to PDF instead
#./convert_eps.sh -f pdf

# Higher quality PNG (600 DPI)
#./convert_eps.sh -d 600

# Convert to SVG
#./convert_eps.sh -f svg

# Configuration
INPUT_DIR="."
OUTPUT_DIR="./converted"
OUTPUT_FORMAT="png"
DPI=300

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--input)
            INPUT_DIR="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -f|--format)
            OUTPUT_FORMAT="$2"
            shift 2
            ;;
        -d|--dpi)
            DPI="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  -i, --input DIR     Input directory (default: current directory)"
            echo "  -o, --output DIR    Output directory (default: ./converted)"
            echo "  -f, --format FMT    Output format: png, pdf, svg (default: png)"
            echo "  -d, --dpi DPI       DPI for raster formats (default: 300)"
            echo "  -h, --help          Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed"
    echo "Install it with: sudo apt install imagemagick (Ubuntu/Debian)"
    echo "                 brew install imagemagick (macOS)"
    exit 1
fi

# Counter for progress
total=$(find "$INPUT_DIR" -maxdepth 1 -name "*.eps" | wc -l)
current=0

if [ "$total" -eq 0 ]; then
    echo "No .eps files found in $INPUT_DIR"
    exit 0
fi

echo "Converting $total EPS files to $OUTPUT_FORMAT..."
echo "DPI: $DPI"
echo "Output directory: $OUTPUT_DIR"
echo ""

# Convert each EPS file
for file in "$INPUT_DIR"/*.eps; do
    [ -e "$file" ] || continue
    
    current=$((current + 1))
    filename=$(basename "$file" .eps)
    output_file="$OUTPUT_DIR/${filename}.$OUTPUT_FORMAT"
    
    echo "[$current/$total] Converting: $filename.eps"
    
    if [ "$OUTPUT_FORMAT" = "png" ] || [ "$OUTPUT_FORMAT" = "jpg" ]; then
        convert -density "$DPI" "$file" -flatten "$output_file"
    else
        convert "$file" "$output_file"
    fi
    
    if [ $? -eq 0 ]; then
        echo "  ✓ Created: $output_file"
    else
        echo "  ✗ Failed: $filename.eps"
    fi
done

echo ""
echo "Conversion complete: $current files processed"