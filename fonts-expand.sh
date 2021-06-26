echo "Expanding fonts"
cd images/fonts/Sans-Serif/

echo -n " creating folders"
mkdir -p white/16px/ && echo -n " ."
mkdir -p white/16px/special && echo -n " ."
for folder in red green
do
	mkdir -p $folder && echo -n " ."
	mkdir -p $folder/16px && echo -n " ."
	mkdir -p $folder/16px/special && echo -n " ."
	mkdir -p $folder/32px && echo -n " ."
	mkdir -p $folder/32px/special && echo -n " ."
done
echo " done"

echo -n " creating additional sizes and colours"
for char in {0..9} {A..Z} special/close-bracket special/comma special/degree special/dollar special/minus special/open-bracket special/percent special/period special/questionmark special/space special/forward-slash special/back-slash special/colon special/apostrophe
do
	convert white/32px/$char.gif -resize 50% white/16px/$char.gif && echo -n " ."

	convert white/32px/$char.gif +level-colors black,"#FF0000" red/32px/$char.gif && echo -n " ."
	convert white/32px/$char.gif -resize 50% +level-colors black,"#FF0000" red/16px/$char.gif && echo -n " ."

	convert white/32px/$char.gif +level-colors black,"#00FF00" green/32px/$char.gif && echo -n " ."
	convert white/32px/$char.gif -resize 50% +level-colors black,"#00FF00" green/16px/$char.gif && echo -n " ."
done
echo " done"
