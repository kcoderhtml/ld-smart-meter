#!/bin/bash

input='{Time:2023-06-14T15:23:29.598 SCM:{ID:35880774 Type:12 Tamper:{Phy:02 Enc:00} Consumption: 555070 CRC:0x4989}}'

# Removing unnecessary characters from the input
input=$(echo $input | sed 's/{Time:\([^ ]*\)/{"Time":"\1"/' | sed 's/ SCM:{ID:\([^ ]*\)/ "SCM":{"ID":"\1"/' | sed 's/ Type:\([^ ]*\)/ "Type":"\1"/' | sed 's/ Tamper:{Phy:\([^ ]*\)/ "Tamper":{"Phy":"\1"/' | sed 's/ Enc:\([^}]*\)/ "Enc":"\1"/' | sed 's/ Consumption: \([^ ]*\)/ "Consumption":"\1"/' | sed 's/ CRC:\([^}]*\)/ "CRC":"\1"/')

# Adding double quotes to the keys and values
# input=$(echo $input | sed 's/{Time/{ "Time/g' | sed 's/ SCM/ "SCM/g' | sed 's/ ID/ "ID/g' | sed 's/ Type/ "Type/g' | sed 's/ Tamper/ "Tamper/g' | sed 's/ Phy/ "Phy/g' | sed 's/ Enc/ "Enc/g' | sed 's/ Consumption/ "Consumption/g' | sed 's/ CRC/ "CRC/g' | sed 's/}/" }/g')

# Adding curly braces at the start and end
input="[$input]"

echo $input