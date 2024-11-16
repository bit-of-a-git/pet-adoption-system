#!/bin/bash

# Author: D O' Connor

# Program Description: This Bash script calls another script to fetch and validate details about
# pets who are being adopted. Subsequently, it displays the details entered and asks the user if they
# would like to enter the details. If they choose to enter the details, it checks whether the entry
# already exists and only adds it if not.

source ./add/get_valid_input.sh

# This function is used to display the entered details to the user for confirmation, before adding
# to the database.
function display_entered_details {
    clear
    echo -e "${SUB_MENU_HEADER}        Details Entered        ${CLEAR}"
    echo -e "${PROMPT_TEXT}Pet Name:${CLEAR}      ${pet_name}"
    echo -e "${PROMPT_TEXT}Species:${CLEAR}       ${species}"
    echo -e "${PROMPT_TEXT}Breed:${CLEAR}         ${breed}"
    echo -e "${PROMPT_TEXT}Age:${CLEAR}           ${age}"
    echo -e "${PROMPT_TEXT}Gender:${CLEAR}        ${gender}"
    echo -e "${PROMPT_TEXT}County:${CLEAR}        ${county}"
    echo -e "${PROMPT_TEXT}Contact Name:${CLEAR}  ${contact_name}"
    echo -e "${PROMPT_TEXT}Mobile Number:${CLEAR} ${mobile_number}"
    echo -e "${PROMPT_TEXT}Email:${CLEAR}         ${contact_email}\n"
}

# This function asks the user whether they would like to add the entered details to the database.
function confirm_details {
    while true; do
        read -p "Would you like to add this entry? (y/n): " -r confirmation
        case $confirmation in
        "y" | "Y")
            add_details
            return
            ;;
        "n" | "N")
            echo "Entry not added."
            pause
            return
            ;;
        *)
            echo "Please enter 'y' or 'n'."
            ;;
        esac
    done
}

# This function checks for duplicate records based on name, species, phone, and email
function add_details {
    if grep -iq "${pet_name},${species},.*${mobile_number},${contact_email}" "$FILE"; then
        echo -e "${ERROR}Error: An entry with the same pet name, species, and contact details already exists.${CLEAR}"
        pause
        clear
        return
    fi

    # The following line appends the pet record to the file as long as it is not a duplicate.
    echo "${pet_name},${species},${breed},${age},${gender},${county},${contact_name},${mobile_number},${contact_email}" >>"${FILE}"
    echo "Pet record added successfully."
    pause
    clear
}

# This loop calls the get_valid_input function, which contains a case statement with 9 options.
for i in {1..9}; do
    get_valid_input ${i}
done

display_entered_details
confirm_details
