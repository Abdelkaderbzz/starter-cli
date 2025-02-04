#!/bin/bash

# Function to check for hardcoded colors
check_hardcoded_colors() {
    local file_path="$1"

    # Ensure the file is an .scss file
    if [[ "${file_path##*.}" != "scss" ]]; then
        return
    fi

    if [[ ! -f "$file_path" ]]; then
        echo "File not found: $file_path"
        return
    fi

    # Find all hex color codes in the file
    color_codes=$(grep -oE '#[0-9a-fA-F]{6}' "$file_path" | sort | uniq)

    if [[ -z "$color_codes" ]]; then
        return
    fi

    # Initialize arrays to store categorized colors
    declare -a found_colors
    declare -a not_found_colors

    for color in $color_codes; do
        # Search for the color in _colors.scss
        variable=$(grep -i "$color" src/modules/shared/assets/styles/abstracts/_colors.scss)
        if [[ -n "$variable" ]]; then
            found_colors+=("$color: $variable")
        else
            not_found_colors+=("$color")
        fi
    done

    # Display results only if there are hardcoded colors
    if [[ ${#found_colors[@]} -gt 0 || ${#not_found_colors[@]} -gt 0 ]]; then
        echo "Checking file: $file_path"  # Print the file being checked only if there are results
    fi

    if [[ ${#found_colors[@]} -gt 0 ]]; then
        echo "Colors with corresponding variables:"
        for entry in "${found_colors[@]}"; do
            echo "  $entry"
        done
    fi

    if [[ ${#not_found_colors[@]} -gt 0 ]]; then
        echo ""
        echo "Colors without corresponding variables:"
        for color in "${not_found_colors[@]}"; do
            echo "  $color"
        done
    fi
}

# Call the function with the provided file path
check_hardcoded_colors "$1"
