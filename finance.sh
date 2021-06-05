size="32px"

echo -n "USD/CAD "
cache=`bash scripts/market-scraper.sh currency usdcad`
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
source scripts/market-scraper.sh index djia

echo -n "NASDAQ "
source scripts/market-scraper.sh index comp

echo -n "Oil "
source scripts/market-scraper.sh future "crude%20oil%20-%20electronic"

echo -n "Gold <image:images/finance/$size/gold.gif> "
source scripts/metal-scraper.sh AU

echo -n "Silver <image:images/finance/$size/silver.gif> "
source scripts/metal-scraper.sh AG

echo -n "Platinum <image:images/finance/$size/platinum.gif> "
source scripts/metal-scraper.sh PT

echo -n "BTC <image:images/finance/$size/btc.gif> "
source scripts/crypto-scraper.sh btc-usd

echo -n "ETH <image:images/finance/$size/eth.gif> "
source scripts/crypto-scraper.sh eth-usd

echo -n "XLM <image:images/finance/$size/xlm.gif> "
source scripts/crypto-scraper.sh xlm-usd

echo -n "XRP <image:images/finance/$size/xrp.gif> "
source scripts/crypto-scraper.sh xrp-usd
