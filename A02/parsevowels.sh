#!/bin/bash

#Drew Cameron-Keil - 10215233
#Script name - parsevowels.sh
# Accepts a nominated file from the user, validates that the file exits. 
# Counts number of words and number of vowels in each word for words that are 4 or more characters in length. Words that are less than this are exluded.
# Prints each total vowels found and the associated words and notifies if no words are found for a particular vowel count.


# Main body of script.
read -e -p "Please enter a file name to parse, you may use tab for completion: " inputFile

if [ ! -f $inputFile ]
then
    echo "$inputFile, A file of this name does not exist in this location. Please try again. "
    exit 0
fi
# Call to function is placed at the end of the script. 

parseVowels() {

    wordsMoreThanFour=0
    totalNumberWords=0
    
    #holds in put file. 
    inputFile=$1

    #variables to hold counts and words. 
    vowelCountZero=0
    vowelCountOne=0
    vowelCountTwo=0
    vowelCountThree=0
    vowelCountFour=0
    vowelCountFive=0

    vowelWordsZero=""
    vowelWordsOne=""
    vowelWordsTwo=""
    vowelWordsThree=""
    vowelWordsFour=""
    vowelWordsFive=""

    #iterate each word in the file
    for word in `cat $inputFile`; do
        totalNumberWords=$((totalNumberWords+1))
        #echo $word
        #get the length of each word
        length=`echo $word | wc -c`
        length=$((length-1))

        #checks for words that are more than 4 chars in length
        if [ $length -ge 4 ]; then
            wordsMoreThanFour=$((wordsMoreThanFour+1))
        else
            continue
        fi

        #check whether the word has any vowels
        temp=0
        if [ `echo $word | grep -ci 'a'` -gt 0 ]; then
            temp=$((temp+1))
        fi
        
        if [ `echo $word | grep -ci 'e'` -gt 0 ]; then
            temp=$((temp+1))
        fi
        
        if [ `echo $word | grep -ci 'i'` -gt 0 ]; then
            temp=$((temp+1))
        fi
        
        if [ `echo $word | grep -ci 'o'` -gt 0 ]; then
            temp=$((temp+1))
        fi
        
        if [ `echo $word | grep -ci 'u'` -gt 0 ]; then
            temp=$((temp+1))
        fi

        # following if checks, check how many vowels are present in each word
        if [ $temp -eq 0 ]; then
            vowelCountZero=$((vowelCountZero+1))
            vowelWordsZero='['$word'] '$vowelWordsZero
        
        elif [ $temp -eq 1 ]; then
            vowelCountOne=$((vowelCountOne+1))
            vowelWordsOne='['$word'] '$vowelWordsOne
        
        elif [ $temp -eq 2 ]; then
            vowelCountTwo=$((vowelCountTwo+1))
            vowelWordsTwo='['$word'] '$vowelWordsTwo
        
        elif [ $temp -eq 3 ]; then
            vowelCountThree=$((vowelCountThree+1))
            vowelWordsThree='['$word'] '$vowelWordsThree
        
        elif [ $temp -eq 4 ]; then
            vowelCountFour=$((vowelCountFour+1))
            vowelWordsFour='['$word'] '$vowelWordsFour
        
        elif [ $temp -eq 5 ]; then
            vowelCountFive=$((vowelCountFive+1))
            vowelWordsFive='['$word'] '$vowelWordsFive
        fi
    
    done

    # Printing to console.
    echo -n -e "\nThe file contains $totalNumberWords words, of which $wordsMoreThanFour are four letters or more in length."
    echo -e " The vowel count for these $wordsMoreThanFour words are follows:\n "

    #based on number of vowels in the word, print the result to screen
    if [ $vowelCountZero -eq 0 ]; then
        echo -e "There are no words that contain 0 vowels.\n"
    else
        echo "$vowelCountZero contain 0 vowels, these being:"
        echo -e "$vowelWordsZero\n" 
    fi

    if [ $vowelCountOne -eq 0 ]; then
        echo -e "There are no words that contain 1 vowels.\n"
    else
        echo -e "$vowelCountOne contain 1 vowels, these being:"
        echo -e "$vowelWordsOne\n"
    fi

    if [ $vowelCountTwo -eq 0 ]; then
        echo -e "There are no words that contain 2 vowels.\n"
    else
        echo "$vowelCountTwo contain 2 vowels, these being:"
        echo -e "$vowelWordsTwo\n"
    fi

    if [ $vowelCountThree -eq 0 ]; then
        echo -e "There are no words that contain 3 vowels.\n"
    else
        echo "$vowelCountThree contain 3 vowels, these being:"
        echo -e "$vowelWordsThree\n"
    fi

    if [ $vowelCountFour -eq 0 ]; then
        echo -e "There are no words that contain 4 vowels.\n"
    else
        echo "$vowelCountFour contain 4 vowels, these being:"
        echo -e "$vowelWordsFour\n"
    fi

    if [ $vowelCountFive -eq 0 ]; then
        echo -e "There are no words that contain 5 vowels.\n"
    else
        echo "$vowelCountFive contain 5 vowels, these being:"
        echo -e "$vowelWordsFive\n"
    fi
}


# Calling the parseVowels function
parseVowels $inputFile

echo "End of Script, Tapadh Leat!(Thank You!)."
exit 0
