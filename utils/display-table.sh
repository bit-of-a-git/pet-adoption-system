#!/bin/bash

# Author: D O' Connor

# Program Description: This Bash script applies column headings to search or report results, in
# addition to formatting results correctly to align with columns.

function display_table() {

    # Display column headers
    echo "Pet Name   | Species    | Breed              | Age | Gender | County    | Contact Name    | Mobile     | Email"
    echo "---------------------------------------------------------------------------------------------------------------------------"

    # Format and print each line using printf and awk. Printf left aligns strings, and awk passes column values into printf
    awk -F, '{
        printf "%-10s | %-10s | %-18s | %-3s | %-6s | %-9s | %-15s | %-10s | %s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9
    }'
}
