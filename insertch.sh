#!/usr/bin/env bash

# Handle errors gracefully
if [ "$#" -ne 1 ]; then
	echo "Error: expected 1 argument, received $#"
	exit 1
elif [[ ! -f "$1" ]]; then
	echo "Error: expected an existing file, received $1"
	exit 1
elif [[ "$1" != *.c ]]; then
	echo "Error: expected a .c file, received $1"
	exit 1
fi

# Variable declarations
FNAME=$1
FOWNER=$(ls -l ./"$FNAME" | awk '{print $3}')
FMOD_MONTH=$(ls -l ./"$FNAME" | awk '{print $7}')
FMOD_DAY=$(ls -l ./"$FNAME" | awk '{print $8}')
FMOD_TIME=$(ls -l ./"$FNAME" | awk '{print $9}')
FCH="
/**
* File Name: $FNAME
* Owner: $FOWNER
* Last Modified On: $FMOD_MONTH $FMOD_DAY $FMOD_TIME
*/
"

# Main program
cp "$FNAME" temp.c
echo -n > "$FNAME"
echo "$FCH" >> "$FNAME"
cat temp.c >> "$FNAME"
rm temp.c
