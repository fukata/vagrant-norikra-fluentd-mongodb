#!/bin/bash

echo "Installing development tools ..."
yum update -y >> /dev/null
#yum groupinstall -y "Development Tools" >> /dev/null
#yum install -y docker-io >> /dev/null
yum install -y openssl openssl-devel >> /dev/null
yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel >> /dev/null
yum install -y git-core >> /dev/null
git clone https://github.com/tagomoris/xbuild.git >> /dev/null
mkdir -p ./local

echo "Installing jruby-1.7.11 ..."
sudo -u vagrant ./xbuild/ruby-install jruby-1.7.11 /home/vagrant/local/jruby-1.7 >> /dev/null

echo "Installing ruby-2.1.1 ..."
sudo -u vagrant ./xbuild/ruby-install 2.1.1 /home/vagrant/local/ruby-2.1 >> /dev/null

echo "Installing mongodb ..."
yum install -y mongodb mongodb-server >> /dev/null

echo "Installing norikra ..."
sudo -u vagrant /home/vagrant/local/jruby-1.7/bin/gem i norikra norikra-client-jruby >> /dev/null
sudo -u vagrant /home/vagrant/local/ruby-2.1/bin/gem i norikra-client >> /dev/null

echo "Installing fluentd ..."
sudo -u vagrant /home/vagrant/local/ruby-2.1/bin/gem i fluentd fluent-plugin-norikra fluent-plugin-mongo >> /dev/null

