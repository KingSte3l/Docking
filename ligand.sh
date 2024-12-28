#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p ./ligand_out

# Loop through all .pdb files in the current directory
for file in ./*.pdb; do
    if [[ -f "$file" ]]; then
        echo "Processing file: $file"
        output_file="./ligand_out/$(basename "$file" .pdb).pdbqt"
        
        # Debugging message for output file
        echo "Output file: $output_file"
        
        # Run the script
        prepare_ligand4.py -l "$file" -o "$output_file"
        
        # Check if the output file was created
        if [[ -f "$output_file" ]]; then
            echo "Successfully created: $output_file"
        else
            echo "Failed to create: $output_file"
        fi
    else
        echo "File does not exist: $file"
    fi
done

