#!/bin/bash

# Source the check-colors.sh script
source ./cli/check-colors.sh

# Function to display the welcome message with ASCII art
display_welcome() {
    echo "Welcome to TAM CLI"
    echo " _______     /\\     __  __  "
    echo "|__   __|   /  \\   |  \\/  | "
    echo "   | |     / /\\ \\  | \\  / | "
    echo "   | |    / ____ \\ | |\\/| | "
    echo "   |_|   /_/    \\_\\|_|  |_| "
    echo ""
}

# Function to display the menu
display_menu() {
    echo "Please choose an option:"
    echo "1) Create Module"
    echo "2) Create Folder"
    echo "3) Check Hardcoded Colors"
}

# Function to validate input
validate_input() {
    if [[ -z "$1" ]]; then
        echo "Input cannot be empty. Please try again."
        return 1
    fi
    return 0
}

# Function to execute a choice
execute_choice() {
    case $1 in
        1)
            # Logic for creating a module
            echo "Executing Create Module..."
            while true; do
                read -p "Enter module name: " module_name
                validate_input "$module_name" || continue
                read -p "Enter directory: " directory
                validate_input "$directory" || continue
                ./cli/create-modules.sh "$module_name" "$directory"
                break
            done
            ;;
        2)
            # Logic for creating a folder
            echo "Executing Create Folder..."
            while true; do
                read -p "Enter folder name: " folder_name
                validate_input "$folder_name" || continue
                read -p "Enter directory: " directory
                validate_input "$directory" || continue
                ./cli/create-folder.sh "$folder_name" "$directory"
                break
            done
            ;;
        3)
            # Logic for checking hardcoded colors
            echo "Executing Check Hardcoded Colors..."
            check_hardcoded_colors
            ;;
        4)
            echo "Exiting TAM CLI. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
}

# Check if an argument is provided
if [[ -n "$1" ]]; then
    execute_choice "$1"
    exit 0
fi

# Main loop
while true; do
    display_welcome
    display_menu
    echo "4) Exit"
    read -p "Enter your choice: " choice
    execute_choice "$choice"

    # Prompt to return to the menu
    read -p "Press Enter to return to the menu..."
done
