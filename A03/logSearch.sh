# Run a search on one (1) server access log of the user’s choosing based on one (1) field criteria input, also of the user’s choosing, e.g. PROTOCOL=`TCP`

# The results of each search the user conducts are to be displayed to the terminal and also exported to a .csv file with a name of the user’s choosing. Each results file created must be uniquely named so that the results files of previous searches are not overwritten

# Any log file records in which the CLASS field is set to normal are to be automatically excluded from the search results printed to the screen/written to file

# When the PACKETS and/or BYTES fields are selected by the user as search criteria, the user should be able to choose greater than (-gt), less than (-lt), equal to (-eq) or not equal to !(-eq) the specific value they provide, e.g. find all matches where PACKETS > `10`

# When the SRC IP or DEST IP fields are used as search criteria, the user should only need provide a partial search string rather than a complete value, e.g. search using the partial string EXT rather than the exact value EXT_SERVER

# dvanced - choose 2 

# Enable the log tool script to run searches on a single server access log of the user’s choice using both two (2) and three (3) field criteria inputs, e.g. find all matches where PROTOCOL=`TCP` and SRC IP=`ext` and PACKETS > `10`

# Enable the log tool script to run searches on all available server access logs based on one (1) field criteria input, e.g., find all matches where PROTOCOL=`TCP` in all available log files

# When the PACKETS and/or BYTES fields are used as search criteria, totals for each of these should also be calculated and displayed as the final row of the search results printed to terminal/file

#!/bin/bash

declare -a logs
patt="serv_acc_log.+csv$"
mennum=1

for file in ./*; do
    if [[ $file =~ $patt ]]; then 
        logs+=($(basename $file))
    fi
done

count=${#logs[*]}
echo -e "The logs array contains $count files.\n"

for file in "${logs[@]}"; do
    echo -e "$mennum $file"
    ((mennum++))
done

echo -e "\t"
read -p "Enter the number of the file in the menu you wish to search: " sel
echo "you have entered $sel " 

exit 0