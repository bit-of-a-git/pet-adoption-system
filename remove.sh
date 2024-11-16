#!/bin/bash

# Author: D O' Connor

# Program Description: This Bash script allows users to delete single or multiple records as
# needed. It also displays records to the user for confirmation prior to deletion.

source ./utils/config.sh
source ./utils/pause.sh
source ./utils/display-table.sh
source ./reports.sh # To import search function

function remove_records_menu() {

    while true; do
        clear
        echo -e "${SUB_MENU_HEADER}             Remove Menu              ${CLEAR}"
        echo "--------------------------------------"
        echo "Remove by..."
        echo "1. Pet name"
        echo "2. Species"
        echo "3. Breed"
        echo "4. County"
        echo "5. Mobile number"
        echo "6. Search all fields (case sensitive)"
        echo "7. Return to main menu"
        echo "--------------------------------------"
        read -p "Select an option between 1 and 7: " -r option

        case $option in
        1)
            remove_by_field "pet name" 1
            ;;
        2)
            remove_by_field "species" 2
            ;;
        3)
            remove_by_field "breed" 3
            ;;
        4)
            remove_by_field "county" 6
            ;;
        5)
            remove_by_field "mobile number" 8
            ;;
        6)
            remove_by_all_fields
            ;;
        7)
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

# This function takes two inputs. The field name is used to prompt the user for something to search
# for, e.g. "Enter a breed to search for". The column, referring to a column of the database, is
# passed to a search function.
function remove_by_field() {
    local field_name="${1}"
    local field_column="${2}"
    read -p "Enter a ${field_name} to search for: " -r search_term

    # This calls search_by_field using the input and stores the results in a variable.
    search_results=$(search_by_field "${field_name}" "${field_column}" "${search_term}")

    # This calls the confirm_and_delete function with the search results from the previous step.
    confirm_and_delete "${search_results}" "${field_name}" "${search_term}"
}

# This function is used to search and remove records by searching all fields.
function remove_by_all_fields() {
    read -p "Enter a search phrase to search all fields: (case sensitive)" -r search_term

    # This performs a case-sensitive search across all fields, and stores the results in a variable
    search_results=$(grep "${search_term}" "${FILE}")

    # This passes in the search results to the confirm_and_delete function.
    confirm_and_delete "${search_results}" "all fields" "${search_term}"
}

# This function checks whether any results were present. If not, it informs the user, but if so it
# displays the results to the user and confirms that they wish to delete them.
function confirm_and_delete() {
    local results="${1}"
    local search_type="${2}"
    local search_term="${3}"

    # This if statement returns from the function if no results were found.
    if [[ -z "${results}" ]]; then
        echo -e "${ERROR}No results found for ${search_type} search: '${search_term}'.${CLEAR}"
        pause
        return
    fi

    # This displays the search results and confirms with the user that they wish to delete them.
    echo -e "${PROMPT_TEXT}The following records match ${search_type}: '${search_term}':${CLEAR}\n"
    echo "${results}" | display_table

    echo -e "${ERROR}\nWARNING: This will permanently delete the above records.${CLEAR}"
    read -p "Type 'yes' to confirm deletion or 'no' to cancel: " -r confirm_deletion

    if [[ "${confirm_deletion}" == "yes" ]]; then
        delete_records "${results}"
    else
        echo -e "${PROMPT_TEXT}No records were deleted.${CLEAR}"
    fi
    pause
}

# This function takes search results as a parameter, deletes them from the database, and lastly
# reports on the number of deleted records.
function delete_records() {
    local results="${1}"

    # This outputs the contents of 'results' into the variable 'line'. The second sed command with
    # regex escapes special characters so they are treated literally. The first sed command deletes
    # any line that matches the pattern within the brackets.
    echo "${results}" | while IFS= read -r line; do
        sed -i "/$(echo "${line}" | sed 's/[^^]/[&]/g; s/\^/\\^/g')/d" "${FILE}"
    done

    # This line displays the count of deleted records to the user.
    local record_count
    record_count=$(echo "${results}" | wc -l)
    echo -e "${PROMPT_TEXT}${record_count} records were successfully deleted.${CLEAR}"
}

remove_records_menu
