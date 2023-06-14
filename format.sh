#!/bin/bash

# The input file
# read -p "Enter the file name: " file
file="test.json"

# Loop over the objects and create an array
array=()
while read -r line; do
  array+=("$line")
done < "$file"

# Add commas to the array
for (( i=0; i<${#array[@]}-1; i++ )); do
  array[$i]="${array[$i]},"
done

# Enclose the Time field in quotes and format the SCM field
for (( i=0; i<${#array[@]}; i++ )); do
  array[$i]=$(echo "${array[$i]}" | sed 's/Time:\(.*\) SCM:/{ "Time":"\1", "SCM":/')
  array[$i]=$(echo "${array[$i]}" | sed 's/ ID:/{ "ID":"/')
  array[$i]=$(echo "${array[$i]}" | sed 's/ Type:/", "Type":"/')
  array[$i]=$(echo "${array[$i]}" | sed 's/ Tamper:/{ "Tamper":/')
  array[$i]=$(echo "${array[$i]}" | sed 's/ Phy:/{ "Phy":"/')
  array[$i]=$(echo "${array[$i]}" | sed 's/ Enc:/", "Enc":"/')
  array[$i]=$(echo "${array[$i]}" | sed 's/ Consumption:/"}, "Consumption":/')
  array[$i]=$(echo "${array[$i]}" | sed 's/ CRC:/, "CRC":"/')
  array[$i]=$(echo "${array[$i]}" | sed 's/$/"} }/')
done

# Add square brackets to the start and end of the array
array=( "[" "${array[@]/%/ }" "]" )

# Save data to a file
echo "${array[@]}" > output.json

# Print the formatted array
jq . output.json