#!/bin/bash

# Drew Cameron - 10215233
# Script name - getprimes.sh
# Counts - all prime numbers that exist within a user-provided range, e.g. 100 to 200
# Calculates - the sum of all the prime numbers identified within this range
# Prints - the prime numbers, their count, and their sum to the terminal

while true; do # while loop to keep user within script.

read -p "Enter Lower Range (must be a whole number. e.g 100): " lower # Get user input lower bound
read -p "Enter Upper Range (must be a whole number. e.g 200): " upper # Get user input upper bound

# input validation.
    if [ -z "$lower" ] || [ -z "$upper" ] # validate that the input is not blank
        then 
        echo "you have entered a blank input."
        read -p "Press any key to try again or N/n to exit. y/n: " resp
    elif ! [[ "$lower" =~ ^[+-]?[0-9]*$ ]] || ! [[ "$upper" =~ ^[+-]?[0-9]+*$ ]] # making sure inputs are numbers 
        then 
        echo "Upper and lower must be a whole number. e.g 100, 200 etc."
        read -p "Press any key to try again or N/n to exit. y/n: " resp 

    elif [ $lower -eq 0 ] || [ $lower -eq 1 ] # validate that lower is not a 0 or 1 
        then
        echo "Invalid Range. Start range must be greater than 1."
        read -p "Press any key to try again or N/n to exit. y/n: " resp
      
    elif [ $upper -lt $lower ] # validate to ensure that lowerrange is not lower than upper.
        then 
        echo "Upper Range cannot be less than Lower Range."
        read -p "Press any key to try again or N/n to exit. y/n: " resp

    elif [ $(($upper - $lower)) = 1 ] #validate that the lower and upper bounds have at least one number between them. 
        then 
        echo "there needs to be at least one number between the Upper and Lower Range."
        read -p "Press any key to try again or N/n to exit. y/n: " resp
    else
        for ((index=$lower;index<=$upper;index++)) #main algorithm
            do
	        skip=0
	        number=$index

	        for ((j=2; j<=$number/2; j++))
	            do
		        answer=$(( number % j )) 
		        
                if [ $answer -eq 0 ]
		            then
			        skip=1
			        break
		        fi
	    done

	    if [[ $skip == 0 ]]
	        then
		    echo "$number is a prime"
		    ((SUM=SUM+number))
	    fi

        done

    if [[ $SUM -eq 0 ]] # print output of sum, or advise that no primes exist between them. 
        then 
        echo "There are no primes between $lower & $upper"
        exit 0 
    else
        echo "Total sum of prime numbers: $SUM"
        exit 0 
        fi
    fi

case $resp in # case to exit script or try again.
    n|N) exit;;
esac

done

echo "End of Script, Tapadh Leat!(Thank You!)."

exit 0

#Drew Cameron - 10215233
#Script name - getprimes.sh
#Modules 1 to 4
#submit as a zip file - cameron-keil_10215233_CSP2101_PF1.zip

# Counts - all prime numbers that exist within a user-provided range, e.g. 100 to 200
# Calculates - the sum of all the prime numbers identified within this range
# Prints - the prime numbers, their count, and their sum to the terminal

# prompt the user for the lower and upper bounds of the range
#	inputs must be fully validated to ensure they meet the following range rules:
#	1. Accepts only numbers, e.g. 100, and nothing else, i.e., rejects strings, nulls, etc
#	2. Does not accept the numbers 0 and 1 as valid range values
#	3. Ensures the lower range bound provided is less than the upper range bound provided
#	4. Ensures that there is at least one number between the lower and upper bound values provided, e.g. a minimum viable range would be 100 to 102, but not 100 to 101
#	5. Whenever the users input does not pass validation, the user is to be advised of the applicable error and prompted to try again, i.e. the user is to be looped back to prompt; the program is not to terminate
	
# If no prime numbers exist within the stipulated range, then advise the user of this via the terminal, e.g. no prime number(s) exist within the range x and y	

# In the event one or more prime numbers are found within the stipulated range, these are to be printed to the terminal along with their count and sum in a neat, easily readable format

# Marking Key
# User prompted for lower and upper bounds of the range
# User input logic only accepts integer numbers, and not strings, nulls or floats
# User input logic rejects numbers 0 and 1 as valid range values
# User input logic ensures lower range bound less than the upper range bound
# User input logic ensures at least one number between lower and upper bound values provided
# When user input fails validation, user advised of applicable error and prompted to try again (script does not terminate)
# Where no prime numbers exist within the stipulated range, user is advised of this via the terminal
# Where prime numbers do exist within the stipulated range, all are included in the count displayed to terminal
# Where prime numbers do exist within the stipulated range, all are displayed to terminal
# Where prime numbers do exist within the stipulated range, all are factored into the correct sum which is displayed to terminal