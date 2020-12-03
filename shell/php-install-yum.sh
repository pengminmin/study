#!/bin/bash
PHP_Install()
{
	#安装epel-release
	yum install -y epel-release
	#安装remi源
	rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
	#安装php yum源
	rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
	#安装php7.2
	yum --enablerepo=remi-php72
	#安装php扩展
	yum install -y php72w php72w-cli php72w-fpm php72w-common php72w-devel php72w-embedded php72w-gd php72w-mbstring php72w-mysqlnd php72w-opcache php72w-pdo php72w-xml php72w-pecl-redis
	#启动php-fpm
	systemctl start php-fpm
	#开机自启动
	systemctl enable php-fpm

}

echo "开始安装php7.2"
PHP_Install
echo "结束安装php7.2"