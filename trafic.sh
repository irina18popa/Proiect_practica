#!/bin/bash
fis=./1.txt
if [ "$#" -eq 2 ]
then
	sudo tshark -a duration:"$1" > "$fis"
	sed -E -i "s/( *)(.*)/\2/g" "$fis"
	sed -i -E "s/ →//g" "$fis"
	if [ "$2" = "all" ] 
	then
		cat "$fis"
	else
		egrep "$2" "$fis"
		
	fi 
fi
