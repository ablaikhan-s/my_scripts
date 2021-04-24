##################################################################
##################################################################
##################################################################
########### Created by Ablaikhan Saparov ######################### 
##################################################################
##################################################################
##################################################################
#!/bin/bash
Upstream_name=`cat Upstream_name.txt`
NGINX_CONF=temp.conf
script_dir=`pwd`
TEMP_FILE=$script_dir/tmp2.txt
TEMP_CONF=conf2.conf 
TEMP_TEXT=" "
TEMP_ARRAY=()
DATE=$(date +"%D %T")
rm -rf table-$Upstream_name; touch table-$Upstream_name
TABLE_1=table-$Upstream_name
TABLE_2=table1.txt


# Вычисляем количество серверов и их айпи

TEMP_TEXT=`cat $NGINX_CONF | grep ":80" | awk ' /'server\ 192.168.17'/ {print $0} '`
echo "" > $TEMP_FILE 
for word in $TEMP_TEXT 
do
echo $word >> $TEMP_FILE 
done
sed -i "s/:80;//g" $TEMP_FILE
servers=`cat $TEMP_FILE | grep 192.168.17` 
count=`cat $TEMP_FILE | grep 192.168.17 | wc -l `
echo "" > $TEMP_FILE
cat $NGINX_CONF | awk ' /'server\ 192.168.17'/ {print $0} ' | awk -F";" '{ print $1 }' >> $TEMP_FILE


rm -rf $TABLE_1
touch $TABLE_1
for server in $servers
do
	TEMP_TEXT=`cat $TEMP_FILE | grep $server | grep -v "#"`
	if [ -z "$TEMP_TEXT" ] 
	then 
		STATUS=off
		TEMP_TEXT=`cat $TEMP_FILE | grep $server | grep -v "192.168.175"`
		if   [ -z "$TEMP_TEXT" ]
		then 
			SHOULDER=L
			echo "$server-$STATUS-$SHOULDER" >> $TABLE_1	
		else 
			SHOULDER=R	
			echo "$server-$STATUS-$SHOULDER" >> $TABLE_1
		fi
	else
                STATUS=on
                TEMP_TEXT=`cat $TEMP_FILE | grep $server | grep -v "192.168.175"`
                if   [ -z "$TEMP_TEXT" ]
                then
                        SHOULDER=L
                        echo "$server-$STATUS-$SHOULDER" >> $TABLE_1
                else 
                        SHOULDER=R      
                        echo "$server-$STATUS-$SHOULDER" >> $TABLE_1
                fi

	fi
done

#echo "--------------------------------------------"
TEMP_TEXT=`awk -F"-" ' {print $3 "=" $2 } ' $TABLE_1`
#echo "table.txt: "
#awk -F"-" ' {print $3 "=" $2 } ' $TABLE_1
#echo "TEMP_TEXT: $TEMP_TEXT"
echo ""> $TEMP_FILE
for line in $TEMP_TEXT
do
	echo $line >> $TEMP_FILE
done
#echo tmp2.txt:
#cat $TEMP_FILE 	
	TEMP_TEXT=`cat $TEMP_FILE | grep -v "off" | grep -v "R" ` # Ищем левое плечо в бою
	if   [ -z "$TEMP_TEXT" ]
	then 
		TEMP_TEXT=`cat $TEMP_FILE | grep -v "off" | grep -v "L" ` # Ищем правое плечо в бою
		if   [ -z "$TEMP_TEXT" ]
		then STATUS_LR="NULL"
		else STATUS_LR="RIGHT"
		fi
	else 
		TEMP_TEXT=`cat $TEMP_FILE | grep -v "off" | grep -v "L" ` # Ищем правое плечо в бою
		if   [ -z "$TEMP_TEXT" ]
		then STATUS_LR="LEFT"
		else STATUS_LR="BOTH"
		fi
	fi

echo "Статус апстрима '$Upstream_name': $STATUS_LR"
echo "----------------------------"
rm -rf CMS_Статус_абстрима_$Upstream_name
touch CMS_Статус_абстрима_$Upstream_name
echo $STATUS_LR > CMS_Статус_абстрима_$Upstream_name