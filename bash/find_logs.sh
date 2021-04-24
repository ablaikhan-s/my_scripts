#!/bin/bash 

############################################################
HOME="/home/support"
DATE=$(date +%Y%m%d)
file_name="find_logs_$DATE.log"
############################################################

array=()
count=0
for item in `find /var/log/nginx/ -name *access*.gz`
do
array+=($item)
done

count=${#array[@]}

for ((i=0; i<$count; i++))
do
#echo ${array[$i]}
sudo zcat ${array[$i]} |grep "$1">> /home/support/$file_name
done

