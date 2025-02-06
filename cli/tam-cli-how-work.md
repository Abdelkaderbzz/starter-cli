# TAM CLI Documentation

## Overview
TAM CLI is a command-line interface designed to help users manage modules and folders, and check hardcoded colors in their project. The CLI provides a user-friendly menu-driven interface to perform various tasks efficiently.

---

## Script Breakdown

### 1. **Sourcing Dependencies**
The script begins by sourcing the `check-colors.sh` script:
```bash
source ./cli/check-colors.sh
```
This ensures that the `check_hardcoded_colors` function is available for use.

---

### 2. **Welcome Message**
The `display_welcome` function prints an ASCII art welcome message:
```bash
display_welcome() {
    echo "Welcome to TAM CLI"
    echo " _______     /\\     __  __  "
    echo "|__   __|   /  \\   |  \\/  | "
    echo "   | |     / /\\ \\  | \\  / | "
    echo "   | |    / ____ \\ | |\\/| | "
    echo "   |_|   /_/    \\_\\|_|  |_| "
    echo ""
}
```

---

### 3. **Menu Display**
The `display_menu` function presents the user with the available options:
```bash
display_menu() {
    echo "Please choose an option:"
    echo "1) Create Module"
    echo "2) Create Folder"
    echo "3) Check Hardcoded Colors"
}
```

---

### 4. **Input Validation**
The `validate_input` function checks if user input is empty:
```bash
validate_input() {
    if [[ -z "$1" ]]; then
        echo "Input cannot be empty. Please try again."
        return 1
    fi
    return 0
}
```

---

### 5. **Executing User Choices**
The `execute_choice` function handles user selections:
```bash
execute_choice() {
    case $1 in
        1)
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
            echo "Executing Check Hardcoded Colors..."
            check_hardcoded_colors
            ;;
        4)
            ./cli/add-commit-push-changes.sh
            ;;
        5)
            echo "Exiting TAM CLI. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
}
```

---

### 6. **Command-Line Argument Handling**
If an argument is provided to the script, it will directly execute the corresponding choice:
```bash
if [[ -n "$1" ]]; then
    execute_choice "$1"
    exit 0
fi
```

---

### 7. **Main Loop**
The script continuously displays the menu until the user chooses to exit:
```bash
while true; do
    display_welcome
    display_menu
    echo "5) Exit"
    read -p "Enter your choice: " choice
    execute_choice "$choice"
    read -p "Press Enter to return to the menu..."
done
```

---

## Usage Instructions

1. **Run the script:**
   ```bash
   ./tam-cli.sh
   ```

2. **Select an option:**
   - `1` to create a module (requires module name and directory input).
   - `2` to create a folder (requires folder name and directory input).
   - `3` to check for hardcoded colors.
   - `4` to exit the CLI.

3. **Execute with a direct option:**
   ```bash
   ./tam-cli.sh 1
   ```
   This will directly execute the `Create Module` function.

---

## Dependencies
Ensure the following scripts exist and have executable permissions:
- `./cli/check-colors.sh`
- `./cli/create-modules.sh`
- `./cli/create-folder.sh`

Set executable permissions if necessary:
```bash
chmod +x tam-cli.sh cli/*.sh
```

---

## Exit Process
To exit the CLI, select option `4` from the menu or use `Ctrl + C` to terminate execution.

---

## Error Handling
- The script validates inputs and prompts the user to re-enter correct values if any input is left empty.
- Invalid menu options result in a prompt to try again.

---

## Conclusion
TAM CLI simplifies the management of modules, folders, and hardcoded color checks in a project, offering an intuitive and easy-to-use interface.

