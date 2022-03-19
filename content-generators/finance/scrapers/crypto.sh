url="https://"
url=$url"markets."
url=$url"business"
url=$url"insider"
url=$url".com/currencies/$1-usd"

unitSign="$"
convertUSD2CAD="true"
title=$1
image=""

if [ "$1" = "btc" ]; then
	image="<image:images/finance/32px/btc.gif>"
elif [ "$1" = "eth" ]; then
	image="<image:images/finance/32px/eth.gif>"
elif [ "$1" = "xrp" ]; then
	image="<image:images/finance/32px/xrp.gif>"
elif [ "$1" = "xlm" ]; then
	image="<image:images/finance/32px/xlm.gif>"
fi

cache=`curl --silent $url`
price=`echo "$cache" | grep "price-section__current-value" | grep -o "[0-9.]*" | tr -d '\n'`
change=`echo "$cache" | grep "price-section__absolute-value" | grep -o "[,0-9.-]*" | tail -n 1 | tr -d ','`
percent=`echo "$cache" | grep "price-section__relative-value" | grep -o "[0-9.-]*" | tail -n 1`

source content-generators/finance/view.sh
