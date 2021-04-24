#!/bin/bash
clear

tmp=`ps -ef |  awk ' { print $8 }  ' | grep nginx |  uniq`
if [ -z $tmp ]
then
        echo "nginx: OFF"      
else echo "nginx: ON"
fi

tmp=`ps -ef | grep -e php-fpm | grep -v grep | grep master | awk ' { print $9 }  ' |  uniq`
if [ -z $tmp ]
then
        echo "php-fpm: OFF"      
else echo "php-fpm: ON"
fi

tmp=`ps -ef | grep -e SignSoap | grep -v grep | awk ' { print $8 }  ' |  uniq`
if [ -z $tmp ]
then
        echo "SignSoap: OFF"      
else echo "SignSoap: ON"
fi

tmp=`df -h | grep "/dev/mapper/cl-root" | awk -F"%" ' { print $1 } ' | awk -F" " ' { print $5 } '`
        echo "Корень забит на $tmp%" 

tmp=`free -h | grep Mem | awk ' { print $4 " ОЗУ из " $2 } '`
        echo "Используется $tmp" 
