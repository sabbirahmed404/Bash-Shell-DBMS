#!/usr/bin/bash

# Function to hash passwords
hash_password() {
    echo -n "$1" | sha256sum | awk '{print $1}'
}

echo -n "Username: "
read username
echo -n "Password: "
read -s password
echo

hashed_password=$(hash_password "$password")

# Validate the credentials
if grep -q "^$username:$hashed_password$" users.db; then
    echo "Login successful."
    export loggedInUser=$username
else
    echo "Invalid username or password."
    exit 1
fi

