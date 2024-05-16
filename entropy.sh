#!/bin/bash

###### GLOBALS ######
# Initialize case_insensitive flag
case_insensitive=false
remove_periods=false

# Initialize total character count
total_chars=0
total_alpha_chars=0
total_numeric_chars=0

# Set global variable with the value of 81
max_hashes=81


###### FUNCTIONS ######
# Function to print the y-axis labels
print_percentages() {
#    printf " %1s \e[4m|%0s" "%" "0"
    printf " \e[4m%1s |%0s" "%" "0"
    for ((i = 5; i <= 100; i += 5)); do
        printf " %3d" "$i"
    done
    echo
}

# Function to print the y-axis line
print_y_line() {
    printf "%2s |" " "
    for ((i = 0; i <= 80; i++)); do
        printf "-"
    done
    echo
}

# Function to calculate entropy
calculate_entropy() {
    local text="$1"
    local len="${#text}"
    declare -A frequencies

    # Count frequencies of each character
    for (( i = 0; i < len; i++ )); do
        char="${text:i:1}"
        (( frequencies[$char]++ ))
    done

    # Calculate entropy
    entropy=0
    for char in "${!frequencies[@]}"; do
        frequency=${frequencies[$char]}
        probability=$(bc -l <<< "scale=10; $frequency / $len")
        entropy=$(bc -l <<< "$entropy - ($probability * l($probability))")
    done

    echo "scale=4; $entropy / l(2)" | bc -l
}

# Function to determine the number of hashes based on the percentage
get_hashes() {
    local percentage="$1"
    case $percentage in
        0) echo $(seq -s "#" 1 | tr -d '[:digit:]') ;;
        1) echo $(seq -s "#" 2 | tr -d '[:digit:]') ;;
        2) echo $(seq -s "#" 3 | tr -d '[:digit:]') ;;
        3) echo $(seq -s "#" 4 | tr -d '[:digit:]') ;;
        4) echo $(seq -s "#" 5 | tr -d '[:digit:]') ;;
        5|6) echo $(seq -s "#" 6 | tr -d '[:digit:]') ;;
        7) echo $(seq -s "#" 7 | tr -d '[:digit:]') ;;
        8) echo $(seq -s "#" 8 | tr -d '[:digit:]') ;;
        9) echo $(seq -s "#" 9 | tr -d '[:digit:]') ;;
        10|11) echo $(seq -s "#" 10 | tr -d '[:digit:]') ;;
        12) echo $(seq -s "#" 11 | tr -d '[:digit:]') ;;
        13) echo $(seq -s "#" 12 | tr -d '[:digit:]') ;;
        14) echo $(seq -s "#" 13 | tr -d '[:digit:]') ;;
        15|16) echo $(seq -s "#" 14 | tr -d '[:digit:]') ;;
        17) echo $(seq -s "#" 15 | tr -d '[:digit:]') ;;
        18) echo $(seq -s "#" 16 | tr -d '[:digit:]') ;;
        19) echo $(seq -s "#" 17 | tr -d '[:digit:]') ;;
        20) echo $(seq -s "#" 18 | tr -d '[:digit:]') ;;
        21|22) echo $(seq -s "#" 19 | tr -d '[:digit:]') ;;
        23) echo $(seq -s "#" 20 | tr -d '[:digit:]') ;;
        24) echo $(seq -s "#" 21 | tr -d '[:digit:]') ;;
        25) echo $(seq -s "#" 22 | tr -d '[:digit:]') ;;
        26|27) echo $(seq -s "#" 23 | tr -d '[:digit:]') ;;
        28) echo $(seq -s "#" 24 | tr -d '[:digit:]') ;;
        29) echo $(seq -s "#" 25 | tr -d '[:digit:]') ;;
        30) echo $(seq -s "#" 26 | tr -d '[:digit:]') ;;
        31|32) echo $(seq -s "#" 27 | tr -d '[:digit:]') ;;
        33) echo $(seq -s "#" 28 | tr -d '[:digit:]') ;;
        34) echo $(seq -s "#" 29 | tr -d '[:digit:]') ;;
        35) echo $(seq -s "#" 30 | tr -d '[:digit:]') ;;
        36|37) echo $(seq -s "#" 31 | tr -d '[:digit:]') ;;
        38) echo $(seq -s "#" 32 | tr -d '[:digit:]') ;;
        39) echo $(seq -s "#" 33 | tr -d '[:digit:]') ;;
        40) echo $(seq -s "#" 34 | tr -d '[:digit:]') ;;
        41) echo $(seq -s "#" 35 | tr -d '[:digit:]') ;;
        42|43) echo $(seq -s "#" 36 | tr -d '[:digit:]') ;;
        44) echo $(seq -s "#" 37 | tr -d '[:digit:]') ;;
        45) echo $(seq -s "#" 38 | tr -d '[:digit:]') ;;
        46) echo $(seq -s "#" 39 | tr -d '[:digit:]') ;;
        47|48) echo $(seq -s "#" 40 | tr -d '[:digit:]') ;;
        49) echo $(seq -s "#" 41 | tr -d '[:digit:]') ;;
        50) echo $(seq -s "#" 42 | tr -d '[:digit:]') ;;
        51) echo $(seq -s "#" 43 | tr -d '[:digit:]') ;;
        52|53) echo $(seq -s "#" 44 | tr -d '[:digit:]') ;;
        54) echo $(seq -s "#" 45 | tr -d '[:digit:]') ;;
        55) echo $(seq -s "#" 46 | tr -d '[:digit:]') ;;
        56) echo $(seq -s "#" 47 | tr -d '[:digit:]') ;;
        57|58) echo $(seq -s "#" 48 | tr -d '[:digit:]') ;;
        59) echo $(seq -s "#" 49 | tr -d '[:digit:]') ;;
        60) echo $(seq -s "#" 50 | tr -d '[:digit:]') ;;
        61) echo $(seq -s "#" 51 | tr -d '[:digit:]') ;;
        62) echo $(seq -s "#" 52 | tr -d '[:digit:]') ;;
        63|64) echo $(seq -s "#" 53 | tr -d '[:digit:]') ;;
        65) echo $(seq -s "#" 54 | tr -d '[:digit:]') ;;
        66) echo $(seq -s "#" 55 | tr -d '[:digit:]') ;;
        67) echo $(seq -s "#" 56 | tr -d '[:digit:]') ;;
        68|69) echo $(seq -s "#" 57 | tr -d '[:digit:]') ;;
        70) echo $(seq -s "#" 58 | tr -d '[:digit:]') ;;
        71) echo $(seq -s "#" 59 | tr -d '[:digit:]') ;;
        72) echo $(seq -s "#" 60 | tr -d '[:digit:]') ;;
        73|74) echo $(seq -s "#" 61 | tr -d '[:digit:]') ;;
        75) echo $(seq -s "#" 62 | tr -d '[:digit:]') ;;
        76) echo $(seq -s "#" 63 | tr -d '[:digit:]') ;;
        77) echo $(seq -s "#" 64 | tr -d '[:digit:]') ;;
        78|79) echo $(seq -s "#" 65 | tr -d '[:digit:]') ;;
        80) echo $(seq -s "#" 66 | tr -d '[:digit:]') ;;
        81) echo $(seq -s "#" 67 | tr -d '[:digit:]') ;;
        82) echo $(seq -s "#" 68 | tr -d '[:digit:]') ;;
        83) echo $(seq -s "#" 69 | tr -d '[:digit:]') ;;
        84|85) echo $(seq -s "#" 70 | tr -d '[:digit:]') ;;
        86) echo $(seq -s "#" 71 | tr -d '[:digit:]') ;;
        87) echo $(seq -s "#" 72 | tr -d '[:digit:]') ;;
        88) echo $(seq -s "#" 73 | tr -d '[:digit:]') ;;
        89|90) echo $(seq -s "#" 74 | tr -d '[:digit:]') ;;
        91) echo $(seq -s "#" 75 | tr -d '[:digit:]') ;;
        92) echo $(seq -s "#" 76 | tr -d '[:digit:]') ;;
        93) echo $(seq -s "#" 77 | tr -d '[:digit:]') ;;
        94|95) echo $(seq -s "#" 78 | tr -d '[:digit:]') ;;
        96) echo $(seq -s "#" 79 | tr -d '[:digit:]') ;;
        97) echo $(seq -s "#" 80 | tr -d '[:digit:]') ;;
        98) echo $(seq -s "#" 81 | tr -d '[:digit:]') ;;
        99|100) echo $(seq -s "#" 82 | tr -d '[:digit:]') ;;
        *) echo "" ;;
    esac
}

VERSION(){
    echo -e "
entropy 0.1
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Jim Sher.
"
exit 0
}

DESC(){
    echo -e "NAME
       entropy - Display entropy of a particular string with a bar chart displaying character usage.

SYNOPSIS
       ./entropy.sh [OPTION]... [STRING]...

DESCRIPTION
       Display entropy for the entire STRING with a breakdown of character usage, writing to standard output.

       As of now, only standard input is read.

       -l, --letters
              exclude all alpha characters from the parsed string

       -n, --numbers
              exclude all numeric characters from the parsed string

       -s, --special
              exclude all special/punctuation characters from the parsed string

       -w, --white-space
              exclude all white-space characters from the parsed string

       -i, --ignore-case
              parse the string, ignoring upper case and lower case

       -p, --period
              exclude all period characters from the parsed string

       -a, --ascend
              parse the string, with the count of the lowest number of characters at the top

       -d, --descend
              parse the string, with the count of the highest number of characters at the top

       -h, --help display this help and exit

       --version
              output version information and exit

AUTHOR
       Written by Jim Sher.
"
exit 0
}

###### SCRIPT STARTS HERE ######

# add a spacer
echo -e ""

# Set input to remaining command-line arguments
input="$@"

if [[ -z $input ]];then
    DESC
fi

# Check command-line options
while getopts ":lnswipadh" opt; do
    case ${opt} in
        l|--letters)  input=$(tr -d '[:alpha:]' <<< "$input");;
        n|--numbers)  input=$(tr -d '[:digit:]' <<< "$input");;
        s|--special)  input=$(tr -d '[:punct:]' <<< "$input");;
        w|--white-space)  input=$(tr -d '[:space:]' <<< "$input");;
        i|--ignore-case)  input=$(tr '[:lower:]' '[:upper:]' <<< "$input");;
        p|--period)  input="${input//./}";;
        a|--ascend)  a_option=true;;
        d|--descend) d_option=true;;
        --version)  VERSION;;
        h|--help)  DESC;;
        \?) echo "Invalid option: -$OPTARG" >$2; exit 1;;
    esac
done

shift $((OPTIND -1))

# Check for mutually exclusive options
if [[ "$a_option" = true && "$d_option" = true ]]; then
    echo "Options -a and -d cannot be used together."
    exit 1
fi

for char in $(echo "$input" | grep -o . | sort -u);
do
    lastchar="$char"
done


for (( i = 0; i < ${#input}; i++ )); do
    char="${input:i:1}"
    if [[ "$char" =~ [[:alpha:]] ]]; then
        (( total_alpha_chars++ ))
    elif [[ "$char" =~ [[:digit:]] ]]; then
        (( total_numeric_chars++ ))
    fi
    (( total_chars++ ))  # Increment total character count
done

# Print entropy
echo -e "   \e[4mShannon Entropy: $(calculate_entropy "$@")\e[0m
"

# Print the x-axis labels and line
print_percentages
$print_y_line

# Iterate through the unique characters and print the percentage
for char in $(echo "$input" | grep -o . | sort -u); do
    # Escape special characters in the character variable
    escaped_char=$(printf '%s\n' "$char" | sed 's/[][\.^$*+?{}\\()|]/\\&/g')

    # Count the number of times that character appears in the string
    count=$(grep -o "$escaped_char" <<< "$input" | wc -l)

    # Calculate the percentage
    percentage=$((count * 100 / total_chars))

    # Create a temporary variable to hold the string
    temp_input="$input"

    # Remove all occurrences of the character from the temporary variable
    while [[ "$temp_input" =~ "$char" ]]; do
        temp_input="${temp_input//$char/}"
    done

    # Print the percentage and the character
    if [[ "$char" == "$lastchar" ]]; then
        hashes="$(get_hashes "$percentage")"
        num_hashes=$(grep -o "#" <<< "$hashes" | wc -l)
        afterhash=$((82 - "num_hashes"))
         printf "\e[0m %s \e[4m|%s%s\n" "$char" "$(get_hashes "$percentage")" "$(printf '%*s' "$afterhash" '')"
        echo -e "\e[0m"
    else
        printf "\e[0m %s |%s\n" "$char" "$(get_hashes "$percentage")"
    fi
done

echo -e "\e[0m"
