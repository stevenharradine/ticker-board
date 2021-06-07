size="32px"

echo -n "USD/CAD "
cache=`bash content-generators/finance/scrapers/market.sh currency usdcad`
cad2usd=`echo "$cache" | cut -d" " -f1`
echo -n "$cache"

url=https://www.
url=$url"spgl"
url=$url"obal.com/spd"
url=$url"ji/en/indices/equity/sp-ts"
url=$url"x-comp"
url=$url"osite-index/#overview"
cache=`curl --silent $url`
tsx=`echo "$cache" | grep published-value | grep -o [.,0-9]* | tr -d ","`
tsx_percent=`echo "$cache" | grep daily-change | cut -d">" -f2 | grep -o [\-+.0-9]*`
printf "TSX %'.2f " $tsx
if [ "`echo \"$tsx_percent > 0\" | bc`" = "1" ]; then
	echo -n "<color:green>"
fi
if [ "`echo \"$tsx_percent < 0\" | bc`" = "1" ]; then
	echo -n "<color:red>"
fi
echo -n "($tsx_percent%)<color:white>    "

echo -n "DJIA "
source content-generators/finance/scrapers/market.sh index djia

echo -n "NASDAQ "
source content-generators/finance/scrapers/market.sh index comp

echo -n "Oil "
source content-generators/finance/scrapers/market.sh future "crude%20oil%20-%20electronic"

echo -n "Gold <image:images/finance/$size/gold.gif> "
source content-generators/finance/scrapers/metal.sh AU

echo -n "Silver <image:images/finance/$size/silver.gif> "
source content-generators/finance/scrapers/metal.sh AG

echo -n "Platinum <image:images/finance/$size/platinum.gif> "
source content-generators/finance/scrapers/metal.sh PT

echo -n "BTC <image:images/finance/$size/btc.gif> "
source content-generators/finance/scrapers/crypto.sh btc-usd

echo -n "ETH <image:images/finance/$size/eth.gif> "
source content-generators/finance/scrapers/crypto.sh eth-usd

echo -n "XLM <image:images/finance/$size/xlm.gif> "
source content-generators/finance/scrapers/crypto.sh xlm-usd

echo -n "XRP <image:images/finance/$size/xrp.gif> "
source content-generators/finance/scrapers/crypto.sh xrp-usd
