#!/bin/bash

# Author: D O' Connor

# Program Description: This Bash script provides a submenu for the report function of the
# application, allowing users to search pet records by species, breed, county, and age range.

source ./utils/config.sh
source ./utils/pause.sh
source ./utils/display-table.sh

function pet_report_menu() {
    while true; do
        clear
        echo -e "${SUB_MENU_HEADER}             Pet Reports                ${CLEAR}"
        echo "----------------------------------------"
        echo "Search by..."
        echo "1. Species"
        echo "2. Breed"
        echo "3. County"
        echo "4. Age Range"
        echo "5. Return to main menu"
        echo "----------------------------------------"
        read -p "Select an option between 1 and 5: " -r option

        case $option in
        1)
            read -p "Enter a species to search for (e.g. dog, cat, rabbit): " -r search_term
            search_and_display "Species" 2 "${search_term}"
            ;;
        2)
            read -p "Enter a breed to search for: " -r search_term
            search_and_display "Breed" 3 "${search_term}"
            ;;
        3)
            read -p "Enter a county to search for pets in that area: " -r search_term
            search_and_display "County" 6 "${search_term}"
            ;;
        4)
            read -p "Enter age or age range to search (e.g., '10 months' or '2 years'): " -r search_term
            search_and_display "Age" 4 "${search_term}"
            ;;
        5)
            clear
            return
            ;;
        *)
            echo "Invalid option. Please try again."
            pause
            ;;
        esac
    done
}

# This function takes three inputs for field name, column, and search term, which it uses to
# search using awk.
function search_by_field() {
    local field_name="${1}"
    local field_column="${2}"
    local search_term="${3}"

    # Perform the search and store results in a variable
    search_results=$(awk -F',' -v term="${search_term}" -v col="${field_column}" 'tolower($col) ~ tolower(term)' "$FILE")
    echo "${search_results}" # Output results for use by other scripts
}

# This function takes three inputs, the results, the field name, and the search term. It counts the
# results, and if greater than 0 it tells the user the count. It also gives the user the option to
# see the matching records. 
function display_search_results() {
    local results="${1}"
    local field_name="${2}"
    local search_term="${3}"

    # Count the results
    result_count=$(echo "${results}" | wc -l)

    if [[ "${result_count}" -gt 0 ]]; then
        echo -e "\n${PROMPT_TEXT}${result_count} results found for ${field_name}: '${search_term}'.${CLEAR}"
        read -p "Would you like to see the matching records? (y/n): " -r show_results

        if [[ "${show_results}" =~ ^[Yy]$ ]]; then
            if ((result_count >= 10)); then
                echo "${results}" | display_table | less
            else
                echo "${results}" | display_table
            fi
        else
            echo "Returning to the reports menu."
        fi
    else
        echo -e "${ERROR}No results found for ${field_name}: '${search_term}'.${CLEAR}"
    fi
}

# This function is called from the reports menu and takes three inputs, which it passes to two more
# functions to search and display results respectively.
function search_and_display() {
    local field_name="${1}"
    local field_column="${2}"
    local search_term="${3}"

    # This calls search_by_field and stores the results in a variable
    search_results=$(search_by_field "${field_name}" "${field_column}" "${search_term}")

    # This passes the search results along with the field name and search term to display results,
    # if any.
    display_search_results "${search_results}" "${field_name}" "${search_term}"
    echo ""
    pause
}
