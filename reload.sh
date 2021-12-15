#!/usr/bin/env bash

#The return page that is opened when a user completes their option

clear

figlet "NEST SCRAPER" | lolcat
echo "by Darito" | lolcat


PS3=$'\e[01;37mPlease enter your choice: \e[0m'
options=("Go Back to the Main Menu" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Go Back to the Main Menu")
            clear
	    ./reqs.sh
            ;;
        "Exit")
            clear
	    break
            ;;
    esac
done


