#!/bin/bash

echo "Welcome to Command Line Test"
usernames=()
passwords=()
function opt() {
    echo -e "1. Sign Up\n2. Sign In\n3. Exit"
    read -p "Choose one option: " option
}

opt

case $option in
    1)
        echo "Sign Up"
        read -p "Enter a username: " username
        csv_file="username.csv"

        if [ ! -e "$csv_file" ]; then
            echo "Username" > "$csv_file"
        fi

        if grep -Fxq "$username" "$csv_file"; then
            echo "Username already exists"
        else
            function pass_che() {
                read -p "Enter the password: " pass
                read -p "Enter the confirmation password: " con_pass
            }
            pass_che

            if [ "$pass" = "$con_pass" ]; then
                pas_file="password.csv"
                if [ ! -e "$pas_file" ]; then
                    echo "Password" > "$pas_file"
                fi
                echo "$pass" >> "$pas_file"
                echo "$username" >> "$csv_file"
                                while read line
                                do
                                        username=$(echo "$line" | cut -d ',' -f 1)
                                        usernames+=("$username")
                                done < "$csv_file"

                                #for username in "${usernames[@]}"
                        #       do
                                #       echo "$username"
                        #       done
                                while read line
                                do
                                        pass=$(echo "$line" | cut -d ',' -f 1 )
                                        passwords+=("$pass")
                                done < "$pas_file"

                echo "Sign-Up successful"
            else
                echo "Password not matching"
                pass_che
            fi
        fi
        ;;
    2)
        echo "Sign In"
        read -p "Enter the username: " username
        csv_file="username.csv"

        if [ ! -e "$csv_file" ]; then
            echo "CSV file does not exist"
        else
            if grep -Fxq "$username" "$csv_file"
                        then
                pas_file="password.csv"
                read -p "Enter the password: " password

                if [ ! -e "$pas_file" ]; then
                    echo "Password" > "$pas_file"
                fi

                if grep -Fxq "$password" "$pas_file"
                                then
                    echo "Sign in successful"
                else
                    echo "Incorrect password"
                fi
            else
                echo "Username not found"
            fi
                fi
        ;;
    3)
        echo "Exit"
        ;;
    *)
        exit
                ;;

esac