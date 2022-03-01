size="32px"

tsx=`cat settings.json | grep "\"tsx\":" | cut -d":" -f2 | tr -d ",[:space:]"`
djia=`cat settings.json | grep "\"djia\":" | cut -d":" -f2 | tr -d ",[:space:]"`
nasdaq=`cat settings.json | grep "\"nasdaq\":" | cut -d":" -f2 | tr -d ",[:space:]"`
gold=`cat settings.json | grep "\"gold\":" | cut -d":" -f2 | tr -d ",[:space:]"`
silver=`cat settings.json | grep "\"silver\":" | cut -d":" -f2 | tr -d ",[:space:]"`
platinum=`cat settings.json | grep "\"platinum\":" | cut -d":" -f2 | tr -d ",[:space:]"`
palladium=`cat settings.json | grep "\"palladium\":" | cut -d":" -f2 | tr -d ",[:space:]"`
btc=`cat settings.json | grep "\"btc\":" | cut -d":" -f2 | tr -d ",[:space:]"`
eth=`cat settings.json | grep "\"eth\":" | cut -d":" -f2 | tr -d ",[:space:]"`
xrp=`cat settings.json | grep "\"xrp\":" | cut -d":" -f2 | tr -d ",[:space:]"`
xlm=`cat settings.json | grep "\"xlm\":" | cut -d":" -f2 | tr -d ",[:space:]"`
huv=`cat settings.json | grep "\"huv\":" | cut -d":" -f2 | tr -d ",[:space:]"`
pea=`cat settings.json | grep "\"pea\":" | cut -d":" -f2 | tr -d ",[:space:]"`
lcid=`cat settings.json | grep "\"lcid\":" | cut -d":" -f2 | tr -d ",[:space:]"`

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

if [ "$gold" == "true" ]; then
	source content-generators/finance/scrapers/metal.sh AU
fi

if [ "$silver" == "true" ]; then
	source content-generators/finance/scrapers/metal.sh AG
fi

if [ "$platinum" == "true" ]; then
	source content-generators/finance/scrapers/metal.sh PT
fi

if [ "$palladium" == "true" ]; then
	source content-generators/finance/scrapers/metal.sh PD
fi

if [ "$btc" == "true" ]; then
	source content-generators/finance/scrapers/crypto.sh btc-usd
fi

if [ "$eth" == "true" ]; then
	source content-generators/finance/scrapers/crypto.sh eth-usd
fi

if [ "$xlm" == "true" ]; then
	source content-generators/finance/scrapers/crypto.sh xlm-usd
fi

if [ "$xrp" == "true" ]; then
	source content-generators/finance/scrapers/crypto.sh xrp-usd
fi

if [ "$huv" == "true" ]; then
	source content-generators/finance/scrapers/market.sh fund "huv" ca
	source content-generators/finance/view.sh
fi

if [ "$pea" == "true" ]; then
	source content-generators/finance/scrapers/market.sh stock "pea" ca
	source content-generators/finance/view.sh
fi

if [ "$lcid" == "true" ]; then
	source content-generators/finance/scrapers/market.sh stock "lcid"
	source content-generators/finance/view.sh
fi
