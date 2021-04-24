#!/bin/bash
clear

tmp=`ip a | grep "inet ip" | awk '{ print $2 }'`
echo "ip: $tmp"

tmp=`df -h | grep "/dev/mapper/centos-root" | awk -F"%" ' { print $1 } ' | awk -F" " ' { print $5 } '`
        echo "Корень забит на $tmp%" 

for (( i=1; i<6; i++ ))
do
        tmp=`ps -ef | grep standalone$i | grep -v grep | awk '{ print $1 }' | sort | uniq `
        if [ -z $tmp ]
                then
                        echo "standalone$i: OFF"      
                else
                        echo "standalone$i: ON"
        fi
done

tmp=`find /var/local/backup/ -mtime -6 | grep wildfly | awk -F"/" '{ print $5 }' | awk -F"_" '{ print $4 }' | awk -F"." '{ print $1 }'`
echo "Дата последнего бэкапа $tmp"

tmp=`free -h | grep Mem | awk ' { print $4 " ОЗУ из " $2 } '`
        echo "Используется $tmp" 

uptime | awk -F":" '{ print "load average: " $5}'