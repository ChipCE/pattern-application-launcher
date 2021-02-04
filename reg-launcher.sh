#!/bin/bash

echo "Pattern application launcher v1.0b"

NAME=""
EXT=""
DIR=""
MATCHED=""


while getopts n:e:d:h: option
do
	case "${option}" in
		n)
			NAME=${OPTARG}
			;;
		e)
			EXT=${OPTARG}
			;;
		d)
			DIR=${OPTARG}
			;;
	esac
done

echo "DIR = $DIR"
echo "NAME = $NAME"
echo "EXT = $EXT"

if [ "$DIR" = "" ]
then
	echo "ERROR : No input directory."
	exit 1
fi

if [ "$NAME" = "" ]
then
	echo "ERROR : No name input."
	exit 1
fi

if [ "$NAME" != "" ]
then
	if [ "$EXT" != "" ]
	then
		ls "$DIR" | sort -r | grep -P "$NAME.*\.$EXT$" -m 1
		MATCHED=($(ls "$DIR" | sort -r | grep -P "$NAME.*\.$EXT$" -m 1))
	else
		ls "$DIR" | sort -r | grep -P "$NAME" -m 1
		MATCHED=($(ls "$DIR" | sort -r | grep -P "$NAME" -m 1))
	fi

	if [ "$MATCHED" = "" ]
	then
		echo "WARNING : No matched result for $NAME"
		exit 1
	else
		echo "Found : $MATCHED"
	fi

	cd "$DIR"
	if [ -f "$MATCHED" ]
	then
		echo "Launching $MATCHED ..."
		./"$MATCHED"
	else
		echo "ERROR : $MATCHED is not a file!"
		exit 1
	fi

	exit 0
fi

exit 0

