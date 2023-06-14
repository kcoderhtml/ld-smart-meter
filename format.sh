#!/bin/bash

# The input file test for argument or user input
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    read -p "Enter the file name: " file
else
    file=$1
fi

# Loop over the objects and create an array
array=()
while read -r line; do
    line=$(echo $line | sed 's/{Time:\([^ ]*\)/{"Time":"\1",/' | sed 's/ SCM:{ID:\([^ ]*\)/ "SCM":{"ID":"\1",/' | sed 's/ Type:\([^ ]*\)/ "Type":"\1",/' | sed 's/ Tamper:{Phy:\([^ ]*\)/ "Tamper":{"Phy":"\1",/' | sed 's/ Enc:\([^ ]*\)/ "Enc":"\1"},/' | sed 's/ Consumption: \([^ ]*\)/ "Consumption":"\1",/' | sed 's/ CRC:\([^}]*\)/ "CRC":"\1"/')
    array+=("$line")
done <"$file"

# Add commas to the array
for ((i = 0; i < ${#array[@]} - 1; i++)); do
    array[$i]="${array[$i]},"
done

# Add square brackets to the start and end of the array
array=("[" "${array[@]/%/ }" "]")

# Run the array through jq and write the output to a temporary file
tmpfile=$(mktemp)
printf "%s\n" "${array[@]}" | jq . > "$tmpfile"

# Check if jq was successful
if [ $? -eq 0 ]; then
    # Move the temporary file to the output file
    mv "$tmpfile" "$file"
else
    # Print an error message and delete the temporary file
    echo "-------------------------"
    echo "jq failed to process the input file"
    rm "$tmpfile"
fi
