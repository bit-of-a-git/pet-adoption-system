#!/bin/bash

# Author: D O' Connor

# Program Description: This Bash script serves as a menu for the search function of the
# application. This functions on a high level, searching overall records instead of specific
# fields. Users may choose a case sensitive or case insensitive search.

source ./utils/config.sh
source ./utils/pause.sh
source ./utils/display-table.sh

function search_menu() {

    while true; do
        clear
        echo -e "${SUB_MENU_HEADER}             Search Menu              ${CLEAR}"
        echo "--------------------------------------"
        echo "1. Search all fields (case insensitive)"
        echo "2. Search all fields (case sensitive)"
        echo "3. View all records"
        echo "4. Return to main menu"
        echo "--------------------------------------"
        read -p "Select an option between 1 and 4: " -r option

        case $option in
        1)
            search_all_fields "insensitive"
            ;;
        2)
            search_all_fields "sensitive"
            ;;
        3)
            view_all_records
            ;;
        4)
            clear
            return
            ;;
        *)
            echo "Invalid option. Please try again."
            pause
            ;;
        esac
    done
    clear
}

# This function searches all fields of records, and takes an input to determine whether searches
# should be case sensitive or not.
function search_all_fields() {
    local sensitivity=$1
    clear
    echo -e "${SUB_MENU_HEADER}          Search All Fields           ${CLEAR}"
    echo "--------------------------------------"
    read -p "Please enter a search phrase: " -r search_term

    # This if loop checks that search phrase is not empty and does not contain commas
    if [[ -z "${search_term}" ]]; then
        echo -e "${ERROR}Error: search phrase cannot be empty${CLEAR}"
        pause
        return
    elif [[ $search_term =~ ,+ ]]; then
        echo -e "${ERROR}Error: search terms should not include commas${CLEAR}"
        pause
        return
    fi

    clear
    
    # Performs a case sensitive or insensitive grep, and stores the results in a variable
    if [[ $sensitivity == "insensitive" ]]; then
        search_results=$(grep -i "${search_term}" "${FILE}")
    else
        search_results=$(grep "${search_term}" "${FILE}")
    fi

    if [[ $search_results ]]; then
    echo -e "${PROMPT_TEXT}Results for search phrase '${search_term}':${CLEAR}\n"

    # This section of code checks the amount of results, and if 10 or more pipes to less.
    result_count=$(echo "${search_results}" | wc -l)
    
    if (( result_count >= 10 )); then
            echo "${search_results}" | display_table | less
        else
            echo "${search_results}" | display_table
        fi
    else
        echo -e "${ERROR}No results found.${CLEAR}"
    fi

    echo ""
    pause
}

# This function is called when the user wants to see all records prior to searching.
function view_all_records() {
    record_count=$(cat "${FILE}" | wc -l)
    if (( record_count >= 10 )); then
        cat "${FILE}" | display_table | less
    elif (( record_count >= 1 )); then
        clear
        cat "${FILE}" | display_table
        echo ""
        pause
    else
        clear
        echo -e "${ERROR}Database currently has no records.${CLEAR}"
        pause
    fi
}

search_menu
