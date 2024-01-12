#!/bin/bash

echo "Creating run script ..."

cp run.sh /usr/local/bin/auto_record.sh
chmod +x /usr/local/bin/auto_record.sh


echo "Creating and runing service ..."

cp auto_record.service /etc/systemd/system/auto_record.service
systemctl enable auto_record.service
systemctl start auto_record.service

echo
echo "Done!"