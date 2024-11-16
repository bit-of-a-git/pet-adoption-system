#!/bin/bash

# Author: D O' Connor

# Program Description: This file contains functions for fetching and validating inputs from the
# user.

source ./utils/config.sh
source ./utils/pause.sh

echo -e "${SUB_MENU_HEADER}           Enter Pet Details          ${CLEAR}"
echo "--------------------------------------"

function get_valid_input() {
    case $1 in
    1)
        get_valid_pet_name
        ;;
    2)
        get_valid_species
        ;;
    3)
        get_valid_breed
        ;;
    4)
        get_valid_age
        ;;
    5)
        get_valid_gender
        ;;
    6)
        get_valid_county
        ;;
    7)
        get_valid_contact_name
        ;;
    8)
        get_valid_mobile_number
        ;;
    9)
        get_valid_email
        ;;
    *)
        echo "${ERROR}$1 is not a valid option${CLEAR}" 1>&2
        exit 1
        ;;
    esac
}

# This function checks that pet names start and end with a letter. However, it also allows names
# with spaces or dots, such as "Mr. Whiskers."
function get_valid_pet_name() {
    while true; do
        echo -en "${PROMPT_TEXT}Enter pet name: ${CLEAR}"
        read -r pet_name
        if [[ "${pet_name}" =~ ^[A-Za-z]+[A-Za-z\'-.\ ]*[A-Za-z]+$ ]]; then
            break
        else
            echo -e "${ERROR}${pet_name} is not a valid input!${CLEAR}"
        fi
    done
}

# This function checks that the species input is present in the "valid_species" array, which is
# found within the config.sh file.
function get_valid_species() {
    while true; do
        echo -en "${PROMPT_TEXT}Enter species (e.g. dog, cat, rabbit): ${CLEAR}"
        read -r species
        species=$(echo "${species}" | awk '{print tolower($0)}')
        for valid in "${valid_species[@]}"; do
            if [[ "${species}" == "${valid}" ]]; then
                return
            fi
        done
        echo -e "${ERROR}${species} is not a valid species!${CLEAR}"
    done
}

# This function checks that the input consists of letters, apostrophes, hyphens, and spaces. Valid
# names include Jack Russell, St. Bernard, Golden Retriever.
function get_valid_breed() {
    while true; do
        echo -en "${PROMPT_TEXT}Enter breed: ${CLEAR}"
        read -r breed
        if [[ "${breed}" =~ ^[A-Za-z\'-.\ ]+$ ]]; then
            break
        else
            echo -e "${ERROR}${breed} is not a valid input!${CLEAR}"
        fi
    done
}

# This allows digits along with formats like "10 months old"
function get_valid_age() {
    while true; do
        echo -en "${PROMPT_TEXT}Enter age: ${CLEAR}"
        read -r age
        # https://stackoverflow.com/questions/5583579/question-marks-in-regular-expressions
        if [[ "${age}" =~ ^[0-9]+([[:space:]](|years?|months?|weeks?||old))*$ ]]; then
            break
        else
            echo -e "${ERROR}${age} is not a valid input! Valid ages include '10', '5 years', '11 months'.${CLEAR}"
        fi
    done
}

# This function checks whether the user has entered M or F.
function get_valid_gender() {
    while true; do
        echo -en "${PROMPT_TEXT}Enter gender (M/F): ${CLEAR}"
        read -r gender
        if [[ "${gender}" =~ ^[MmFf]$ ]]; then
            break
        else
            echo -e "${ERROR}${gender} is not a valid input! Only M or F allowed.${CLEAR}"
        fi
    done
}

# This function uses a valid_county list to ensure the user only enters valid Irish counties.
function get_valid_county() {
    while true; do
        echo -en "${PROMPT_TEXT}Enter county: ${CLEAR}"
        read -r county

        # Remove "Co." or "County" from the input if they are present
        cleaned_county=$(echo "${county}" | sed -E 's/^(Co\.|Co|County)[[:space:]]+//')

        # Convert to lowercase for comparison
        cleaned_county=$(echo "${cleaned_county}" | awk '{print tolower($0)}')

        # Check if county is in valid counties list
        for valid_county in "${valid_counties[@]}"; do
            if [[ "${cleaned_county}" == "$(echo "${valid_county}" | awk '{print tolower($0)}')" ]]; then
                # Sets county to the valid county from the list
                county=${valid_county}
                return
            fi
        done

        echo -e "${ERROR}${county} is not a valid input!${CLEAR}"
    done
}

# This function validates the name a user inputs. It allows apostrophes, hyphens, and periods.
# Valid names include John Smith, Daniel O' Brien, and Mary Keane-Smith.
function get_valid_contact_name() {
    while true; do
        echo -en "${PROMPT_TEXT}Enter contact name: ${CLEAR}"
        read -r contact_name
        if [[ "$contact_name" =~ ^[A-Za-z\'-.\ ]+[[:space:]][A-Za-z\'-.\ ]+$ ]]; then
            break
        else
            echo -e "${ERROR}${contact_name} is not a valid input!${CLEAR}"
        fi
    done
}

# This function ensures mobile numbers begin with 08 and are followed by eight numbers.
function get_valid_mobile_number() {
    while true; do
        echo -en "${PROMPT_TEXT}Enter contact mobile number: ${CLEAR}"
        read -r mobile_number
        if [[ $mobile_number =~ ^08[0-9]{8}$ ]]; then
            break
        else
            echo -e "${ERROR}${mobile_number} is not a valid input!${CLEAR}"
        fi
    done
}

# This function ensures that the email a user inputs conforms to an email regex.
function get_valid_email() {
    while true; do
        echo -en "${PROMPT_TEXT}Enter contact email address: ${CLEAR}"
        read -r contact_email
        # https://stackoverflow.com/questions/32291127/bash-regex-email
        if [[ "${contact_email}" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
            break
        else
            echo -e "${ERROR}${contact_email} is not a valid input!${CLEAR}"
        fi
    done
}
