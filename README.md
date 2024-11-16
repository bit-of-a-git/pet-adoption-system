# Pet Adoption System

## SETU Linux Shell Script Assignment - David O' Connor

## Table of Contents
- [About the project](#about-the-project)
- [Features](#features)
- [Getting started](#getting-started)
- [Folder Structure](#folder-structure)
- [Configuration](#configuration)
- [Credits](#credits)

## About the project

This Pet Adoption System app, written in Bash, allows users to manage and track pets that are available for adoption. Users may add, search, and remove records from a central database file (typically "pet-adoption-database.csv"). The system aims to provide a user-friendly menu interface and support robust input validation and error handling.

## Features

- Users may search the database and find contact details for pets they are interested in adopting.
- Reports can be generated for things like species, location, and breed.
- Records may also be removed from the database when pets have found new homes.

## Getting started

```bash
# Clone the repo
git clone https://github.com/bit-of-a-git/<replace>.git

# Navigate to the project directory
cd <replace>

# Start the main menu
./menu.sh
```

## Folder Structure

```bash
pet-adoption-system/
│
└── add/
│   ├── add.sh                # Displays entered details to user for confirmation before adding to DB
│   ├── get_valid_input.sh    # Functions for fetching and validating inputs from user
│   └── menu.sh               # Submenu for the add function of the system
└── utils/
│   ├── config.sh             # Configuration file for settings such as DB file name, valid species, etc
│   ├── display-table.sh      # Applies column names and formatting to search results 
│   ├── exit.sh               # A function to exit which may be reused throughout the application
│   ├── pause.sh              # A function to pause and allow the user to read output
│   └── welcome-screen.sh     # A welcome screen ran when the application starts
├── menu.sh                   # Main menu script
├── pet-adoption-database.csv # Database file for storing pet records
├── README.md                 # Documentation (this file)
├── remove.sh                 # Submenu which allows single or multiple records to be deleted 
├── reports.sh                # Submenu which allows reports to be generated based on column/field values
└── search.sh                 # Submenu which allows users to perform high-level searches
```

## Configuration

All configurable options are stored in utils/config.sh. These include:

```bash
FILE: # Path to and name of the pet database file.
valid_species: # Array of valid pet species (e.g., dog, cat, rabbit).
valid_counties: # An array of Irish counties used to limit user input.
```

## Credits

Former SETU student Eoin Fennessy's project was extremely helpful for getting ideas on things like how to validate input, format results for users, and provide a good experience for the end user.
- https://github.com/eoinfennessy/home-ber-log

The ASCII image of the dogs was taken from the following source:
- https://www.asciiart.eu/animals/dogs

Other resources referenced:
- https://stackoverflow.com/questions/5583579/question-marks-in-regular-expressions
- https://stackoverflow.com/questions/32291127/bash-regex-email
- https://www.shellcheck.net/wiki/SC2034