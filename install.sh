#!/bin/bash
sudo apt-get update
sudo apt install ocserv -y
sudo ufw allow 80,443/tcp
sudo ufw allow 22/tcp
sudo ufw enable
sudo apt install apache2 -y
sudo wget -q -O /etc/apache2/sites-available/vpn.heppcat.com.conf https://raw.githubusercontent.com/cojored/ocserv-stuff/main/vpn.heppcat.com.conf
sudo mkdir /var/www/ocserv
sudo chown www-data:www-data /var/www/ocserv -R
sudo a2ensite virtnet.heppcat.com
sudo systemctl restart apache2
sudo rm /etc/ocserv/ocserv.conf
sudo wget -q -O /etc/ocserv/ocserv.conf https://raw.githubusercontent.com/cojored/ocserv-stuff/main/ocserv.conf
sudo printf "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo sysctl -p
sudo rm /etc/ufw/before.rules
sudo wget -q -O /etc/ufw/before.rules https://raw.githubusercontent.com/cojored/ocserv-stuff/main/before.rules
sudo iptables -t nat -L POSTROUTING
sudo systemctl restart ufw
sudo ufw allow 443/tcp
sudo ufw allow 443/udp
sudo systemctl restart ufw
