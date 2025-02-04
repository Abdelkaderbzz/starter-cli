#!/bin/sh

# Get a list of staged files
staged_files=$(git diff --cached --name-only --diff-filter=ACM)

# Loop through each staged file and check for hardcoded colors
for file in $staged_files; do
  # Check only .scss and .css files
  if [ "${file##*.}" = "scss" ] || [ "${file##*.}" = "css" ]; then
    echo "Checking hardcoded colors in $file..."
    bash ./cli/check-colors.sh "$file"
  fi
done
