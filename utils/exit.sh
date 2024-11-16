#!/bin/bash

# Author: D O' Connor

# Program Description: This file contains an exit function, which can be used throughout the
# application to exit the program gracefully.

function exit_function() {
    echo "You have chosen to exit. Goodbye!"
    sleep 1
    exit 0
}