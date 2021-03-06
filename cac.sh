#!/bin/bash
cd "$(dirname "$0")"
echo "Starting CAC CDN Setup for WorldAutomation.Net..."
echo ""
pvscan;
vgextend localhost-vg /dev/sda3;
lvextend -l +100%FREE /dev/localhost-vg/root;
resize2fs /dev/localhost-vg/root;
apt-get update; 
apt-get install nginx --yes; 
rm -rf /etc/nginx/sites-enabled/*
rm -rf /etc/nginx/nginx.conf
ln -s /WA-Mod-Pack/setup/nginx.conf /etc/nginx/.
ln -s /WA-Mod-Pack/setup/cdn.nginx /etc/nginx/sites-enabled/.
chown -R www-data:www-data /WA-Mod-Pack
ufw allow 80;
ufw allow 9090;
ufw allow 443;
service nginx restart
rm /root/.bashrc
cp /WA-Mod-Pack/setup/bashrc /root/.bashrc
crontab -r
crontab -i /WA-Mod-Pack/setup/crontab
echo "!!!!!!!!!!!!!!!!!!!"
echo "Done!"
echo "!!!!!!!!!!!!!!!!!!!"
echo "Please reboot!"
echo "!!!!!!!!!!!!!!!!!!!"