#!bin/bash
array=()
for server in `find /opt/support/ -name IP*`
do
array+=($server)
done

# echo "*****************************" Все это нужна только для сортировки
rm -rf temp1.txt
tmp=temp1.txt
for y in ${array[@]}
do
        echo $y >> $tmp
done
array=('')
tmp_text=`cat $tmp | sort`
for line in $tmp_text
do
        array+=($line)
done
# echo "*****************************"

echo "Последние бэкапы серверов:"
for ((i=1; i<7; i++))
do
tmp=`echo ${array[$i]} | awk -F"/" ' { print $4 } '`
echo "$tmp:"
for backup in `find ${array[$i]} -mtime -1 | grep -v "logs" | grep .tgz `
do
tmp=`echo $backup  | awk -F"/" ' { print $5 } '`
echo " - $tmp"
done
done
