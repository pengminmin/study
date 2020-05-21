#!/bin/bash

Nginx_install()
{
	#安装yum-utils
	yum install -y yum-utils
	#写nginx源
cat <<EOF
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOF
	# 使用yum源
	yum-config-manager --enable nginx-mainline
	#yum 安装
	yum install -y nginx
	#启动nginx
	systemctl start nginx
	#开机自启动
	systemctl enable nginx

}

echo "开始安装nginx"
Nginx_install
echo "结束安装nginx"