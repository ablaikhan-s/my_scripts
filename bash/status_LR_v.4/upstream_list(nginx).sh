##################################################################
##################################################################
##################################################################
########### Created by Ablaikhan Saparov ######################### 
##################################################################
##################################################################
##################################################################
#!/bin/bash
NGINX_CONF=conf.conf
ORIGINAL_CONF=nginx.conf
TEMP_CONF=temp.conf
TEMP_FILE=tmp.txt
TEMP_FILE2=tmp2.txt
TABLE_1=table1.txt
TABLE_2=table2.txt
script2=upstream_status.sh
	###Создали копию конфига nginx с нумерацией строк
rm -rf $NGINX_CONF; touch $NGINX_CONF
rm -rf $TABLE_1; touch $TABLE_1
upstream_count=0
count=1
looking_endline="0" # Значение по умолчанию. Означает что мы ищем Начало апстрима
while read line  
do 
	if [ -z "$line" ] # Это просто чтобы пробелы не записывались из nginx.conf в conf.conf
	then echo "" | grep -v ""
	else
		echo "line-$count: $line" >> $NGINX_CONF
		echo "line-$count: $line" > $TEMP_FILE 
		count=$(( count + 1 ))
		if [[ $looking_endline = "0" ]]
		then
			TEMP_TEXT=`cat $TEMP_FILE| grep upstream | grep "{" | awk -F"{" '{ print $1 }' | grep -v "#" ` # Находит номер строки где открывается апстрим, именно не закоментированную строку 
			if [ -z "$TEMP_TEXT"  ] 
			then echo "." | grep -v "."
			else 
				#Line_number=`cat $TEMP_FILE | grep upstream | awk -F" " '{ print $1 }'`
				Line_number1=`cat $TEMP_FILE | grep upstream | awk -F" " '{ print $1 }' | awk -F":" '{ print $1 }' | awk -F"line-" '{ print $2 }'`
				Upstream_name=`cat $TEMP_FILE | grep upstream | awk -F" " '{ print $3 }'`
				#echo "$Line_number1$Upstream_name " >> $TABLE_1
				looking_endline="1" # Значение 1. Означает что начало есть, теперь мы ищем конец апстрима 
			fi
		fi
		if [[ $looking_endline = "1" ]]
		then
			TEMP_TEXT=`cat $TEMP_FILE | grep "}" | awk -F"}" '{ print $1 }' | grep -v "#" ` # Находит номер строки где закрывается апстрим, именно не закоментированную строку 
			if [ -z "$TEMP_TEXT"  ]
			then echo "." | grep -v "."
			else
				Line_number2=`cat $TEMP_FILE | grep "}" | awk -F" " '{ print $1 }' | awk -F":" '{ print $1 }' | awk -F"line-" '{ print $2 }'`
				echo "$Line_number1:$Line_number2:$Upstream_name" >> $TABLE_1
				upstream_count=$(( upstream_count + 1 ))
				looking_endline="0"
			fi
		else echo "." | grep -v "."
		fi 
	fi
done < $ORIGINAL_CONF # Что мы сделали: нашли начальные и конечные строки и имена всех апстримов(!!!)
	### Теперь для выяснения статуса отдельного апстрима с помощью другого скрипта(upstream_status.sh), из имеющих апстримов делаем входной файл (для upstream_status.sh)
while read line
do 	
	rm -rf $TEMP_FILE; touch $TEMP_FILE; echo $line > $TEMP_FILE
	rm -rf $TEMP_CONF; touch $TEMP_CONF
	Line_number1=`cat $TEMP_FILE | awk -F":" '{ print $1 }'`
	Line_number2=`cat $TEMP_FILE | awk -F":" '{ print $2 }'`
	Upstream_name=`cat $TEMP_FILE | awk -F":" '{ print $3 }'`
	echo $Upstream_name > Upstream_name.txt
#	echo $Line_number1; echo $Line_number2; echo $Upstream_name;
	Line_count=$(( $Line_number2-$Line_number1+1))
	cat $NGINX_CONF | head -n $Line_number2 | tail -n $Line_count >> $TEMP_CONF
	cat $NGINX_CONF | awk -F"line-" ' { print $2} ' | head -n $Line_number2 | tail -n $Line_count

	bash $script2
	sleep 1
done < $TABLE_1
