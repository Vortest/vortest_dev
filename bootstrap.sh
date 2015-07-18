#!/usr/bin/env bash
echo "Installing EPEL Repo..."
sudo yum -y install epel-release
echo "Installing Nano - Cause VI sucks"
sudo yum -y install nano
echo "Installing Apache..."
sudo yum -y install httpd mod_ssl
echo "Unblocking port 80"
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
echo "Installing php..."
sudo yum -y install php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml
echo "Installing Java..."
sudo yum -y install java-1.8.0-openjdk
echo "Installing git..."
sudo yum -y install git
echo "Installing Pyenv..."
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
echo "Installing Pip..."
sudo yum -y install python-pip


#There is so much more we need to do here:
#1: Figure out chef (maybe)
#1: Clone the project folders
#2: Set up bash to set JAVA_HOME directory
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi