echo "Cleaning up expanded fonts"
cd images/fonts/Sans-Serif/

echo -n " removing folders"
rm -r white/16px/ && echo -n " ."
for folder in red green
do
	rm -r $folder && echo -n " ."
done
echo " done"
