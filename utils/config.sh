#!/bin/bash

# Author: D O' Connor

# Program Description: This file contains central configurations or environment variables.

# This stores the name of the pet adoption database.
FILE="pet-adoption-database.csv"

# The below variable can be added to or subtracted from to allow users to add only approved pet species.
valid_species=("dog" "cat" "rabbit" "guinea pig")

# The below variable is used to validate locations that users submit.
valid_counties=("Antrim" "Armagh" "Carlow" "Cavan" "Clare" "Cork" "Derry" "Donegal" "Down"
    "Dublin" "Fermanagh" "Galway" "Kerry" "Kildare" "Kilkenny" "Laois" "Leitrim"
    "Limerick" "Longford" "Louth" "Mayo" "Meath" "Monaghan" "Offaly" "Roscommon"
    "Sligo" "Tipperary" "Tyrone" "Waterford" "Westmeath" "Wexford" "Wicklow")

# Colour constants for use across the application.
CLEAR='\033[00m'
ERROR='\033[01;31m'
PROMPT_TEXT='\033[01;32m'
WELCOME_HEADER='\033[44m'
MAIN_MENU_HEADER='\033[42m'
SUB_MENU_HEADER='\033[46m'
