text=$1
font="Sans-Serif"
size="32px"
color="white"
isExecuteSpecialCommandMode="false"
executeSpecialCommandRaw=""
rowCounter=0
imageCounter=0

for (( i=0; i<${#text}; i++ )); do
	char="${text:$i:1}"

	if [ "$char" = "<" ]; then
		isExecuteSpecialCommandMode="true"
		executeSpecialCommandRaw=""
		mappedChar=" "
	elif [ "$char" = ">" ]; then
		mappedChar=" "
	else
		mappedChar="$char"

		if [ "$isExecuteSpecialCommandMode" = "false" ]; then
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

	if [ "$isExecuteSpecialCommandMode" = "true" ]; then
		executeSpecialCommandRaw="$executeSpecialCommandRaw$mappedChar"
	else
		if [ "$mappedChar" != "null" ]; then
			paths="$paths images/fonts/$font/$color/$size/$mappedChar.gif"
		fi
	fi

	if [ "$char" = ">" ]; then
		isExecuteSpecialCommandMode="false"

		executeSpecialCommandAction=`echo $executeSpecialCommandRaw | cut -d':' -f1`
		executeSpecialCommandArgument=`echo $executeSpecialCommandRaw | cut -d':' -f2`

		if [ "$executeSpecialCommandAction" = "image" ]; then
			paths="$paths $executeSpecialCommandArgument"
		elif [ "$executeSpecialCommandAction" = "color" ]; then
			color=$executeSpecialCommandArgument
		elif [ "$executeSpecialCommandAction" = "size" ]; then
			size=$executeSpecialCommandArgument
		elif [ "$executeSpecialCommandAction" = "break" ] && [ "$executeSpecialCommandArgument" = "line" ]; then
			mkdir -p tmp
			convert $paths +append tmp/$imageCounter.$rowCounter.jpeg

			((rowCounter=rowCounter+1))
			paths=""
		elif [ "$executeSpecialCommandAction" = "break" ] && [ "$executeSpecialCommandArgument" = "new" ]; then
			mkdir -p tmp
			convert $paths +append tmp/$imageCounter.$rowCounter.jpeg

			((imageCounter=imageCounter+1))
			rowCounter=0
			paths=""
		fi
	fi
done

mkdir -p tmp
convert $paths +append tmp/$imageCounter.$rowCounter.jpeg

paths=""
i=0
while [[ $i -le $imageCounter ]]
do
   paths="$paths ( -background black tmp/$i.0.jpeg tmp/$i.1.jpeg -append ) "

   ((i = i + 1))
done

convert $paths +append ticker.ppm
convert ticker.ppm webserver/images/ticker.jpeg

rm -rf tmp
