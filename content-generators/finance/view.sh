echo -n "<break:new><size:16px>$title<break:line>$unitSign"

if [ "$convertUSD2CAD" = "true" ]; then
	echo "$price * $cad2usd" | bc | xargs printf "%'.2f"
else
	echo "$price"
fi

echo -n "<break:new><size:32px> $image <break:new><size:16px>"

if [ "`echo \"$change > 0\" | bc`" = "1" ] && [ "`echo \"$percent > 0\" | bc`" = "1" ]; then
	echo -n "<color:green>"
fi
if [ "`echo \"$change < 0\" | bc`" = "1" ] && [ "`echo \"$percent < 0\" | bc`" = "1" ]; then
	echo -n "<color:red>"
fi

echo -n "$unitSign"
if [ "$convertUSD2CAD" = "true" ]; then
	echo "$change * $cad2usd" | bc | xargs printf "%'.2f"
else
	echo "$change"
fi
echo -n "<break:line>($percent%)<break:new><size:32px><color:white>    "