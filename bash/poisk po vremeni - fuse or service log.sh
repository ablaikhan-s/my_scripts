#!/bin/bash
hours=(12 13 14)
min=()
sec=()
for (( m=0; m<10; m++ ))
do
min+=(0$m)
sec+=(0$m)
done
for (( m=10; m<60; m++ ))
do
min+=($m)
sec+=($m)
done

#echo ${hours[@]}
#echo ${min[@]}
#echo ${sec[@]}

for item in `find /opt/fuse-vshep/data/log/ -name fuse.lo*`
do
tester1=`head -n1 $item | awk -F":" ' { print $1 } ' | grep -e 09 -e 10 -e 11 -e 12 -e 13 -e 14`      # Esli log fail nachinaetsya pozdnee, chem nuzhno nam,to perehodim na drug
oi fail
if [[  -z $tester ]]
then
        tester2=`head -n1 $item | awk -F":" ' { print $1 } ' `
        echo "not found in $item : tester $tester2" 
#       echo "-" | sed "s/-//g"  
else
        echo $item  
        while read line1
        do
                echo $line1 | awk -F":" ' { print $1 } ' | grep -e 12 -e 13 -e 14
        done < $item
fi
done
