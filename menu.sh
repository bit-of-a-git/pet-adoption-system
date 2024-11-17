#!/bin/bash

# Author: D O' Connor

# Program Description: This Bash script is the menu of a system which automates the process of
# tracking and managing pet adoption records, including adding new pet details, searching for pets
# by aspects such as and species/breed, removing records, and generating reports. This menu asks
# users to choose a functionality and subsequently calls the associated script.

source ./utils/config.sh
source ./utils/welcome-screen.sh
source ./utils/exit.sh
source ./reports.sh

function check_file_exists() {
    if [[ ! -f "$FILE" ]]; then
        echo -e "${ERROR}Database file '${FILE}' does not exist.${CLEAR}"
        read -p "Would you like to create it now? (y/n): " -r response
        if [[ "${response}" =~ ^[Yy]$ ]]; then
            touch "${FILE}"
            clear
            echo -e "${PROMPT_TEXT}File '${FILE}' has been created.${CLEAR}"
            pause
            clear
        else
            echo -e "${ERROR}Cannot proceed without the database file. Exiting.${CLEAR}"
            exit 1
        fi
    fi
}

function main_menu() {

    while true; do
        echo -e "${MAIN_MENU_HEADER}      Pet Adoption System Menu        ${CLEAR}"
        echo "--------------------------------------"
        echo "1. Add a new pet record"
        echo "2. Search for pet records"
        echo "3. Remove pet record(s)"
        echo "4. Generate reports"
        echo "5. Exit"
        echo "--------------------------------------"
        read -p "Select an option between 1 and 5: " -r option

        case $option in
        1)
            ./add/menu.sh
            ;;
        2)
            ./search.sh
            ;;
        3)
            ./remove.sh
            ;;
        4)
            pet_report_menu
            ;;
        5)
            exit_function
            ;;
        *)
            echo -e "${ERROR}Invalid option. Please try again.${CLEAR}"
            sleep 1
            clear
            ;;
        esac
    done
}

welcome_screen
check_file_exists
main_menu
