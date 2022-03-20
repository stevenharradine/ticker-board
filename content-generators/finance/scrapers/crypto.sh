url="https://"
url=$url"markets."
url=$url"business"
url=$url"insider"
url=$url".com/currencies/$1-usd"

unitSign="$"
convertUSD2CAD="true"
title=$1
image="<image:images/finance/32px/$1.gif>"

cache=`curl --silent $url`
price=`echo "$cache" | grep "price-section__current-value" | grep -o "[0-9.]*" | tr -d '\n'`
change=`echo "$cache" | grep "price-section__absolute-value" | grep -o "[,0-9.-]*" | tail -n 1 | tr -d ','`
percent=`echo "$cache" | grep "price-section__relative-value" | grep -o "[0-9.-]*" | tail -n 1`

source content-generators/finance/view.sh
