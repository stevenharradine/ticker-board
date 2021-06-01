tickertype=$1
bash ~/ticker-board/prep.sh $tickertype
ps -aux | grep demo | grep -v grep | awk '{print $2}' | sudo xargs kill -9
cd ~/rpi-rgb-led-matrix/examples-api-use
sudo ./demo -D 1 ticker.ppm -m 10 --led-cols=64 --led-gpio-mapping=adafruit-hat --led-chain=7
