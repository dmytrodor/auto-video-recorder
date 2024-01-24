#!/bin/bash

echo "Creating run scripts ..."

# video recorder
cp run.sh /usr/local/bin/auto_record.sh
chmod +x /usr/local/bin/auto_record.sh

# recording status
cp bleeper.sh /usr/local/bin/bleeper.sh
chmod +x /usr/local/bin/bleeper.sh

echo "Creating and runing services ..."

cp auto_record.service /etc/systemd/system/auto_record.service
cp ffmpeg_bleeper.service /etc/systemd/system/ffmpeg_bleeper.service

systemctl enable auto_record.service
systemctl enable ffmpeg_bleeper.service

systemctl start auto_record.service
systemctl start ffmpeg_bleeper.service

echo "\nDone!"