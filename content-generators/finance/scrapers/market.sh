url=https://www.
url=$url"market"
url=$url"watch"
url=$url".com/investing/$1/$2"

convertUSD2CAD="false"
title=""
unitSign=""
image=""

if [ "$2" = "djia" ]; then
	title="DJIA"
	image="<image:images/finance/32px/djia.gif>"
elif [ "$2" = "comp" ]; then
	title="NASDAQ"
	image="<image:images/finance/32px/nasdaq.gif>"
elif [ "$2" = "crude%20oil%20-%20electronic" ]; then
	title="OIL"
	unitSign="$"
	image="<image:images/finance/32px/oil.gif>"
	convertUSD2CAD="true"
elif [ "$2" = "usdcad" ]; then
	title="USD CAD"
fi

if [ "$1" = "fund" ] || [ "$1" = "stock" ]; then
	title=$2
	unitSign="$"

	if [ "$3" = "ca" ]; then
		url=$url"?countryCode=CA"
	fi
fi


cache=`curl --silent $url`
price=`echo "$cache" | grep "meta name=\"price\" content=" | grep -o [,.0-9]* | tr -d ","`
change=`echo "$cache" | grep "meta name=\"priceChange\" content=" | grep -o [\-.0-9]*`
percent=`echo "$cache" | grep "meta name=\"priceChangePercent\" content=" | grep -o [\-.0-9]*`
