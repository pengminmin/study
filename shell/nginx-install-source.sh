#!/bin/bash
# cd /tmp
# wget http://pengminmin.cn/download/nginx/nginx-1.16.1.tar.gz
# tar xzvf nginx-1.16.1.tar.gz 
# cd nginx-1.16.1
# ./configure --prefix=/usr/local/nginx
# 异常: ./configure: error: C compiler cc is not found
# yum install -y gcc
# ./configure --prefix=/usr/local/nginx
# 异常: the HTTP rewrite module requires the PCRE library
# yum install -y pcre-devel
# ./configure --prefix=/usr/local/nginx
# 异常: the HTTP gzip module requires the zlib library
# yum install -y zlib-devel
# 默认安装，没有加其它模块
# ./configure --prefix=/usr/local/nginx
# make
# make install
# cd /usr/local/nginx
# cd sbin
# ln -s 要接绝对路径
# ln -s /usr/local/nginx/sbin/nginx /usr/local/bin
# 大写的V可以查看安装了哪些模块
# nginx -V
# 启动nginx
# nginx




# yum install -y gcc pcre-devel zlib-devel
