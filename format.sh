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
    line=$(echo $line | sed 's/{Time:\([^ ]*\)/{"Time":"\1",/' | sed 's/ SCM:{ID:\([^ ]*\)/ "SCM":{"ID":"\1",/' | sed 's/ Type:\([^ ]*\)/ "Type":"\1",/' | sed 's/ Tamper:{Phy:\([^ ]*\)/ "Tamper":{"Phy":"\1",/' | sed 's/ Enc:\([^}]*\)}/ "Enc":"\1"},/' | sed 's/ Consumption: \([^ ]*\)/ "Consumption":"\1",/' | sed 's/ CRC:\([^}]*\)/ "CRC":"\1"/')
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
printf "%s\n" "${array[@]}" | jq . > "$tmpfile" 2>&1

# Check if jq was successful
if [ $? -eq 0 ]; then
    # Move the temporary file to the output file
    mv "$tmpfile" "$file"
else
    # Print an error message and the line that caused the error
    echo "-------------------------"
    cat "$tmpfile"
    line_num=$(cat "$tmpfile" | grep -oE 'line [0-9]+' | grep -oE '[0-9]+')

    line=$(printf "%s\n" "${array[@]}" | sed "${line_num}q;d")
    line_num=$(($line_num - 1))
    unfilteredline=$(cat $file | sed "${line_num}q;d")

    echo "Error Line: $line"
    echo "-------------------------"
    echo "Original file Error Line: $unfilteredline"
    printf "%s\n" "${array[@]}" > test.json
    rm "$tmpfile"
fi
