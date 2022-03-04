size="32px"

source content-generators/finance/scrapers/market.sh currency usdcad
cad2usd="$price"
unitSign="$"
image="$"
source content-generators/finance/view.sh

if [ `cat finance-settings.json | jq '.markets[] | select(.ticker == "tsx").enabled'` == "true" ]; then
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

if [ `cat finance-settings.json | jq '.markets[] | select(.ticker == "djia").enabled'` == "true" ]; then
	source content-generators/finance/scrapers/market.sh index djia
	source content-generators/finance/view.sh
fi

if [ `cat finance-settings.json | jq '.markets[] | select(.ticker == "nasdaq").enabled'` == "true" ]; then
	source content-generators/finance/scrapers/market.sh index comp
	source content-generators/finance/view.sh
fi

if [ `cat finance-settings.json | jq '.commodities[] | select(.ticker == "oil").enabled'` == "true" ]; then
	source content-generators/finance/scrapers/market.sh future "crude%20oil%20-%20electronic"
	source content-generators/finance/view.sh
fi

# Metals
numberOfMetals=`cat finance-settings.json | jq '.metals' | jq length`
metals=()
metalsEnabled=()
for (( i = 0; i < numberOfMetals; i++ )); do
	ticker=`cat finance-settings.json | jq '.metals['$i']' | jq '.ticker' | cut -d "\"" -f 2`
	enabled=`cat finance-settings.json | jq '.metals['$i']' | jq '.enabled'`

	metals+=($ticker)
	metalsEnabled+=($enabled)
done

for i in "${!metals[@]}"; do
	metal=${metals[$i]}

	if [ ${metalsEnabled[$i]} == "true" ]; then
		source content-generators/finance/scrapers/metal.sh "$metal"
	fi
done

# Cryptos
numberOfCryptos=`cat finance-settings.json | jq '.cryptos' | jq length`
cryptos=()
for (( i = 0; i < numberOfCryptos; i++ )); do
	ticker=`cat finance-settings.json | jq '.cryptos['$i']' | jq '.ticker' | cut -d "\"" -f 2`
	enabled=`cat finance-settings.json | jq '.cryptos['$i']' | jq '.enabled'`

	cryptos+=($ticker)
	cryptosEnabled+=($enabled)
done

for i in "${!cryptos[@]}"; do
	crypto=${cryptos[$i]}

	if [ ${cryptosEnabled[$i]} == "true" ]; then
		source content-generators/finance/scrapers/crypto.sh "$crypto"-usd
	fi
done

# Stocks
numberOfStocks=`cat finance-settings.json | jq '.stocks' | jq length`
types=()
tickers=()
markets=()
stocksEnabled=()
for (( i = 0; i < numberOfStocks; i++ )); do
	type=`cat finance-settings.json | jq '.stocks['$i']' | jq '.type' | cut -d "\"" -f 2`
	ticker=`cat finance-settings.json | jq '.stocks['$i']' | jq '.ticker' | cut -d "\"" -f 2`
	market=`cat finance-settings.json | jq '.stocks['$i']' | jq '.market' | cut -d "\"" -f 2`
	enabled=`cat finance-settings.json | jq '.stocks['$i']' | jq '.enabled'`

	types+=($type)
	tickers+=($ticker)
	markets+=($market)
	stocksEnabled+=($enabled)
done

for i in "${!types[@]}"; do
	type=${types[$i]}
	ticker=${tickers[$i]}
	market=${markets[$i]}

	if [ ${stocksEnabled[$i]} == "true" ]; then
		source content-generators/finance/scrapers/market.sh "$type" "$ticker" "$market"
		source content-generators/finance/view.sh
	fi
done
