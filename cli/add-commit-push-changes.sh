#!/bin/bash


declare -A commit_types=(
  ["feat"]="A new feature"
  ["fix"]="A bug fix"
  ["docs"]="Documentation only changes"
  ["style"]="Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)"
  ["refactor"]="A code change that neither fixes a bug nor adds a feature"
  ["perf"]="A code change that improves performance"
  ["test"]="Adding missing tests or correcting existing tests"
  ["chore"]="Changes to the build process or auxiliary tools and libraries such as documentation generation"
)

commit_messages=(
  "feat: Implement user authentication system"
  "feat: Add dark mode toggle"
  "feat: Integrate payment gateway"
  "fix: Resolve memory leak in data processing module"
  "fix: Address cross-browser compatibility issues"
  "fix: Correct calculation error in billing system"
  "docs: Update API documentation"
  "docs: Add usage examples to README"
  "docs: Create CONTRIBUTING.md guide"
  "style: Format code according to style guide"
  "style: Remove unnecessary whitespace"
  "style: Standardize indentation across project"
  "refactor: Optimize database queries for better performance"
  "refactor: Simplify error handling logic"
  "refactor: Extract reusable components"
  "perf: Implement caching mechanism for frequently accessed data"
  "perf: Optimize image loading and rendering"
  "perf: Reduce bundle size by code splitting"
  "test: Add unit tests for user registration flow"
  "test: Implement integration tests for payment process"
  "test: Increase code coverage to 80%"
  "chore: Update dependencies to latest versions"
  "chore: Set up continuous integration pipeline"
  "chore: Configure automated code linting and formatting"
)


GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color


display_commit_types() {
  echo "Commit Types:"
  for type in "${!commit_types[@]}"; do
    printf "  ${GREEN}%s${NC}: %s\n" "$type" "${commit_types[$type]}"
  done
  echo
}


display_commit_types


commit_message=$(printf "%s\n" "${commit_messages[@]}" "Custom message" | fzf --prompt="Select a commit message: ")

if [ "$commit_message" == "Custom message" ]; then

  commit_type=$(printf "%s\n" "${!commit_types[@]}" | fzf --prompt="Select a commit type: ")
  

  read -p "Enter your commit message: " custom_message
  

  commit_message="$commit_type: $custom_message"
fi


git add .
git commit -m "$commit_message"


remotes=($(git remote))
if [ ${#remotes[@]} -gt 1 ]; then
  remote=$(printf "%s\n" "${remotes[@]}" | fzf --prompt="Select a remote: ")
else
  remote=${remotes[0]}
fi


branch=$(git symbolic-ref --short HEAD)


echo "Pushing to $remote/$branch..."
git push -u $remote $branch

if [ $? -eq 0 ]; then

  echo -e "${GREEN}Push successful!${NC}"
else

  echo -e "${RED}Push failed.${NC}"
fi

