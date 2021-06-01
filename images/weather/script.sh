#
#for num in {0..9}
#do
#        convert 0$num.gif -resize 38x32 -background black -alpha remove -alpha off 0$num.32px.gif
#done
#
#for num in {10..49}
#do
#	convert $num.gif -resize 38x32 -background black -alpha remove -alpha off $num.32px.gif
#done

for num in {10..49}
do
	convert 32px/$num.gif -resize 19x16 -background black -alpha remove -alpha off 16px/$num.gif
done
