#!/bin/bash

# Drew C
# Script name - parsevowels.sh
# Accepts a nominated file from the user, validates that the file exists. 
# Counts number of words and number of vowels in each word for words that are 4 or more characters in length. Words that are less than this are excluded.
# Prints each total vowels found and the associated words and notifies if no words are found for a particular vowel count.

# Function to parse vowels
parseVowels() {
    local inputFile="$1"
    local totalNumberWords=0
    local wordsMoreThanFour=0
    declare -A vowelCountMap
    declare -A vowelWordsMap

    # Initialize vowel counts (0 to 5 vowels)
    for i in {0..5}; do
        vowelCountMap[$i]=0
        vowelWordsMap[$i]=""
    done

    # Process file word by word
    while read -r word; do
        totalNumberWords=$((totalNumberWords + 1))
        clean_word=$(echo "$word" | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]')
        if [[ ${#clean_word} -ge 4 ]]; then
            wordsMoreThanFour=$((wordsMoreThanFour + 1))
            # Count vowels in the word
            vowel_count=$(echo "$clean_word" | grep -o '[aeiou]' | wc -l)
            if [[ $vowel_count -ge 0 && $vowel_count -le 5 ]]; then
                vowelCountMap[$vowel_count]=$((vowelCountMap[$vowel_count] + 1))
                vowelWordsMap[$vowel_count]+="[$clean_word] "
            fi
        fi
    done < <(tr ' ' '\n' < "$inputFile")

    # Display results
    echo -e "\nThe file contains $totalNumberWords words, of which $wordsMoreThanFour are four letters or more in length."
    echo "The vowel count for these $wordsMoreThanFour words is as follows:"

    for i in {0..5}; do
        if [[ ${vowelCountMap[$i]} -gt 0 ]]; then
            echo "${vowelCountMap[$i]} contain $i vowels, these being: ${vowelWordsMap[$i]}"
        else
            echo "There are no words that contain $i vowels."
        fi
        echo
    done
}

# Main Script Logic
while true; do
    read -e -p "Please enter a file name to parse, you may use tab for completion: " inputFile
    if [[ -f "$inputFile" ]]; then
        parseVowels "$inputFile"
        break
    else
        echo "$inputFile, A file of this name does not exist in this location. Please try again."
    fi
done

echo "End of Script, Tapadh Leat!(Thank You!)."
exit 0
