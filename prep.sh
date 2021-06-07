cd ~/ticker-board
bash writer.sh "`bash content-generators/$1.sh`"
cp ticker.ppm ~/rpi-rgb-led-matrix/examples-api-use/
