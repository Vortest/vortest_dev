#!/usr/bin/env bash



echo "###########################"
echo "Updating utilities"
echo "###################################"
sudo yum -y update

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

git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
echo  'export PATH="/usr/local/rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
echo  'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile
git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
echo 'export PATH="/usr/local/rbenv/plugins/ruby-build/bin:$PATH"' >> /home/vagrant/.bash_profile
source /home/vagrant/.bash_profile

echo "###########################"
echo "Installing Ruby 2.2.0"
echo "###########################"
sudo -u vagrant -i rbenv install -v 2.2.0
sudo -u vagrant -i rbenv global 2.2.0
#We don't want gem documentation to be installed with gems
echo "gem: --no-document" > ~/.gemrc
sudo -u vagrant -i gem install bundler  
echo "###########################"
echo "Installing Ruby on Rails"
echo "###########################"
sudo -u vagrant -i gem install rails -v 4.2.3
#start rails with rails s -b 0.0.0.0 instead of the loopback address

echo "###########################"
echo "Install RSpec"
echo "###########################"
sudo -u vagrant -i gem install rspec

echo "###########################"
echo "Install Mongo"
echo "###########################"
sudo cp /vagrant/mongodb-org-3.0.repo /etc/yum.repos.d/
sudo yum install -y mongodb-org
sudo yum install -y pymongo

#echo "###########################"
#echo "Installing Heroku"
#echo "###########################"
#sudo wget -c https://toolbelt.herokuapp.com/install.sh && sh install.sh
#echo 'export PATH="/usr/local/heroku/bin:$PATH"' >> /home/vagrant/.bash_profile ##Add to profile

echo "###########################"
echo "Installing Python 2.7.6 and development tools"
echo "###################################"
sudo yum groupinstall -y development
sudo yum install -y zlib-dev openssl-devel sqlite-devel bzip2-devel
sudo wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
sudo xz -d Python-2.7.6.tar.xz
sudo tar -xvf Python-2.7.6.tar
cd Python-2.7.6
sudo ./configure --prefix=/usr/local
sudo make
sudo make altinstall
export PATH="/usr/local/bin:$PATH"
echo 'export PATH="/usr/local/bin:$PATH"' >> /home/vagrant/.bash_profile ##Add to profile
sudo wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz
sudo tar -xvf setuptools-1.4.2.tar.gz
cd setuptools-1.4.2
python2.7 setup.py install
cd /vagrant
sudo curl https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py | sudo python -
sudo pip install virtualenv
sudo -u vagrant -i virtualenv --python=/usr/local/bin/python2.7 virtualpython
source /home/vagrant/virtualpython/bin/activate
echo 'source /home/vagrant/virtualpython/bin/activate' >> /home/vagrant/.bash_profile ##Add to profile

echo "###########################"
echo "Installing Python"
echo "###########################"
sudo yum -y install python-setuptools
sudo easy_install selenium

#Set up directories
rm -rf /vagrant/projects/
mkdir /vagrant/projects/
cd /vagrant

echo "###########################"
echo "Installing Firefox"
echo "###########################"

sudo yum -y install firefox Xvfb libXfont Xorg
sudo yum -y groupinstall "X Window System" "Desktop" "Fonts" "General Purpose Desktop"
Xvfb :99 -ac &
export DISPLAY=:99
echo 'export DISPLAY=:99' >> /home/vagrant/.bash_profile ##Add to profile

echo "###########################"
echo "Installing Chrome"
echo "###########################"
sudo yum update
sudo dbus-uuidgen --ensure
sudo cp /vagrant/google-chrome.repo /etc/yum.repos.d/
#wget http://chrome.richardlloyd.org.uk/install_chrome.sh
sudo chmod u+x install_chrome.sh
sudo ./install_chrome.sh --force --force --force
export LD_LIBRARY_PATH=/opt/google/chrome/lib
