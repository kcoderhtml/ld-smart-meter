#!/bin/bash

# The input file
# read -p "Enter the file name: " file
file="test.json"

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

# Print the formatted array
printf '%s\n' "${array[@]}"
