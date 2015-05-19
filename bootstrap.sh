#!/usr/bin/env bash
echo "Installing Apache..."
sudo yum -y install httpd mod_ssl
echo "Unblocking port 80"
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
echo "Installing php..."
sudo yum -y install php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml
echo "Installing Java..."
sudo yum -y install java-1.7.0-openjdk
echo "Installing git..."
sudo yum -y install git

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi