#!/bin/bash

# Function to show usage
show_usage() {
    echo "Usage: npm run create-folder -- <folder-name> <directory>"
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    show_usage
    exit 1
fi

FOLDER_NAME=$1
DIRECTORY=$2
FULL_PATH="$DIRECTORY/$FOLDER_NAME"

# Create the directory
mkdir -p "$FULL_PATH"

# Create index.ts
echo "export { default } from './$FOLDER_NAME';" > "$FULL_PATH/index.ts"

# Create the component file with React import and default export
COMPONENT_CONTENT="import React from 'react';

function $FOLDER_NAME () {
  return (
    <div> $FOLDER_NAME </div>
  );
}

export default $FOLDER_NAME;"

echo "$COMPONENT_CONTENT" > "$FULL_PATH/$FOLDER_NAME.tsx"

# Create _index.scss with @forward
echo "@forward './$FOLDER_NAME';" > "$FULL_PATH/_index.scss"

# Create the scss file
touch "$FULL_PATH/$FOLDER_NAME.scss"

echo "Folder structure created successfully at $FULL_PATH"
