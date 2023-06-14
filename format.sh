#!/bin/bash

# The input file
read -p "Enter the file name: " file

# Loop over the objects and create an array
array=()
while read -r line; do
  array+=("$line")
done < "$file"

# Add commas to the array
for (( i=0; i<${#array[@]}-1; i++ )); do
  array[$i]="${array[$i]},"
done

# Enclose the Time field in quotes
for (( i=0; i<${#array[@]}; i++ )); do
  array[$i]=$(echo "${array[$i]}" | sed 's/Time:\(.*\)/"Time":"\1"/;s/ SCM:/","SCM":"/')
done

# Add square brackets to the start and end of the array
array=( "[" "${array[@]/%/ }" "]" )

# Print the formatted array
echo "${array[@]}" | jq .