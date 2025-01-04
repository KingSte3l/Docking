#!/bin/bash

# Check if the correct number of arguments is provided
if [[ $# -ne 3 ]]; then
    echo "Usage: $0 receptor.pdbqt ligand_folder config.txt"
    exit 1
fi

# Assign input arguments to variables
RECEPTOR=$1
LIGAND_FOLDER=$2
CONFIG=$3

# Get the receptor name without extension
RECEPTOR_NAME=$(basename "$RECEPTOR" .pdbqt)

# Create a directory for the receptor's output
OUTPUT_DIR="${RECEPTOR_NAME}_docking_results"
mkdir -p "$OUTPUT_DIR"

# Check if Vina is installed
if ! command -v vina &> /dev/null; then
    echo "Error: AutoDock Vina is not installed or not in your PATH."
    exit 1
fi

# Perform docking for each ligand
for LIGAND in "$LIGAND_FOLDER"/*.pdbqt; do
    if [[ -f "$LIGAND" ]]; then
        LIGAND_NAME=$(basename "$LIGAND" .pdbqt)
        echo "Docking $LIGAND_NAME against $RECEPTOR_NAME..."
        
        vina --receptor "$RECEPTOR" --ligand "$LIGAND" --config "$CONFIG" \
             --out "$OUTPUT_DIR/${LIGAND_NAME}_out.pdbqt" \
             --log "$OUTPUT_DIR/${LIGAND_NAME}_log.txt"
    else
        echo "No ligand files found in $LIGAND_FOLDER."
    fi
done

echo "Docking completed. Results saved in $OUTPUT_DIR."

