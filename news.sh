url=https://www.
url=$url"cb"
url=$url"c.ca/cm"
url=$url"link/rss-top"
url=$url"stories"

stories=`curl $url | grep "<title>" | grep CDATA | head -n 10 | cut -d"[" -f3 | cut -d"]" -f1`

while IFS= read -r line; do
    echo -n "$line    "
done <<< "$stories"
