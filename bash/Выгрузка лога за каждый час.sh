#!/bin/bash
# 1) Выгружаем из логи за каждый час 
for (( i=0; i<10; i++ ))
do	
	touch /tmp/$i-00.txt
	sudo cat /var/log/nginx/access.log | grep "17/Jul/2020:0$i" >> /tmp/$i-00.txt	
	echo "kol-vo zaprosov za chas: `cat /tmp/$i-00.txt | wc -l`" >> /tmp/result.txt 	
	echo "kol-vo uniq ip: `cat /tmp/$i-00.txt | awk -F" - - " ' {  print $1} ' | sort | uniq -c | wc -l`" >> /tmp/result.txt 	
	echo "$i --------------------------------"
done

for (( i=10; i<14; i++ ))
do
        touch /tmp/$i-00.txt
        sudo cat /var/log/nginx/access.log | grep "17/Jul/2020:$i" >> /tmp/$i-00.txt
        echo "kol-vo zaprosov za chas: `cat /tmp/$i-00.txt | wc -l`" >> /tmp/result.txt                             
        echo "kol-vo uniq ip: `cat /tmp/$i-00.txt | awk -F" - - " ' {  print $1} ' | sort | uniq -c | wc -l`" >> /tmp/result.txt    
        echo "$i --------------------------------"

done
