url="https://"
url=$url"markets."
url=$url"business"
url=$url"insider"
url=$url".com/currencies/$1"

unitSign="$"
convertUSD2CAD="true"

if [ "$1" = "btc-usd" ]; then
	title="BTC"
	image="<image:images/finance/32px/btc.gif>"
elif [ "$1" = "eth-usd" ]; then
	title="ETH"
	image="<image:images/finance/32px/eth.gif>"
elif [ "$1" = "xrp-usd" ]; then
	title="XRP"
	image="<image:images/finance/32px/xrp.gif>"
elif [ "$1" = "xlm-usd" ]; then
	title="XLM"
	image="<image:images/finance/32px/xlm.gif>"
fi

cache=`curl --silent $url`
price=`echo "$cache" | grep "price-section__current-value" | grep -o "[0-9.]*" | tr -d '\n'`
change=`echo "$cache" | grep "price-section__absolute-value" | grep -o "[,0-9.-]*" | tail -n 1 | tr -d ','`
percent=`echo "$cache" | grep "price-section__relative-value" | grep -o "[0-9.-]*" | tail -n 1`

source content-generators/finance/view.sh
