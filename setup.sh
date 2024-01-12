#!/bin/bash

echo "-------------------------------"
echo "Creating run script"
echo "-------------------------------"

cp run.sh /usr/local/bin/auto_record.sh
chmod +x /usr/local/bin/auto_record.sh

echo "-------------------------------"
echo "Creating and runing service"
echo "-------------------------------"

cp auto_record.service /etc/systemd/system/auto_record.service
systemctl enable auto_record.service
systemctl start auto_record.service

echo
echo "Done!"