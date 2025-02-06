# TAM CLI Presentation

## Project Overview
TAM CLI is a command-line interface (CLI) tool designed to help developers manage modules, folders, and check for hardcoded colors in their projects efficiently and automate Git commit and push with custom or Predefined Messages. The tool offers an intuitive interface with simple prompts to guide users through various operations.

---

## Main Purpose
The primary purpose of TAM CLI is to:
- Automate the creation of modules and folders within a project.
- Provide a mechanism to detect and manage hardcoded colors.
- Offer a streamlined process for users to interact with their project structure using a simple CLI.
- Automate Git Commit and Push with Custom or Predefined Messages


---

## How TAM CLI Works

### Step 1: Running the Script
To start using TAM CLI, run the script with:
```bash
npm run tam-cli
```
Alternatively, you can run it directly using:
```bash
bash ./cli/tam-cli.sh
```

### Step 2: Navigating the Menu
Once the script runs, it displays a welcome message along with a menu of available actions:
1. **Create Module** – Prompts the user for a module name and directory.
2. **Create Folder** – Prompts the user for a folder name and directory.
3. **Check Hardcoded Colors** – Runs a scan for hardcoded colors in the project.
4. **Automate Git Commit and Push** – Automate Git Commit and Push with Custom or Predefined Messages
5. **Exit** – Closes the CLI.

Users can select an option by entering the corresponding number.

### Step 3: Performing Actions
Depending on the selected option:
- **Creating a Module:**
  - Enter module name and directory.
  - The script runs `create-modules.sh` to generate the module.

- **Creating a Folder:**
  - Enter folder name and directory.
  - The script runs `create-folder.sh` to create the folder.

- **Checking Hardcoded Colors:**
  - The `check-colors.sh` script is executed to analyze color values.

- **Automate Git Commit and Push:**
  -Commit and Push with Custom or Predefined Messages.

### Step 5: Exiting
The user can exit the script by selecting option `4` or pressing `Ctrl + C`.

---

## Features and Benefits
- **User-Friendly Interface:** Clear prompts and validation to guide the user.
- **Automation:** Reduces manual work and ensures consistency.
- **Modularity:** Easily extendable with additional features.
- **Efficiency:** Saves time when managing project structures.

---

## Command-Line Execution
For direct execution, users can pass options as arguments:
```bash
npm run tam-cli -- 1   # Directly create a module
npm run tam-cli -- 2   # Directly create a folder
```

---

## Conclusion
TAM CLI is a simple yet powerful tool that helps developers manage their project structure efficiently and ensures consistency by automating repetitive tasks. It is ideal for teams looking to streamline their workflow through a command-line interface.

