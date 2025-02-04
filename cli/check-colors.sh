#!/bin/bash

# Function to check for hardcoded colors
check_hardcoded_colors() {
    read -p "Enter the file path to check for hardcoded colors: " file_path
    if [[ ! -f "$file_path" ]]; then
        echo "File not found. Please try again."
        return
    fi

    # Find all hex color codes in the file
    color_codes=$(grep -oE '#[0-9a-fA-F]{6}' "$file_path" | sort | uniq)

    if [[ -z "$color_codes" ]]; then
        echo "No hardcoded colors found in the file."
        return
    fi

    echo "Checking for corresponding variables in _colors.scss..."
    for color in $color_codes; do
        # Search for the color in _colors.scss
        variable=$(grep -i "$color" src/modules/shared/assets/styles/abstracts/_colors.scss)
        if [[ -n "$variable" ]]; then
            echo "Color $color found as variable: $variable"
        else
            echo "Color $color has no corresponding variable in _colors.scss."
        fi
    done
}
