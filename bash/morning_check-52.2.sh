#!/bin/bash
clear
tmp=`ip a | grep -e VIP | grep -v grep | awk ' { print $2  }  '`
if [ -z $tmp ]
then
        echo "VIP: OFF"      
else echo "VIP: ON"
fi

PPO1=('sic-backend' 'haproxy' 'nginx')
for PO1 in ${PPO1[@]}
do
	tmp=`ps -ef | grep -e $PO1 | grep -v grep | awk ' { print $8 }  ' |  uniq`	
	if [ -z $tmp ]
	then
        	echo "$PO1: OFF"       
	else echo "$PO1: ON"
	fi
done

PPO2=('sic_backend' 'haproxy' 'nginx')
for PO2 in ${PPO2[@]} 
do
	tmp=`find /opt/support/backups -mtime -1 | grep $PO2 |  awk -F"/" '{ print $5 }' | awk -F"files_" '{ print $2 }' | awk -F"." '{ print $1 }'`
	echo "Дата последнего бэкапа $PO2: $tmp"
done

tmp=`df -h | grep "/dev/mapper/rhel-root" | awk -F"%" ' { print $1 } ' | awk -F" " ' { print $5 } '`
	echo "Корень забит на $tmp%"      


tmp=`free -h | grep Mem | awk ' { print $4 " ОЗУ из " $2 } '`
        echo "Используется $tmp" 

uptime | awk -F":" '{ print "load average: " $5}'
