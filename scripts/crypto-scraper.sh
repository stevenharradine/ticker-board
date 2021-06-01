url="https://"
url=$url"markets."
url=$url"business"
url=$url"insider"
url=$url".com/currencies/$1"

cache=`curl --silent $url`
price=`echo "$cache" | grep "price-section__current-value" | grep -o "[0-9.]*" | tr -d '\n'`
absolute_change=`echo "$cache" | grep "price-section__absolute-value" | grep -o "[,0-9.-]*" | tail -n 1 | tr -d ','`
relative_change=`echo "$cache" | grep "price-section__relative-value" | grep -o "[0-9.-]*" | tail -n 1`

echo "$price * $cad2usd" | bc | xargs printf "$%'.2f "

if [ "`echo \"$absolute_change > 0\" | bc`" = "1" ] || [ "`echo \"$relative_change > 0\" | bc`" = "1" ]; then
	echo -n "·"
fi
if [ "`echo \"$absolute_change < 0\" | bc`" = "1" ] || [ "`echo \"$relative_change < 0\" | bc`" = "1" ]; then
	echo -n "¸"
fi

printf "%'.2f (%.2f%%)¶    " $absolute_change $relative_change
