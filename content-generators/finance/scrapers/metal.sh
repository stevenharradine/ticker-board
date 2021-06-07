url=https://www.
url="$url"kit
url="$url"co.com

cache=`curl --silent $url`
price=`echo "$cache" | grep "$1-bid" | tail -n 1 | grep -o "[0-9.]*" | tail -n 1`
change=`echo "$cache" | grep "$1-change" | head -n 1 | cut -d">" -f4 | grep -o [\-+0-9.]* | tr -d '+'`
percent=`echo "($change / $price) * 100" | bc -l | xargs printf "%.2f"`

echo "$price * $cad2usd" | bc | xargs printf "$%'.2f "

if [ "`echo \"$change > 0\" | bc`" = "1" ] && [ "`echo \"$percent > 0\" | bc`" = "1" ]; then
	echo -n "<color:green>"
fi
if [ "`echo \"$change < 0\" | bc`" = "1" ] && [ "`echo \"$percent < 0\" | bc`" = "1" ]; then
	echo -n "<color:red>"
fi

echo "$change * $cad2usd" | bc | xargs printf "$%'.2f "
echo "($percent%)<color:white>    "