url=https://www.
url=$url"market"
url=$url"watch"
url=$url".com/investing/$1/$2"

cache=`curl --silent $url`
price=`echo "$cache" | grep "meta name=\"price\" content=" | grep -o [,.0-9]* | tr -d ","`
change=`echo "$cache" | grep "meta name=\"priceChange\" content=" | grep -o [.0-9]*`
percent=`echo "$cache" | grep "meta name=\"priceChangePercent\" content=" | grep -o [.0-9]*`

if [ "$1" = "future" ]; then
	price=`echo "$price * $cad2usd" | bc -l | xargs printf "%.2f"`
	change=`echo "$change * $cad2usd" | bc -l | xargs printf "%.2f"`
fi

printf "%'.2f " $price
if [ "`echo \"$change > 0\" | bc`" = "1" ] || [ "`echo \"$percent > 0\" | bc`" = "1" ]; then
	echo -n "<color:green>"
fi
if [ "`echo \"$change < 0\" | bc`" = "1" ] || [ "`echo \"$percent < 0\" | bc`" = "1" ]; then
	echo -n "<color:red>"
fi
printf "%.2f (%.2f%%)<color:white>    " $change $percent