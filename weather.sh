#!/bin/bash
size="32px"

weatherCache=`curl --silent https://weather.gc.ca/wxlink/site_js/s0000707_e.js`

location=`echo "$weatherCache" | grep cityName | cut -d'=' -f2 | grep -o "[a-zA-Z[:space:]]*"`
tempature=`echo "$weatherCache" | grep obTemperature | cut -d'=' -f2 | grep -o "[0-9]*"`
condition=`echo "$weatherCache" | grep obCondition | cut -d'=' -f2 | grep -o "[a-zA-Z[:space:]]*"`
iconCode=`echo "$weatherCache" | grep obIconCode | cut -d'=' -f2 | grep -o "[0-9]*"`

forecastPeriodsLine=`echo "$weatherCache" | grep forecastPeriods`
forecastPeriodsSegments=`echo "$forecastPeriodsLine" | cut -d'=' -f2`
forecastPeriodsOne=`echo "$forecastPeriodsSegments" | cut -d',' -f1 | grep -o "[a-zA-Z[:space:]]*"`
forecastPeriodsTwo=`echo "$forecastPeriodsSegments" | cut -d',' -f2 | grep -o "[a-zA-Z[:space:]]*"`
forecastPeriodsThree=`echo "$forecastPeriodsSegments" | cut -d',' -f3 | grep -o "[a-zA-Z[:space:]]*"`

forecastConditionsLine=`echo "$weatherCache" | grep forecastConditions`
forecastConditionsSegments=`echo "$forecastConditionsLine" | cut -d'=' -f2`
forecastConditionsOne=`echo "$forecastConditionsSegments" | cut -d',' -f1 | grep -o "[a-zA-Z[:space:]]*"`
forecastConditionsTwo=`echo "$forecastConditionsSegments" | cut -d',' -f2 | grep -o "[a-zA-Z[:space:]]*"`
forecastConditionsThree=`echo "$forecastConditionsSegments" | cut -d',' -f3 | grep -o "[a-zA-Z[:space:]]*"`

forecastHighsLine=`echo "$weatherCache" | grep forecastHighs`
forecastHighsSegments=`echo "$forecastHighsLine" | cut -d'=' -f2`
forecastHighsOne=`echo "$forecastHighsSegments" | cut -d',' -f1 | grep -o "[0-9]*"`
forecastHighsTwo=`echo "$forecastHighsSegments" | cut -d',' -f2 | grep -o "[0-9]*"`
forecastHighsThree=`echo "$forecastHighsSegments" | cut -d',' -f3 | grep -o "[0-9]*"`

forecastLowsLine=`echo "$weatherCache" | grep forecastLows`
forecastLowsSegments=`echo "$forecastLowsLine" | cut -d'=' -f2`
forecastLowsOne=`echo "$forecastLowsSegments" | cut -d',' -f1 | grep -o "[0-9]*"`
forecastLowsTwo=`echo "$forecastLowsSegments" | cut -d',' -f2 | grep -o "[0-9]*"`
forecastLowsThree=`echo "$forecastLowsSegments" | cut -d',' -f3 | grep -o "[0-9]*"`

forecastIconCodesLine=`echo "$weatherCache" | grep forecastIconCodes`
forecastIconCodesSegments=`echo "$forecastIconCodesLine" | cut -d'=' -f2`
forecastIconCodesOne=`echo "$forecastIconCodesSegments" | cut -d',' -f1 | grep -o "[0-9]*"`
forecastIconCodesTwo=`echo "$forecastIconCodesSegments" | cut -d',' -f2 | grep -o "[0-9]*"`
forecastIconCodesThree=`echo "$forecastIconCodesSegments" | cut -d',' -f3 | grep -o "[0-9]*"`

echo -n $location"    "
echo -n Now "<"images/weather/$size/$iconCode.gif">" $condition $tempature°C"    "
echo -n $forecastPeriodsOne "<"images/weather/$size/$forecastIconCodesOne.gif">" $forecastConditionsOne $forecastHighsOne$forecastLowsOne°C"    "
echo -n $forecastPeriodsTwo "<"images/weather/$size/$forecastIconCodesTwo.gif">" $forecastConditionsTwo $forecastHighsTwo$forecastLowsTwo°C"    "
echo -n $forecastPeriodsThree "<"images/weather/$size/$forecastIconCodesThree.gif">" $forecastConditionsThree $forecastHighsThree$forecastLowsThree°C"    "