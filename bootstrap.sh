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
echo "Installing Ruby Dependancies..."
sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel

echo "Installing rbenv"
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
exec $SHELL
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
exec $SHELL
source ~/.bash_profile

echo "Installing Ruby"
rbenv install -v 2.1.5
rbenv global 2.1.5
#We don't want gem documentation to be installed with gems
echo "gem: --no-document" > ~/.gemrc
gem install bundler
gem install rails -v 4.2.3

#There is so much more we need to do here:
#1: Figure out chef (maybe)
#1: Clone the project folders
#2: Set up bash to set JAVA_HOME directory
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

#Set up directories
mkdir /vagrant/projects/
cd /vagrant/projects/

#Update bash profile
