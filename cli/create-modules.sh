#!/bin/bash

# Function to show usage
show_usage() {
    echo "Usage: npm run create-modules -- <module-name> <directory>"
}

# Function to validate the module name
validate_module_name() {
    if [[ "$1" =~ [\ \-] ]]; then
        return 1
    else
        return 0
    fi
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    show_usage
    exit 1
fi

# Prompt for a valid module name if the initial one is invalid
MODULE_NAME=$1
while ! validate_module_name "$MODULE_NAME"; do
    echo "Error: Module name should not contain spaces or hyphens. Please use CamelCase or a single word."
    read -p "Please enter a valid module name: " MODULE_NAME
done

DIRECTORY=$2
FULL_PATH="$DIRECTORY/$MODULE_NAME"

# Create the main module directory
mkdir -p "$FULL_PATH"

# Create subdirectories
mkdir -p "$FULL_PATH/components"
mkdir -p "$FULL_PATH/features"
mkdir -p "$FULL_PATH/hooks"
mkdir -p "$FULL_PATH/routes"
mkdir -p "$FULL_PATH/services"
mkdir -p "$FULL_PATH/utils"

# Create _index.scss file in the root directory
ROOT_INDEX_SCSS="$FULL_PATH/_index.scss"
touch "$ROOT_INDEX_SCSS"

# Function to append @forward if not already present
append_forward() {
    local forward_statement="$1"
    if ! grep -qF "$forward_statement" "$ROOT_INDEX_SCSS"; then
        echo "$forward_statement" >> "$ROOT_INDEX_SCSS"
    fi
}

# Create _index.scss file in the features directory
INDEX_SCSS_CONTENT="@forward './_${MODULE_NAME}';"
echo "$INDEX_SCSS_CONTENT" > "$FULL_PATH/features/_index.scss"

# Append to root _index.scss
append_forward "@forward './features/_${MODULE_NAME}';"

# Add a new file in the features directory with the module name
FEATURE_FILE_CONTENT="import React from 'react';

function ${MODULE_NAME}() {
  return (
    <div>Feature: ${MODULE_NAME}</div>
  );
}

export default ${MODULE_NAME};"

echo "$FEATURE_FILE_CONTENT" > "$FULL_PATH/features/${MODULE_NAME}.tsx"

# Create a SCSS file for the feature
SCSS_FILE_CONTENT=".${MODULE_NAME} {
  // Add your styles here
}"

FEATURE_SCSS_FILE="$FULL_PATH/features/_${MODULE_NAME}.scss"
echo "$SCSS_FILE_CONTENT" > "$FEATURE_SCSS_FILE"

# Append to root _index.scss
append_forward "@forward './features/_${MODULE_NAME}';"

# Create index.tsx in the features directory to handle imports
INDEX_FILE_CONTENT="export { default } from './${MODULE_NAME}';"
echo "$INDEX_FILE_CONTENT" > "$FULL_PATH/features/index.tsx"

# Create the API file in the services directory
API_FILE_CONTENT="import { api } from '@src/modules/shared/services/api';

export const ${MODULE_NAME}Api = api.injectEndpoints({
  endpoints: (build) => ({
    Get${MODULE_NAME}: build.query<any, any>({
      query: (params) => ({
        url: 'api/$(echo "$MODULE_NAME" | tr '[:upper:]' '[:lower:]')',
        params,
      }),
    }),
  }),
});

export const { useGet${MODULE_NAME}Query } = ${MODULE_NAME}Api;
"

echo "$API_FILE_CONTENT" > "$FULL_PATH/services/${MODULE_NAME}Api.ts"

# Create index.scss in the components directory
COMPONENTS_INDEX_SCSS="$FULL_PATH/components/index.scss"
touch "$COMPONENTS_INDEX_SCSS"

# Append to root _index.scss for components
append_forward "@forward './components/index';"

# Prompt for additional automation
read -p "Do you want more automated data? (1 for Yes, 0 for No): " AUTOMATE

if [ "$AUTOMATE" -eq 1 ]; then
    echo "Enter component names. Press ESC to finish."
    COMPONENT_NAMES=()
    while true; do
        read -p "Component Name: " COMPONENT_NAME
        if [ -z "$COMPONENT_NAME" ]; then
            break
        fi
        # Capitalize the first letter of the component name
        COMPONENT_NAME="$(tr '[:lower:]' '[:upper:]' <<< "${COMPONENT_NAME:0:1}")${COMPONENT_NAME:1}"
        COMPONENT_NAMES+=("$COMPONENT_NAME")
    done

    for COMPONENT in "${COMPONENT_NAMES[@]}"; do
        # Create the folder directly using the input name
        ./cli/create-folder.sh "$COMPONENT" "$FULL_PATH/components"
        # Append to components index.scss
        echo "@forward './$COMPONENT/$COMPONENT';" >> "$COMPONENTS_INDEX_SCSS"
    done
fi

echo "Module structure created successfully at $FULL_PATH"
