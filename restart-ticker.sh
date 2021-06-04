tickertype=$1
ticker_time_step_ms=`cat settings.json | grep "\"ticker-time-step-ms\":" | cut -d":" -f2 | tr -d ",[:space:]"`
led_cols=`cat settings.json | grep "\"led-cols\":" | cut -d":" -f2 | tr -d ",[:space:]"`
led_gpio_mapping=`cat settings.json | grep "\"led-gpio-mapping\":" | cut -d":" -f2 | tr -d ",[:space:]\""`
led_chain=`cat settings.json | grep "\"led-chain\":" | cut -d":" -f2 | tr -d ",[:space:]"`

arguments="-D 1 ticker.ppm -m $ticker_time_step_ms --led-cols=$led_cols --led-gpio-mapping=$led_gpio_mapping --led-chain=$led_chain"

echo $arguments

bash ~/ticker-board/prep.sh $tickertype
ps -aux | grep demo | grep -v grep | awk '{print $2}' | sudo xargs kill -9
cd ~/rpi-rgb-led-matrix/examples-api-use
sudo ./demo $arguments
