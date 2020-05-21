#!/bin/bash
# cd /tmp
# wget http://pengminmin.cn/download/php/php-7.3.17.tar.gz
# sha256sum php-7.3.17.tar.gz 
# sha256校验	
# 0dd484382b8f17dfa8afd44236a5ccf374e1f03de06ef826ebcbda98eadc7bda 
# tar xzvf php-7.3.17.tar.gz 	
# cd php-7.3.17
# ./configure --prefix=/usr/local/php
# 异常: configure: error: libxml2 not found. Please check your libxml2 installation.
# yum install -y libxml2-devel
# 默认安装
# ./configure --prefix=/usr/local/php
# make
# 异常: virtual memory exhausted: Cannot allocate memory
# 虚拟内存用完了，我的是1G内存，需要扩内存
# make test
# 异常: Test posix_kill(), posix_get_last_error and posix_strerror() functions : basic functionality [ext/posix/tests/posix_kill_basic.phpt]
# Bug #41655 (open_basedir bypass via glob()) 1/2 [ext/standard/tests/file/bug41655_1.phpt]
# Test glob() function: ensure no platform difference, variation 3 [ext/standard/tests/file/glob_variation5.phpt]
# ./configure --prefix=/usr/local/php --enable=php-fpm
# 默认模块 Core,date,libxml,pcre,sqlite3,ctype,dom,fileinfo,filter,hash,iconv,json,SPL,PDO,pdo_sqlite,session,posix,Reflection,standard,SimpleXML,Phar,tokenizer,xml,xmlreader,xmlwriter,cgi-fcgi
#
#
#
#
#
#
#
#
php_install()
{
	# 安装扩展
	# zlib与zlib-devel是数据压缩的函数库
	# libxml2 libxml-devel c语言的xml程序库
	# libxslt libxslt-devel 是xml转换到其它格式的扩展
	# 安全专有层密码库 openssl openssl-devel
	# jpeg libpng freetype freetype-devel gd php中gd库需要的扩展
	yum install -y zlib zlib-devel libxml2 libxml-devel \
	libxslt libxslt-devel openssl openssl-devel \
	jpeg libpng freetype freetype-devel gd curl \
	# 下载php源码文件
	wget http://pengminmin.cn/download/php/php-7.3.17.tar.gz
	# 解压文件
	tar zxvf php-7.3.17.tar.gz
	# 进入文件
	cd php-7.3.17
	# 矿建文件夹
	mkdir /usr/local/php

	# 配置
	./configure --prefix=/usr/local/php --with-curl=/usr/local/curl \
	--with-freetype-dir --with-gd --with-gettext --with-iconv-dir \
	--with-kerberos --with-libdir=lib64 --with-libxml-dir --with-mysqli \
	--with-openssl --with-pcre-regex --with-pdo-mysql --with-pdo-sqlite \
	--with-pear --with-png-dir --with-xmlrpc --with-xsl --with-zlib \
	--enable-fpm --enable-bcmath --enable-libxml --enable-inline-optimization \
	--enable-mbregex --enable-mbstring --enable-opcache --enable-pcntl --enable-shmop \
	--enable-soap --enable-sockets --enable-sysvsem --enable-xml --enable-zip
	# 编译

	# 安装
}

echo "开始安装php"
php_install
echo "结束安装php"