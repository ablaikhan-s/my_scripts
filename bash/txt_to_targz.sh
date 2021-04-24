#!/bin/bash
array=()
count=0
months=('06' '07' '08' '09')

for month in ${months[@]}
do

for item in `find /mnt/nfsstorage/MDB/logs/ -name nlog-all-2020-$month*.log`
do
array+=($item)
echo "tar $item"
sudo tar -zcvf $item-tar.tgz $item
done

for item2 in `find /mnt/nfsstorage/MDB/logs/ -name nlog-all-2020-$month*.log`
do
array+=($item2)
echo "rm $item2"
sudo rm -rf $item2
done

done
