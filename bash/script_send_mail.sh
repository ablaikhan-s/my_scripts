#!/bin/bash
cd /opt/backups
#echo "To:ablaikhan.saparov@kz, nurzhan.abdurakhmanov@kz" > /tmp/mailbody_rp
echo "To:ablaikhan.saparov@kz" > /tmp/mailbody_rp
echo "Subject:<Бэкапы, СПП, 52.3, pentaho, postgres" >> /tmp/mailbody_rp
echo "">>/tmp/mailbody_rp
DATE=$(date +"%F")
count=$(du -ahd1 | grep $DATE | wc -l)
echo "Количество бэкапов:" $count>>/tmp/mailbody_rp
du -ahd1 | grep $DATE >>/tmp/mailbody_rp
echo " ">>/tmp/mailbody_rp
#/usr/sbin/sendmail.postfix ablaikhan.saparov@kz< /tmp/mailbody_rp
echo "To:ablaikhan.saparov@kz" > /tmp/mailbody_rp
