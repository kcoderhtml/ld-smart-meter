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

# Print the formatted array
printf '%s\n' "${array[@]}"