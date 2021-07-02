#!/bin/bash
echo $(TZ=":America/Cordoba" date +"%Y-%m-%d,%T")\
" "$(/opt/vc/bin/vcgencmd measure_temp | cut -c 6-9)\
" "$(python3 /home/pi/plottemp/sensor.py)\
>> /home/pi/plottemp/tempdata.dat

sleep 3

echo "set terminal png size 1200, 400
set xdata time
set xrange [ time(0) - 97200 : time(0) - 10800 ]    # 86400 sec = 1 day / 10800 = 3 hours
set timefmt '%Y-%m-%d,%H:%M:%S'
set grid ytics lt 0 lw 1 lc rgb '#880000'
set format x '%H:%M'
set output '/home/pi/shared/raspi-temp-dht11.png'
plot '/home/pi/plottemp/tempdata.dat' using 1:2 with impulses lt rgb '#E83E1A' title 'System temp' , \
     '/home/pi/plottemp/tempdata.dat' using 1:3 with impulses lt rgb '#1F9F4A' title 'Real temp' " \
| gnuplot
# 'tempdata.dat' title 'humidity' using 1:4 with lines axis x1y2" \
