url=https://www.
url="$url"kit
url="$url"co.com

unitSign="$"
convertUSD2CAD="true"

if [ "$1" = "AU" ]; then
	title=Gold
	image="<image:images/finance/32px/gold.gif>"
elif [ "$1" = "AG" ]; then
	title=Silver
	image="<image:images/finance/32px/silver.gif>"
elif [ "$1" = "PT" ]; then
	title=Platinum
	image="<image:images/finance/32px/platinum.gif>"
elif [ "$1" = "PD" ]; then
	title=Palladium
	image="<image:images/finance/32px/silver.gif>"
fi

cache=`curl --silent $url`
price=`echo "$cache" | grep "$1-bid" | tail -n 1 | grep -o "[0-9.]*" | tail -n 1`
change=`echo "$cache" | grep "$1-change" | head -n 1 | cut -d">" -f4 | grep -o [\-+0-9.]* | tr -d '+'`
percent=`echo "($change / $price) * 100" | bc -l | xargs printf "%.2f"`

source content-generators/finance/view.sh
