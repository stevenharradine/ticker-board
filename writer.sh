text=$1
font="Sans-Serif"
size="32px"
color="white"
directWriteMode="false"

for (( i=0; i<${#text}; i++ )); do
	char="${text:$i:1}"

	if [ "$char" = "<" ]; then
		directWriteMode="true"
		mappedChar=" "
	elif [ "$char" = ">" ]; then
		mappedChar=" "
	elif [ "$char" = "¶" ]; then
		color="white"
		mappedChar="null"
	elif [ "$char" = "·" ]; then
		color="green"
		mappedChar="null"
	elif [ "$char" = "¸" ]; then
		color="red"
		mappedChar="null"
	else
		mappedChar="$char"

		if [ "$directWriteMode" = "false" ]; then
			mappedChar=${mappedChar^^}

			if [ "$char" = " " ]; then
				mappedChar="special/space"
			elif [ "$char" = "." ]; then
				mappedChar="special/period"
			elif [ "$char" = "$" ]; then
				mappedChar="special/dollar"
			elif [ "$char" = "°" ]; then
				mappedChar="special/degree"
			elif [ "$char" = "-" ]; then
				mappedChar="special/minus"
			elif [ "$char" = "(" ]; then
				mappedChar="special/open-bracket"
			elif [ "$char" = ")" ]; then
				mappedChar="special/close-bracket"
			elif [ "$char" = "%" ]; then
				mappedChar="special/percent"
			elif [ "$char" = "?" ]; then
				mappedChar="special/questionmark"
			elif [ "$char" = "," ]; then
				mappedChar="special/comma"
			elif [ "$char" = "|" ] || [ "$char" = "," ] || [ "$char" = "'" ] || [ "$char" = ":" ] || [ "$char" = "/" ]; then
				mappedChar="special/space"
			fi
		fi
	fi

	if [ "$directWriteMode" = "true" ]; then
		paths="$paths$mappedChar"
	else
		if [ "$mappedChar" != "null" ]; then
			paths="$paths images/fonts/$font/$color/$size/$mappedChar.gif"
		fi
	fi

	if [ "$char" = ">" ]; then
		directWriteMode="false"
	fi
done

convert $paths +append ticker.ppm
