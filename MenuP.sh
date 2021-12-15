#!/usr/bin/env bash


# Written By Acon1tum 2021 as a BASH exercise - Original Menu Unknown and Butchered.

# IMPORTANT - You will need to install lolcat or remove it from the script.  
# This can be installed with     apt-get install lolcay -y 




# Setting up your functions

function option1 { 
clear
echo "Show all tweets from a users timeline" | lolcat
	echo "Before we start Please name the file your results will be saved to"
	read -p "Filename: " filename1
		echo $filename1
	echo "Choose a User you want to Search"
	read -p "User: " user
		echo $user
	twint -u $user -o $filename1.txt
	echo "Press Enter when you've finished" | lolcat
	read -p " " dontcare
./reload.sh
}

function option2 { 
clear
echo "Show all tweets containing a specific word" | lolcat
	echo "Before we start Please name the file your results will be saved to"
	read -p "Filename: " filename2
		echo $filename2
	echo "Choose a word you want to search for"
	read -p "Keyword: " keyword
		echo $keyword
	twint -s $keyword -o $filename2.txt
	echo "Press Enter when you've finished" | lolcat
	read -p " " dontcare
./reload.sh
}

function option3 { 
clear
echo "Show all tweets containing a specific word, from a specific date & time" | lolcat
	echo "Before we start Please name the file your results will be saved to"
	read -p "Filename: " filename3
		echo $filename3
	echo "Choose a word you want to search for"
	read -p "Keyword: " keyword3
		echo $keyword3
	echo "Choose the date you would like to search from (e.g. 2021-12-14)"
	read -p "Date: " date3
		echo $date3
	echo "Choose the time you would like to search from (e.g. 6:50 remember it is EST so -5 hours if GMT)"
	read -p "Time: " time3
		echo $time3
	twint -s $keyword3 --since "$date3 $time3:00" -o $filename3.txt
	echo "Press Enter when you've finished" | lolcat
	read -p " " dontcare
./reload.sh
}

function option4 { 
clear
echo "Show all tweets from a users timeline, containing a specific word" | lolcat
	echo "Before we start Please name the file your results will be saved to"
	read -p "Filename: " filename4
		echo $filename4
	echo "Choose a User you want to Search"
	read -p "User: " user4
		echo $user4
	echo "Choose a word you want to search for"
	read -p "Keyword: " keyword4
		echo $keyword4
	twint -u $user4 -s $keyword4 -o $filename4.txt
	echo "Press Enter when you've finished" | lolcat
	read -p " " dontcare
./reload.sh	
}

function option5 { 
clear
echo "Show all tweets from verified users, containing a specific word" | lolcat
	echo "Before we start Please name the file your results will be saved to"
	read -p "Filename: " filename5
		echo $filename5
	echo "Choose a word you want to search for"
	read -p "Keyword: " keyword
		echo $keyword5
	twint -s $keyword5 --verified -o $filename5.txt
	echo "Press Enter when you've finished" | lolcat
	read -p " " dontcare
./reload.sh
}

function option6 { 
clear
echo "Scrape Tweets from a defined radius(km) around a location" | lolcat
	echo "Before we start Please name the file your results will be saved to"
	read -p "Filename: " filename6
		echo $filename6
	echo "Please input the co-ordinates of the area you want to scrape (e.g. 53.48,2.24)"
	read -p "Co-ordinates: " cord6
		echo "($cord6)"
	echo "Please input the radius from this point you'd like to search (e.g. 1km)"
	read -p "Radius: " rad
		echo "Radius: $rad"
	twint -g="$cord6,$rad" -o $filename6.txt
	echo "Press Enter when you've finished" | lolcat
	read -p " " dontcare
./reload.sh	
}

function option7 { 
clear
echo "Search a Users tweets for possible Phone Numbers or Email Addresses" | lolcat
	echo "Before we start Please name the file your results will be saved to"
	read -p "Filename: " filename7
		echo $filename7
	echo "Choose a User you want to Search"
	read -p "User: " user7
		echo $user7
	twint -u $user7 --email --phone -o $filename7.txt
	echo "Press Enter when you've finished" | lolcat
	read -p " " dontcare
./reload.sh		
}

function option8 { 
echo "To search for current competitions Please enter todays date (e.g. 2021-12-15)" | lolcat
	read -p "Year: " year8
	read -p "Month: " month8
	read -p "Day: " day8
	twint -s "enter competition" --since $year8-$month8-$day8 --popular-tweets -o competitions.txt
	echo "Results have been outputted to competitions.txt" | lolcat
	echo "Press Enter when you've finished" | lolcat
	read -p " " dontcare
./reload.sh
}

function option9 { 
clear
echo -e "\e[31mQuitting...\e[0m"
echo
sleep 2
clear
exit 1
}
clear


# Setting up title, change however you like it

echo "Welcome to" | lolcat
figlet "NEST SCRAPER" | lolcat
echo "by Darito" | lolcat
echo
echo



#   Arguments   : list of options, maximum of 256
#                 "opt1" "opt2" ...


#   Return value: selected index (0 for opt1, 1 for opt2 ...)
function select_option {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}


# Telling user what buttons to use to operate the menu - using escape characters 
echo -e "Use \e[91mUP\e[0m and \e[91mDOWN\e[0m arrows and \e[91mENTER\e[0m to confirm:"
echo

# Setting up menu items, change these as you wish
options=("1.Show all tweets from a users timeline" "2.Show all tweets containing a specific word" "3.Show all tweets containing a specific word, from a specific date & time" "4.Show all tweets from a users timeline, containing a specific word" "5.Show all tweets from verified users, containing a specific word" "6.Search tweets from a defined radius around specific coordinates" "7.Search a users tweets that contain phone numbers or emails" "8.Giveaway/competition search " "Exit")

select_option "${options[@]}"
choice=$?

echo "Choosen index = $choice"
echo "        value = ${options[$choice]}"


# Checking choice and firing the function off

if [[ $choice == 0 ]];then
option1

elif [[ $choice == 1 ]];then
option2

elif [[ $choice == 2 ]];then
option3

elif [[ $choice == 3 ]];then
option4

elif [[ $choice == 4 ]];then
option5

elif [[ $choice == 5 ]];then
option6

elif [[ $choice == 6 ]];then
option7

elif [[ $choice == 7 ]];then
option8

elif [[ $choice == 8 ]];then
option9




fi