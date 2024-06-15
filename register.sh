#!/usr/bin/bash

# Function to hash passwords
hash_password() {
    echo -n "$1" | sha256sum | awk '{print $1}'
}

echo -n "Enter a username: "
read username

# Check if the username already exists
if grep -q "^$username:" users.db; then
    echo "Username already exists. Please choose a different username."
    exit 1
fi

echo -n "Enter a password: "
read -s password
echo
echo -n "Confirm password: "
read -s password_confirm
echo

if [ "$password" != "$password_confirm" ]; then
    echo "Passwords do not match. Please try again."
    exit 1
fi

# Hash the password and save the credentials
hashed_password=$(hash_password "$password")
echo "$username:$hashed_password" >> users.db

echo "User registered successfully."

