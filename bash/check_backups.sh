servers=(2 8 3 9 4 10)

echo "Последние бэкапы серверов:"
for server in ${servers[@]}
do
        count=$(du -sh /opt/support/192.168.52.$server/* | grep $(date +"%F") | wc -l)
        echo "ip.$server($count): "
        du -sh /opt/support/ip.$server/* | grep $(date +"%F") | awk -F"/" '{ print " - " $1 $5 }'
done
