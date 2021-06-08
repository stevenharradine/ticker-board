for folder in red green
do
	mkdir -p $folder
	mkdir -p $folder/16px
	mkdir -p $folder/16px/special
	mkdir -p $folder/32px
	mkdir -p $folder/32px/special
done

for char in {A..Z} special/close-bracket special/comma special/degree special/dollar special/minus special/open-bracket special/percent special/period special/questionmark special/space
do
	convert white/32px/$char.gif +level-colors black,"#FF0000" red/32px/$char.gif
	convert white/32px/$char.gif -resize 50% +level-colors black,"#FF0000" red/16px/$char.gif

	convert white/32px/$char.gif +level-colors black,"#00FF00" green/32px/$char.gif
	convert white/32px/$char.gif -resize 50% +level-colors black,"#00FF00" green/16px/$char.gif
done
