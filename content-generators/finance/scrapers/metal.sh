url=https://www.
url="$url"kit
url="$url"co.com

unitSign="$"
convertUSD2CAD="true"
symbol=${1^^}

if [ "$symbol" = "AU" ]; then
	title=Gold
	image="<image:images/finance/32px/gold.gif>"
elif [ "$symbol" = "AG" ]; then
	title=Silver
	image="<image:images/finance/32px/silver.gif>"
elif [ "$symbol" = "PT" ]; then
	title=Platinum
	image="<image:images/finance/32px/platinum.gif>"
elif [ "$symbol" = "PD" ]; then
	title=Palladium
	image="<image:images/finance/32px/silver.gif>"
fi

cache=`curl --silent $url`
price=`echo "$cache" | grep "$symbol-bid" | tail -n 1 | grep -o "[0-9.]*" | tail -n 1`
change=`echo "$cache" | grep "$symbol-change" | head -n 1 | cut -d">" -f4 | grep -o [\-+0-9.]* | tr -d '+'`
percent=`echo "($change / $price) * 100" | bc -l | xargs printf "%.2f"`

source content-generators/finance/view.sh
