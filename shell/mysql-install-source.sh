#!/bin/bash
# cd /tmp
#######新建mysql用户和mysql组
[root@typecodes ~]# groupadd -r mysql && useradd -r -g mysql -s /bin/false -M mysql

######从官网或者博客备份地址下载MySQL5.7.7 Release Candidate版本
[root@typecodes ~]# wget -c http://cdn.mysql.com/Downloads/MySQL-5.7/mysql-5.7.7-rc.tar.gz
[root@typecodes ~]# wget -c http://git.typecodes.com/libs/mysql/mysql-5.7.7-rc.tar.gz
[root@typecodes ~]# md5sum mysql-5.7.7-rc.tar.gz        [MD5校验]
36a96021a93ca236e76f5c90ae19cd44  mysql-5.7.7-rc.tar.gz
######开始解压MySQL5.7.7
[root@typecodes ~]# tar -zxf mysql-5.7.7-rc.tar.gz && cd mysql-5.7.7-rc
######下载gmock：google的c++mock框架，从mysql 5.6开始支持
[root@typecodes mysql-5.7.7-rc]# wget -c http://git.typecodes.com/libs/ccpp/gmock-1.6.0.zip
######将其解压到MySQL5.7.7的source_downloads目录下
[root@typecodes mysql-5.7.7-rc]# unzip gmock-1.6.0.zip -d source_downloads
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
# wget -i http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
# yum -y install mysql57-community-release-el7-7.noarch.rpm
# yum -y install mysql-community-server
# 启动数据库
# systemctl start  mysqld.service
# 查看数据库状态
# systemctl status mysqld.service
# 获取初始密码
# grep "password" /var/log/mysqld.log
# 修改密码
# ALTER USER 'root'@'localhost' IDENTIFIED BY 'new password';
# set global validate_password_policy=0;
# set global validate_password_length=1;
# set password for 'root'@'localhost'=password('root');
# flush privileges;

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
