#! /bin/bash
#
# git-helper.sh - a script to help with common git tasks and best practices.
#
# author: Ruben Priels <ruben.priels@student.hogent.be>

#------------------------------------------------------------------------------
# Shell settings
#------------------------------------------------------------------------------
set -o errexit
set -o nounset
set -o pipefail

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
DIRECTORY="${2:-.}"
#------------------------------------------------------------------------------
# Main function
#------------------------------------------------------------------------------

# Usage: main "${@}"
#  Check command line arguments (using a case statement) and call the
#  appropriate function that implements the functionality.
main() {
    zet_directory
    local cmd="${1:-help}"

    case "$cmd" in
        check) check_basic_settings "${@}" ;;
        log) show_history ;;
        stats) stats ;;
        undo) undo_last_commit ;;
        sync) sync ;;
        help|*) usage ;;
    esac
}
#------------------------------------------------------------------------------
# Helper functions
#------------------------------------------------------------------------------
# If you notice that you are writing the same code in multiple places, don't
# hesitate to add functions to make your code more DRY!

zet_directory(){
if [ ! -d "${DIRECTORY}" ]; then
        DIRECTORY="."
fi
cd "${DIRECTORY}"
}

# Usage: is_git_repo DIR
#  Predicate that checks if the specified DIR contains a Git repository.
#  This function does not produce output, but only returns the appropriate
#  exit code.
is_git_repo() {
    if [ -d "$DIRECTORY/.git" ]; then
        return 0
    else
        return 1
    fi
}

# Usage: check_basic_settings
#  Check if the basic git settings are configured
check_basic_settings() {
    local username email pushdefault

    arg2="${2:-}"
    username=$(git config --global user.name || echo "")
    email=$(git config --global user.email || echo "")
    pushdefault=$(git config --global push.default || echo "")

    if [ -z "$username" ]; then
         boolean=ask_to_change "user.name"
         if [ "$1" -eq 0 ]; then
          ask_config_value "user.name"
         else
          echo "user.name not set. Please set it manually."
#        echo "Git username not set. Set it using 'git config --global user.name \"Your Name\"'" >&2
         fi
    fi
    if [ -z "$email" ]; then
         boolean=ask_to_change "user.email"
         if [ "$1" -eq 0 ]; then
          ask_config_value "user.email"
         else
          echo "user.email not set. Please set it manually."
#        echo "Git username not set. Set it using 'git config --global user.name \"Your Name\"'" >&2
         fi
#        echo "Git email not set. Set it using 'git config --global user.email \"you@example.com\"'" >&2
    fi
    if [ -z "$pushdefault" ]; then
         boolean=ask_to_change "push.default"
         if [ "$1" -eq 0 ]; then
          ask_config_value "push.default"
         else
          echo "push.default not set. Please set it manually."
#        echo "Git username not set. Set it using 'git config --global user.name \"Your Name\"'" >&2
         fi

#        echo "Git push.default not set. Set it using 'git config --global push.default simple'" >&2
    fi

    if [ -n "${arg2}" ]; then
        check_repo
    fi

}

# CR-02
ask_to_change() {
   read -p "${1} not set. Do you want to set it now? [Y/n]" response
   response=$(response,,)
   if "${response} == y || ${response} == yes || ${response} == "" " ; then
           return 0
   else
           return 1
   fi

}

# CR-03
ask_config_value() {
   read -p "Enter default value for ${1}" response
   if "${1} == user.name"; then
        git config --global user.name "${response}"

    fi
    if "${1} == user.email"; then
        git config --global user.email "${response}"

    fi
    if "${1} == push.default"; then
        git config --global push.default "${response}"
    fi

}



# Usage: check_repo DIR
#  Perform some checks on the specified DIR that should contain a Git
#  repository.
check_repo() {
    if ! is_git_repo "${DIRECTORY}"; then
        echo "Warning: '${DIRECTORY}' is not a Git repository." >&2
    exit 1
    fi

     # Check for required files
    local required_files=(README.md .gitignore .gitattributes)
    for file in "${required_files[@]}"; do
        if [ ! -f "${DIRECTORY}"/"${file}" ]; then
            echo "Missing '${file}'" >&2
            if "${file} == README.md"; then # CR-07
                touch "${DIRECTORY}"/"${file}"
                echo "# ${DIRECTORY} \n \n" >> "${DIRECTORY}/README.md"
                echo "This is the README for ${DIRECTORY} \n" >> "${DIRECTORY}/README.md"
                git add .
                git commit -m "README toegevoegd"
            fi
        fi
    done

    # Check if repository has a remote
    if ! git remote show >/dev/null 2>&1; then
        echo "Warning: Repository '${DIRECTORY}' has no remote." >&2
    fi

    # Check for non-executable shell scripts
    local sh_files
    sh_files=$(find "${DIRECTORY}" -type f -name "*.sh" ! -executable)
#    echo "${sh_files}"
    if [ -n "${sh_files}" ]; then
    IFS=$'\n'
    for script in $sh_files; do
        echo "Script ${script} is not executable."
        read -p "Grant execute permission to '${script}' [y/N]? " response
        if [[ "${response}" =~ ^[Yy]$ ]]; then
                echo "Execute permission granted."
                chmod +x "${script}"
                git add "${script}"
        fi
     done
        git commit -m "Make scripts executable"
     fi

    # Check for unsupported file types
    local unsupported_files
    unsupported_files=$(find "${DIRECTORY}" -type f \( -name "*.iso" -o -name "*.docx" -o -name "*.xlsx" -o -name "*.elf" \))
    if [ -n "${unsupported_files}" ]; then
    IFS=$'\n'
    for files in $unsupported_files; do
        echo "Found unsupported file type: ${files}" >&2
    done
    fi
}

# Usage: show_history [DIR]
#  Show git log in the specified DIR or in the current directory if none was
#  specified.
show_history() {
    # CR-08
    if [ -z "${2}" ]; then
    git log --pretty=format:"%s | %an | %ad" --date=format:"%Y/%m/%d"
    else
    git log -n "${2}" --pretty=format:"%s | %an | %ad" --date=format:"%Y/%m/%d"
    fi
}

# Usage: stats [DIR]
#  Show the number of commits and the number of contributors in the specified
#  DIR or in the current directory if none was specified.
stats() {

    local commit_count contributor_count

    commit_count=$(git rev-list --count HEAD)
    contributor_count=$(git shortlog -sn | wc -l)

    echo "$commit_count commits by $contributor_count contributors"
}

# Usage: undo_last_commit
#  Undo the last commit but keep local changes in the working directory.
undo_last_commit() {

    local last_commit_message
    last_commit_message=$(git log -1 --pretty=%s)
    git reset --soft HEAD~1
    echo "Undo of last commit \"$last_commit_message\" successful."
}

# Usage: sync
#  Sync the currently checked out branch in the local repository with the
#  remote repository by performing:
#
#  - git stash if there are local changes
#  - git pull --rebase
#  - git push
#  - git push all labels (tags)
#  - git stash pop if there were local changes
sync() {
    if ! is_git_repo "${DIRECTORY}"; then
        echo "Warning: '${DIRECTORY}' is not a Git repository." >&2
    exit 1
    fi

    if [ -n "$(git status --porcelain)" ]; then
        echo "Local changes detected."
        git stash &> /dev/null
        echo "Local changes stashed."
    fi

    git pull --rebase &> /dev/null || { 
    echo "Conflict during rebase. Resolve manually." >&2
    git status
    exit 1
    }
    git push &> /dev/null
    git push --tags &> /dev/null

    if git stash list &> /dev/null; then
        git stash pop &> /dev/null
        echo "Local changes unstashed."
    fi
}

# Usage: usage
#   Print usage message
usage() {
    cat << EOF
Usage: Git-helper COMMAND [ARGUMENTS]...

Commands:
    check         Check basic git user configuration and option to fill them if requested
    check DIR     Check basic git user configuration and option to fill them if requested and check DIR for deviations of standard git practices
    log [N]       Display a brief overview of the git log of the PWD
    stats         Display some brief stats about the PWD repository
    undo          Undo last commit from git working tree while preserving local changes
    sync          Sync local branch with remote
    help          Show this help message
EOF
    exit 0
}

main "${@}"

