size="32px"

source content-generators/finance/scrapers/market.sh currency usdcad
cad2usd="$price"
unitSign="$"
image="$"
source content-generators/finance/view.sh

url=https://www.
url=$url"spgl"
url=$url"obal.com/spd"
url=$url"ji/en/indices/equity/sp-ts"
url=$url"x-comp"
url=$url"osite-index/#overview"
cache=`curl --silent $url`
title="TSX"
unitSign=""
image="<image:images/finance/32px/tsx.gif>"
price=`echo "$cache" | grep published-value | grep -o [.,0-9]* | tr -d ","`
percent=`echo "$cache" | grep daily-change | cut -d">" -f2 | grep -o [\-+.0-9]*`
source content-generators/finance/view.sh

source content-generators/finance/scrapers/market.sh index djia
source content-generators/finance/view.sh

source content-generators/finance/scrapers/market.sh index comp
source content-generators/finance/view.sh

source content-generators/finance/scrapers/market.sh future "crude%20oil%20-%20electronic"
source content-generators/finance/view.sh

source content-generators/finance/scrapers/metal.sh AU

source content-generators/finance/scrapers/metal.sh AG

source content-generators/finance/scrapers/metal.sh PT

source content-generators/finance/scrapers/crypto.sh btc-usd

source content-generators/finance/scrapers/crypto.sh eth-usd

source content-generators/finance/scrapers/crypto.sh xlm-usd

source content-generators/finance/scrapers/crypto.sh xrp-usd
