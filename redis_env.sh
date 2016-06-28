#!/bin/bash
#Install Redis Cluster Env,include redis cluster ,ruby ,rubygems,openssl

#Yum install gcc and zlib-devel
set +x
yum install -y gcc  zlib-devel



#Install openssl

cd /usr/local/src   && wget https://www.openssl.org/source/openssl-1.0.1t.tar.gz

tar -zxvf openssl-1.0.1t.tar.gz

cd openssl-1.0.1t

./config -fPIC --prefix=/usr/local/openssl enable-shared  

make depend

make && make install

#openssl version

#Install ruby
cd /usr/local/src && wget https://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.9.tar.gz

tar -zvxf ruby-2.1.9.tar.gz 

cd ruby-2.1.9

./configure  --with-openssl-dir=/usr/local/openssl

make && make install

ruby -v

#Install rubygems
cd /usr/local/src  && wget https://rubygems.org/rubygems/rubygems-2.6.6.zip
unzip rubygems-2.6.6.zip 
cd rubygems-2.6.6
ruby setup.rb 
gem -v

cd /ruby-2.1.9/ext/
ruby extconf.rb
make && make install
gem install  redis -V



#Install Reids cluster
cd /usr/local/src && wget http://download.redis.io/releases/redis-3.2.1.tar.gz
tar -zxvf redis-3.2.1.tar.gz 
cd /redis-3.2.1
make && make install

#wget redis conf from github repo
cd /usr/local/src && wget https://github.com/dinghunter/redis_cluster/blob/master/redis.conf
mv redis.conf /etc/

