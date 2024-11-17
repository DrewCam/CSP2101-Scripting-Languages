#!/bin/bash

# Drew Cameron
# Script name: logSearch.sh
# Purpose: Analyze server access logs for suspicious activity based on user-defined criteria.

# Function to display the main menu
function display_menu() {
    echo "----------------------------------------"
    echo "Server Access Log Analysis Tool"
    echo "----------------------------------------"
    echo "1. Search a single log file"
    echo "2. Search all log files"
    echo "3. Exit"
    echo "----------------------------------------"
    echo -n "Enter your choice: "
}

# Function to validate menu input
function validate_input() {
    while [[ ! "$1" =~ ^[1-3]$ ]]; do
        echo "Invalid input. Please choose 1, 2, or 3."
        read -p "Enter your choice: " choice
    done
}

# Function to get search criteria from the user
function get_criteria() {
    echo "Enter the field to search by (PROTOCOL, SRC IP, SRC PORT, DEST IP, DEST PORT, PACKETS, BYTES):"
    read -r field
    field=$(echo "$field" | tr '[:lower:]' '[:upper:]') # Case insensitive

    echo "Enter the value to search for:"
    read -r value

    operator=""
    if [[ "$field" == "PACKETS" || "$field" == "BYTES" ]]; then
        echo "Enter comparison operator (-gt, -lt, -eq, -ne):"
        read -r operator

        # Validate operator and numeric value
        if [[ ! "$operator" =~ ^-gt$|^-lt$|^-eq$|^-ne$ ]]; then
            echo "Invalid operator. Use -gt, -lt, -eq, or -ne."
            exit 1
        fi
        if [[ ! "$value" =~ ^[0-9]+$ ]]; then
            echo "Invalid value. Enter a numeric value."
            exit 1
        fi
    fi

    echo "$field|$value|$operator"
}

# Function to process logs with criteria
function process_log() {
    local file=$1
    local field=$2
    local value=$3
    local operator=$4

    echo "Processing log file: $file"

    # Process based on criteria
    if [[ "$field" == "PACKETS" || "$field" == "BYTES" ]]; then
        awk -v field="$field" -v value="$value" -v operator="$operator" '
            BEGIN { OFS="\t"; print "SRC IP", "SRC PORT", "DEST IP", "DEST PORT", "PACKETS", "BYTES", "CLASS" }
            NR > 1 && $12 == "suspicious" && (operator == "-gt" && $8 > value || 
                                             operator == "-lt" && $8 < value || 
                                             operator == "-eq" && $8 == value || 
                                             operator == "-ne" && $8 != value) {
                print $4, $5, $6, $7, $8, $9, $12
            }' "$file"
    else
        awk -v field="$field" -v value="$value" '
            BEGIN { OFS="\t"; print "SRC IP", "SRC PORT", "DEST IP", "DEST PORT", "PACKETS", "BYTES", "CLASS" }
            NR > 1 && $12 == "suspicious" && tolower($field) ~ tolower(value) {
                print $4, $5, $6, $7, $8, $9, $12
            }' "$file"
    fi
}

# Function to search a single log file
function search_single_file() {
    echo "Enter the log file name (e.g., serv_acc_log_03042020.csv):"
    read -r logfile
    if [[ ! -f "$logfile" ]]; then
        echo "File does not exist. Please check the filename."
        return
    fi

    criteria=$(get_criteria)
    IFS="|" read -r field value operator <<<"$criteria"

    results="search_results_$(date +%s).csv"
    process_log "$logfile" "$field" "$value" "$operator" | tee "$results"
    echo "Results have been saved to $results"
}

# Function to search all log files
function search_all_files() {
    criteria=$(get_criteria)
    IFS="|" read -r field value operator <<<"$criteria"

    results="search_all_results_$(date +%s).csv"
    for logfile in *.csv; do
        process_log "$logfile" "$field" "$value" "$operator" >> "$results"
    done
    echo "Results saved to $results"
}

# Main program loop
while true; do
    display_menu
    read -r choice
    validate_input "$choice"

    case "$choice" in
    1)
        search_single_file
        ;;
    2)
        search_all_files
        ;;
    3)
        echo "Exiting the tool. Goodbye!"
        exit 0
        ;;
    esac
done
