# ticker-board
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Tests](https://github.com/stevenharradine/ticker-board/actions/workflows/tests.yaml/badge.svg)](https://github.com/stevenharradine/ticker-board/actions/workflows/tests.yaml)

Displays information on the adafruit led matrix display.  This project works by stitching together other images into a long ticker which is then displayed using hzeller's rpi-rgb-led-matrix repo.

-- ONLY RUN THIS ON A SECURE NETWORK --

## Requirements
 * https://github.com/hzeller/rpi-rgb-led-matrix
 * imagemagick
 * jq
 * LED matrix panel (https://www.adafruit.com/product/2276)

## Usage

### Expand basic fonts
Generates red and green fonts in the existing sizes and resizes all fonts (including white) down to smaller sizes.
```
./expand-fonts.sh
```

### Generate ticker content

### Generate ticker image

### Run the image across the ticker
