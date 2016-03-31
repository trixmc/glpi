#!/bin/bash
service ssh start
service mysql start
service apache2 start
cd /var/www/ && tar -zxvf glpi-0.90.1.tar.gz
rm /var/www/glpi-0.90.1.tar.gz
rm -rf /var/www/html/
mv /var/www/glpi /var/www/html
chown -R www-data:www-data /var/www/html
chmod -R 770 /var/www/html
mv /root/autostart /root/autostart.sh