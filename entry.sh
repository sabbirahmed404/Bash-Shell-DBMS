#!/usr/bin/bash

### Entry point for DBMS

clear
. ./helpers.sh
PS3="Please enter a choice: "
connectDbName=""

# Function to display the welcome message
show_welcome_message() {
    echo "  ____            _       ____  ____  __  __ ____  
 | __ )  __ _ ___| |__   |  _ \| __ )|  \/  / ___| 
 |  _ \ / _  / __| '_ \  | | | |  _ \| |\/| \___ \ 
 | |_) | (_| \__ \ | | | | |_| | |_) | |  | |___) |
 |____/ \__,_|___/_| |_| |____/|____/|_|  |_|____/ "
    echo
}

# Function to handle the initial menu
initial_menu() {
    options=("Register" "Login" "Exit")
    select choice in "${options[@]}"
    do
        case $REPLY in
            1) . ./register.sh;;
            2) . ./login.sh
               if [ $? -eq 0 ]; then
                   break
               fi;;
            3) echo "Bye"
               exit;;
            *) echo "Please enter a valid option";;
        esac    
    done
}

# Function to handle the main menu after login
main_menu() {
    echo "Welcome $loggedInUser"

    options=("Create Database" "List Databases" "Connect to Database" "Drop Database" "Exit")
    select choice in "${options[@]}"
    do
        case $REPLY in
            1) . ./createdb.sh;;
            2) . ./listdbs.sh;;
            3) . ./connect.sh
               printMainMenu;;
            4) . ./dropdb.sh;;
            5) echo "Bye"
               exit;;
            *) echo "Please enter a valid option";;
        esac    
    done
}

# Main script execution
show_welcome_message
initial_menu
main_menu
