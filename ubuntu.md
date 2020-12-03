## 安装软件

```bash
# 查看ubuntu版本
cat /proc/version
Linux version 4.15.0-91-generic (buildd@lgw01-amd64-013) (gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)) #92-Ubuntu SMP Fri Feb 28 11:09:48 UTC 2020
# 安装nginx
apt install -y nginx
# 查看nginx版本
nginx -v
# 
```

### 问题

- 安装软件如果提示没有package

  ```
  # 更新包
  apt update -y
  ```


## 查看ubuntu版本

```bash
# 简单信息
cat /etc/issue
# 详细信息
cat /etc/lsb-release
```

## nginx

```bash
apt install nginx -y
```

 

## mysql

```bash
# 安装 mysql
apt install mysql-server -y
# 查看 mysql 版本
mysql -V
# 安装设置
mysql_secure_installation
# 刷新权限
flush privileges;

```



### 解决 mysql 不用密码登录

```bash
use mysql;
update user set authentication_string=PASSWORD("密码") where user='root';
update user set plugin="mysql_native_password";
flush privileges;
```

### 密码策略不够

```bash
SHOW VARIABLES LIKE 'validate_password%'; 
set global validate_password_policy=LOW;
```

## php

> https://www.cnblogs.com/niuben/p/13329434.html#%E5%9C%A8ubuntu-1804%E4%B8%8A%E5%AE%89%E8%A3%85php-72

```bash
apt-get update && apt-get upgrade

apt-get install php

apt-get install php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-xml libapache2-mod-php

apt-cache search --names-only ^php
# php-fpm 与 apache2 冲突，卸载 apache 相关东西
apt-get purge apache2
apt autoremove
apt autoclean
```

> /run/php/php7.2-fpm.sock

```bash
# 错误  Call to undefined function bccomp()
apt-get install php-bcmath
```

```shell
https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-server_8.0.21-1ubuntu18.04_amd64.deb
```

