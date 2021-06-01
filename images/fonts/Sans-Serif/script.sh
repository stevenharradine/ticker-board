for num in {0..9}
do
	convert white/32px/$num.gif -resize -1x32 -background black -alpha remove -alpha off -fuzz 100% -fill red +opaque white red/32px/$num.gif
done
