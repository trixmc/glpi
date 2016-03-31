#!/bin/bash
service ssh start
service mysql start
service apache2 start
cd /var/www/ && tar -zxvf glpi-0.90.1.tar.gz
mv /root/autostart /root/autostart.sh