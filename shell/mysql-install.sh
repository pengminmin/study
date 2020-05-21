#!/bin/bash

Mysql_Install()
{
	# 下载yum repo配置文件
	wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
	#进行repo安装
	rpm -ivh mysql57-community-release-el7-9.noarch.rpm
	# yum 安装
	yum install -y mysql-server
	# 启动mysql
	systemctl start mysqld
	# 开机启动
	systemctl enable mysqld
	#获取临时密码
	grep 'temporary password' /var/log/mysqld.log

}

echo "开始安装mysql"
Mysql_Install
echo "结束安装mysql"
