#!/bin/bash

# Author: D O' Connor

# Program Description: This Bash script provides a submenu for the add function of the application,
# allowing users to choose whether to add details of a pet to a database or return to the main menu.

source ./utils/config.sh

function add_pet_menu() {
    while true; do
        clear
        echo -e "${SUB_MENU_HEADER}         Add a new pet record           ${CLEAR}"
        echo "----------------------------------------"
        echo "1. Enter pet details"
        echo "2. Return to main menu"
        echo "----------------------------------------"
        read -p "Select an option between 1 and 2: " -r option

        case $option in
        1)
            clear
            ./add/add.sh
            ;;
        2)
            clear
            return
            ;;
        *)
            echo -e "${ERROR}Invalid option. Please try again.${CLEAR}"
            sleep 2
            clear
            ;;
        esac
    done
}

add_pet_menu
