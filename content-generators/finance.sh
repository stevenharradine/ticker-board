size="32px"

tsx=`cat settings.json | grep "\"tsx\":" | cut -d":" -f2 | tr -d ",[:space:]"`
djia=`cat settings.json | grep "\"djia\":" | cut -d":" -f2 | tr -d ",[:space:]"`
nasdaq=`cat settings.json | grep "\"nasdaq\":" | cut -d":" -f2 | tr -d ",[:space:]"`
au=`cat settings.json | grep "\"au\":" | cut -d":" -f2 | tr -d ",[:space:]"`
ag=`cat settings.json | grep "\"ag\":" | cut -d":" -f2 | tr -d ",[:space:]"`
pt=`cat settings.json | grep "\"pt\":" | cut -d":" -f2 | tr -d ",[:space:]"`
pd=`cat settings.json | grep "\"pd\":" | cut -d":" -f2 | tr -d ",[:space:]"`
btc=`cat settings.json | grep "\"btc\":" | cut -d":" -f2 | tr -d ",[:space:]"`
eth=`cat settings.json | grep "\"eth\":" | cut -d":" -f2 | tr -d ",[:space:]"`
xrp=`cat settings.json | grep "\"xrp\":" | cut -d":" -f2 | tr -d ",[:space:]"`
xlm=`cat settings.json | grep "\"xlm\":" | cut -d":" -f2 | tr -d ",[:space:]"`

source content-generators/finance/scrapers/market.sh currency usdcad
cad2usd="$price"
unitSign="$"
image="$"
source content-generators/finance/view.sh

if [ "$tsx" == "true" ]; then
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
fi

if [ "$djia" == "true" ]; then
	source content-generators/finance/scrapers/market.sh index djia
	source content-generators/finance/view.sh
fi

if [ "$nasdaq" == "true" ]; then
	source content-generators/finance/scrapers/market.sh index comp
	source content-generators/finance/view.sh
fi

if [ "$oil" == "true" ]; then
	source content-generators/finance/scrapers/market.sh future "crude%20oil%20-%20electronic"
	source content-generators/finance/view.sh
fi

metals=( "au" "ag" "pt" "pd" )
for i in "${!metals[@]}"; do
	metal=${metals[$i]}

	if [ ${!metal} == "true" ]; then
		source content-generators/finance/scrapers/metal.sh "$metal"
	fi
done

cryptos=( "btc" "eth" "xlm" "xrp" )
for i in "${!cryptos[@]}"; do
	crypto=${cryptos[$i]}

	if [ ${!crypto} == "true" ]; then
		source content-generators/finance/scrapers/crypto.sh "$crypto"-usd
	fi
done

equityType=(   "fund" "stock" "stock" "stock" "stock" "stock" "fund")
equityTicker=( "huv"  "pea"   "lcid"  "rvin"  "duol"  "abt"   "hack")
equityMarket=( "ca"   "ca"    "us"    "us"    "us"    "us"    "us")

for i in "${!equityType[@]}"; do
	type=${equityType[$i]}
	ticker=${equityTicker[$i]}
	market=${equityMarket[$i]}

	isTickerEnabled=`cat settings.json | grep -E "\"${ticker}\":" | cut -d":" -f2 | tr -d ",[:space:]"`

	if [ "$isTickerEnabled" == "true" ]; then
		source content-generators/finance/scrapers/market.sh "$type" "$ticker" "$market"
		source content-generators/finance/view.sh
	fi
done
