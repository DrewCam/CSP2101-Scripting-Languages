#!/bin/bash

# Drew Cameron
# Script name - getprimes.sh
# Counts all prime numbers that exist within a user-provided range.
# Calculates the sum of all the prime numbers identified within this range.
# Prints the prime numbers, their count, and their sum to the terminal.

while true; do
    # Prompt user for input
    read -p "Enter Lower Range (must be a whole number, e.g., 100): " lower
    read -p "Enter Upper Range (must be a whole number, e.g., 200): " upper

    # Input validation
    if [[ -z "$lower" || -z "$upper" ]]; then
        echo "Input cannot be blank."
    elif ! [[ "$lower" =~ ^[0-9]+$ && "$upper" =~ ^[0-9]+$ ]]; then
        echo "Both inputs must be whole numbers."
    elif [[ "$lower" -le 1 ]]; then
        echo "Lower range must be greater than 1."
    elif [[ "$upper" -le "$lower" ]]; then
        echo "Upper range must be greater than the lower range."
    elif [[ $((upper - lower)) -le 1 ]]; then
        echo "There must be at least one number between the lower and upper range."
    else
        # Inputs are valid; initialize variables
        SUM=0
        COUNT=0
        PRIMES=()

        # Loop through the range to find primes
        for ((num=lower; num<=upper; num++)); do
            is_prime=1
            for ((div=2; div<=num/2; div++)); do
                if ((num % div == 0)); then
                    is_prime=0
                    break
                fi
            done

            if ((is_prime == 1)); then
                PRIMES+=("$num")
                SUM=$((SUM + num))
                COUNT=$((COUNT + 1))
            fi
        done

        # Display results
        if ((COUNT == 0)); then
            echo "No prime numbers exist within the range $lower and $upper."
        else
            echo "Prime Numbers within the range $lower and $upper: ${PRIMES[*]}"
            echo "Count of Prime Numbers: $COUNT"
            echo "Sum of Prime Numbers: $SUM"
        fi
        break
    fi
done

echo "End of Script. Tapadh Leat!(Thank You!)."
exit 0
