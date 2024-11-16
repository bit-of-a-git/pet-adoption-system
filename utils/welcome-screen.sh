#!/bin/bash

# Author: D O' Connor

# Program Description: This Bash script serves as a welcome screen for the application.

# ASCII dog taken from https://www.asciiart.eu/animals/dogs - modified to wag tail
dog_logo_down=$(
    cat <<'EOF'
            /)-_-(\        /)-_-(\
             (o o)          (o o)
     .-----__/\o/            \o/\__-----.
    /  __      /              \      __  \
   /\ /  \_\ |/                \| /_/  \ /\
  /  \\     ||                  ||      \\ \
 /   //     ||                  ||      //  \
     |\     |\                  /|     /|
EOF
)

dog_logo_up=$(
    cat <<'EOF'
            /)-_-(\        /)-_-(\
             (o o)          (o o)
     .-----__/\o/            \o/\__-----.
    /  __      /              \      __  \
\__/\ /  \_\ |/                \| /_/  \ /\__/
     \\     ||                  ||      \\
     //     ||                  ||      //
     |\     |\                  /|     /|
EOF
)

header="${WELCOME_HEADER}       Welcome to the Pet Adoption System!      ${CLEAR}"
footer="${WELCOME_HEADER} Connect animals with their forever homes here! ${CLEAR}"

function welcome_screen() {
    clear
    echo -e "\n${header}\n"
    sleep 2

    # Using underscore as a dummy variable - https://www.shellcheck.net/wiki/SC2034
    # This loop causes the dog to wag its tail
    for _ in {1..4}; do
        clear
        echo -e "\n${header}\n"
        echo "${dog_logo_down}"
        sleep 0.5

        clear
        echo -e "\n${header}\n"
        echo "${dog_logo_up}"
        sleep 0.5
    done

    echo -e "\n${footer}\n"
    sleep 3

    echo -e "Press ctrl+c at any time to exit the application."
    sleep 3

    clear
}
