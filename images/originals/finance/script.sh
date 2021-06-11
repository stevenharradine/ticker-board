echo "Resizing "
echo -n "32px . "
convert $1 -resize 32x32 ../../finance/32px/$2.gif
echo "done"

echo -n "16px . "
convert $1 -resize 16x16 ../../finance/16px/$2.gif
echo "done"
