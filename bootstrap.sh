#!/usr/bin/env bash
echo "###########################"
echo "Installing EPEL Repo..."
echo "Needed as dependancy for other things..."
echo "###################################"
sudo yum -y install epel-release

echo "###########################"
echo "Installing Nano - Cause VI sucks"
echo "###########################"
sudo yum -y install nano

echo "Unblocking port 80"
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT

echo "###########################"
echo "Installing git..."
echo "###########################"
sudo yum -y install git

echo "###########################"
echo "Install NodeJS"
echo "###########################"
sudo yum -y install nodejs

echo "###########################"
echo "Installing Ruby Dependancies..."
echo "###########################"
sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel

echo "###########################"
echo "Installing rbenv"
echo "###########################"
cd /opt
sudo git clone git://github.com/sstephenson/rbenv.git 
echo  'export PATH="/opt/rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
echo  'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile
sudo git clone git://github.com/sstephenson/ruby-build.git /opt/rbenv/plugins/ruby-build
echo 'export PATH="/opt/rbenv/plugins/ruby-build/bin:$PATH"' >> /home/vagrant/.bash_profile
source /home/vagrant/.bash_profile

echo "###########################"
echo "Installing Ruby 2.2.0"
echo "###########################"
rbenv install -v 2.2.0
rbenv global 2.2.0
#We don't want gem documentation to be installed with gems
echo "gem: --no-document" > ~/.gemrc
gem install bundler  
echo "###########################"
echo "Installing Ruby on Rails"
echo "###########################"
gem install rails -v 4.2.3
#start rails with rails s -b 0.0.0.0 instead of the loopback address

#echo "###########################"
#echo "Installing Heroku"
#echo "###########################"
#sudo wget -c https://toolbelt.herokuapp.com/install.sh && sh install.sh
#echo 'export PATH="/usr/local/heroku/bin:$PATH"' >> /home/vagrant/.bash_profile ##Add to profile


#Set up directories
mkdir /vagrant/projects/
cd /vagrant/projects/

#Update bash profile
####OLD INSTALLERS
#echo "Installing php..."
#sudo yum -y install php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml
#echo "Installing Java..."
#sudo yum -y install java-1.8.0-openjdk
#echo "Installing Apache..."
#sudo yum -y install httpd mod_ssl
