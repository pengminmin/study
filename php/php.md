

## 安装

### centos7 安装PHP

```shell



```

## php扩展

### 查看php扩展

1. 通过 phpinfo() 函数查看
2. 执行命令 php -m
3. 使用php函数 get_loaded_extensions()

## php编译命令

```bash
# prefix 指定安装目录
./configure --prefix=/usr/local/php --with-curl
```



## 源码编译安装php需要的依赖

1. zlib以及zlib-devel zlib提供数据压缩的函数库，也是nginx的前端软件，由于zlib需要编译php的zlib扩展，而编译中会需要使用zlib.h这个头文件，头文件在zlib-devel中，因此也需要下载zlib-devel。
2. libxml2以及libxml-devel libxml2是一个c语言的xml程序库，可以简单的对xml进行各种操作，并支持xpath查询，以及部分支持xslt转换等功能。
3. libxslt以及libxslt-devel如果不安装libxslt-devel会提示找到xslt.config文件，xslt是转换xml到其他格式的扩展。
4. openssl及openssl-devel安全专有层密码库
5. jpeg IJG的jpeg库，php的gd库所需。
6. libpng是c语言写的比较复杂的的pngpng文件的跨平台的库，可以帮助轻松的识读pngpng文件的每一行替换，php的gd库所需。
7. freetype及freetype-devel免费开源的且可移植的字体引擎，提供统一的接口访问多种字体格式，这两个都是gd库的依赖软件，所以如果没有安装，或者版本太低，在安装phptime设定的是安装gd库插入报错，另外不安装-devel也是会报错的，因为编译扩展的时候会ft2build.h文件，报错如下图。
8. gd gd是php处理图形的扩展库。
9. curl，由于我的yum里的版本太低了，所以直接自己编译安装的，安装方式很简单，也就是wget curl下载地址后tar解压，新建/ usr / local / curl文件夹，然后进入curl解压后的文件夹里配置。/configure--prefix = / usr / local / curl立即，最后make以及make install就安装好了。



## php安全

- 修改php.ini通过查找cgi.fix_pathinfo = 1这个配置，并删除注释，并替换cgi.fix_pathinfo = 0，这里并不属于nginx支持php配置相关，或者专属于nginx下php的一个安全漏洞，如果此处缩小1 ，用户方可以通过上传图片来上传木马，然后通过网址访问该图片地址，并在地址后加入/xxx.php将图片作为PHP文件运行，这只是在nginx里才会存在的问题，apache和iis都没有该问题。

## pecl和pear的区别

- Pear：是PHP的扩展代码包，所有的扩展均以PHP代码的形式出现，功能强大，安装简单，甚至可以改改就用。使用的时候，要在代码中进行Include才能够使用。
- Pecl：是PHP的标准扩展，可以补充实际开发中所需的功能，所有的扩展都需要安装，在Windows下面以Dll的形式出现，在linux下面，需要单独进行编译，它的表现形式为根据PHP官方的标准用C语言写成，尽管源码开放但是一般人无法随意更改源码。
- Pear是PHP的上层扩展，Pecl是PHP的底层扩展。

## CGI、fastCGI、php-cgi和php-fpm的区别和关系

- cgi : 是web serber (如 nginx) 跟php解释器之间通信的协议。
- fastCGI : 是cgi的升级版，因为cgi每个请求都启动进程建立连接完整操作，导致每个处理时间较长，fastCGI会启动master进程再启动多个worker进行进行分配处理请求，当前worker不够用时会预先启动几个worker待命，当空闲worker太多时则会关掉一些。这样达到提升性能，节约资源，fastcgi也是一个协议。
- php-cgi : 是php实现cgi的一个程序
- php-fpm : 是对php-cgi进行进程管理

## function

```php
chdir ( string $directory ) : bool
realpath ( string $path ) : string
```



## centos中卸载php

```bash
# 查看php版本
php -v
# 卸载php
yum remove -y php*
# 查看php版本
php -v
# 查看还有哪些包没删除
[root@VM_0_10_centos conf.d]# rpm -qa | grep php
php-cli-5.4.16-46.1.el7_7.x86_64
php-common-5.4.16-46.1.el7_7.x86_64
# 删除对应php
[root@VM_0_10_centos conf.d]# rpm -e php-cli-5.4.16-46.1.el7_7.x86_64
[root@VM_0_10_centos conf.d]# rpm -e php-common-5.4.16-46.1.el7_7.x86_64
[root@VM_0_10_centos conf.d]# php -v
-bash: /usr/bin/php: No such file or directory
 
```

## centos中yum安装php

```bash
# 安装EPEL源
yum install -y epel-release
# 安装REMI源
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm  
# 安装yum源管理工具
yum install -y yum-utils
# 安装PHP7.3
yum install -y php73-php-fpm php73-php-cli php73-php-bcmath php73-php-gd php73-php-json php73-php-mbstring php73-php-mcrypt php73-php-mysqlnd php73-php-opcache php73-php-pdo php73-php-pecl-crypto php73-php-pecl-mcrypt php73-php-pecl-geoip php73-php-recode php73-php-snmp php73-php-soap php73-php-xmll
# 设置开机自启动php7.3
systemctl enable php73-php-fpm
# 启动php7.3
systemctl start php73-php-fpm
# 查找安装包
[root@xxx etc]# rpm -qa | grep 'php'
php73-php-cli-7.3.6-1.el7.remi.x86_64
php73-php-mbstring-7.3.6-1.el7.remi.x86_64
php73-php-pecl-mcrypt-1.0.2-1.el7.remi.x86_64
php73-runtime-2.0-1.el7.remi.x86_64
php73-php-pdo-7.3.6-1.el7.remi.x86_64
php73-php-bcmath-7.3.6-1.el7.remi.x86_64
php73-php-fpm-7.3.6-1.el7.remi.x86_64
php73-php-mysqlnd-7.3.6-1.el7.remi.x86_64
php73-php-snmp-7.3.6-1.el7.remi.x86_64
php73-php-gd-7.3.6-1.el7.remi.x86_64
php73-php-json-7.3.6-1.el7.remi.x86_64
php73-php-soap-7.3.6-1.el7.remi.x86_64
php73-php-recode-7.3.6-1.el7.remi.x86_64
php73-php-pecl-crypto-0.3.1-5.el7.remi.x86_64
php73-php-common-7.3.6-1.el7.remi.x86_64
php73-php-opcache-7.3.6-1.el7.remi.x86_64
php73-php-pecl-geoip-1.1.1-6.el7.remi.x86_64
# 查找php73-php-fpm-7.3.6-1.el7.remi.x86_64安装位置
[root@xxx etc]# rpm -ql php73-php-fpm-7.3.6-1.el7.remi.x86_64
/etc/logrotate.d/php73-php-fpm
/etc/opt/remi/php73/php-fpm.conf
/etc/opt/remi/php73/php-fpm.d
/etc/opt/remi/php73/php-fpm.d/www.conf
/etc/opt/remi/php73/sysconfig/php-fpm
/etc/systemd/system/php73-php-fpm.service.d
/opt/remi/php73/root/usr/sbin/php-fpm
/opt/remi/php73/root/usr/share/doc/php73-php-fpm-7.3.6
/opt/remi/php73/root/usr/share/doc/php73-php-fpm-7.3.6/php-fpm.conf.default
/opt/remi/php73/root/usr/share/doc/php73-php-fpm-7.3.6/www.conf.default
/opt/remi/php73/root/usr/share/fpm
/opt/remi/php73/root/usr/share/fpm/status.html
/opt/remi/php73/root/usr/share/licenses/php73-php-fpm-7.3.6
/opt/remi/php73/root/usr/share/licenses/php73-php-fpm-7.3.6/fpm_LICENSE
/opt/remi/php73/root/usr/share/man/man8/php-fpm.8.gz
/usr/lib/systemd/system/php73-php-fpm.service
/var/opt/remi/php73/lib/php/opcache
/var/opt/remi/php73/lib/php/session
/var/opt/remi/php73/lib/php/wsdlcache
/var/opt/remi/php73/log/php-fpm
/var/opt/remi/php73/run/php-fpm
# 查找php.ini位置
[root@xxx etc]# find /etc/opt/remi/php73 -name php.ini
/etc/opt/remi/php73/php.ini
# 编辑/etc/opt/remi/php73/php.ini
# 替换换 ;cgi.fix_pathinfo=1 为 cgi.fix_pathinfo=0
# 原因是php-fpm与nginx之间将cgi.fix_pathinfo设置为0可以防止上次图片格式的脚本文件，安全问题，只有跟nginx有这个问题
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/opt/remi/php73/php.ini
# 重启php
systemctl restart php73-php-fpm
# 操作php的其它命令
systemctl restart php73-php-fpm #重启
systemctl start php73-php-fpm #启动
systemctl stop php73-php-fpm #关闭
systemctl status php73-php-fpm #检查状态
# 查看php版本
root@mf88.biz-service:~# php73 -v
PHP 7.3.0-1+(cli) (built: Dec  6 2018 20:24:55) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.3.0-dev, Copyright (c) 1998-2018 Zend Technologies
    with Zend OPcache v7.3.0-1+ubuntu18.04.1+deb.sury.org+1, Copyright (c) 1999-2018, by Zend Technologies
# 更新yum源
yum update -y
# 查看更多组件
# yum search php73
Updating Subscription Management repositories.
Last metadata expiration check: 0:27:54 ago on Wed 15 May 2019 10:39:52 AM EDT.
============================================================================================= Name Exactly Matched: php73 ==============================================================================================
php73.x86_64 : Package that installs PHP 7.3
php73.x86_64 : Package that installs PHP 7.3
============================================================================================ Name & Summary Matched: php73 =============================================================================================
php73-syspaths.x86_64 : System-wide wrappers for the php73 package
php73-syspaths.x86_64 : System-wide wrappers for the php73 package
php73-scldevel.x86_64 : Package shipping development files for php73
php73-scldevel.x86_64 : Package shipping development files for php73
php73-php-zstd-devel.x86_64 : php73-php-zstd developer files (header)
php73-runtime.x86_64 : Package that handles php73 Software Collection.
php73-runtime.x86_64 : Package that handles php73 Software Collection.
php73-runtime.x86_64 : Package that handles php73 Software Collection.
php73-php-pecl-psr-devel.x86_64 : php73-php-pecl-psr developer files (header)
php73-php-pecl-psr-devel.x86_64 : php73-php-pecl-psr developer files (header)
php73-php-pecl-raphf-devel.x86_64 : php73-php-pecl-raphf developer files (header)
php73-php-pecl-raphf-devel.x86_64 : php73-php-pecl-raphf developer files (header)
php73-php-pecl-propro-devel.x86_64 : php73-php-pecl-propro developer files (header)
php73-php-pecl-yaconf-devel.x86_64 : php73-php-pecl-yaconf developer files (header)
php73-php-pecl-propro-devel.x86_64 : php73-php-pecl-propro developer files (header)
php73-php-pecl-yaconf-devel.x86_64 : php73-php-pecl-yaconf developer files (header)
php73-php-pecl-xmldiff-devel.x86_64 : php73-php-pecl-xmldiff developer files (header)
php73-php-pecl-swoole4-devel.x86_64 : php73-php-pecl-swoole4 developer files (header)
php73-php-pecl-xmldiff-devel.x86_64 : php73-php-pecl-xmldiff developer files (header)
php73-php-zephir-parser-devel.x86_64 : php73-php-zephir-parser developer files (headers)
php73-php-zephir-parser-devel.x86_64 : php73-php-zephir-parser developer files (headers)
php73-php-pecl-handlebars-devel.x86_64 : php73-php-pecl-handlebars developer files (header)
================================================================================================= Name Matched: php73 ==================================================================================================
php73-php.x86_64 : PHP scripting language for creating dynamic web sites
php73-php.x86_64 : PHP scripting language for creating dynamic web sites
php73-build.x86_64 : Package shipping basic build configuration
……

```

## centos7 源码编译安装 php

```bash
# 下载 php 源码包
wget https://www.php.net/distributions/php-7.4.6.tar.gz
# sha256 校验
sha256sum php-7.4.6.tar.gz > a.txt
grep 2a37bab4e308c4e3867083137b7cce4a3f1d996ae231b383c1a83609cec3fed0 a.txt
# 解压
tar xzvf php-7.4.6.tar.gz
# 进入解压后的目录
cd php-7.4.6
# 编译安装
.configure --prefix=/usr/local/php
# 提示没有 libxml-2.0
No package 'libxml-2.0' found
# 安装 libxml-2.0
yum install -y libxml-2.0
# 查看 libxml2 是否已安装
yum list libxml-2.0
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
Installed Packages
libxml2.x86_64                             2.9.1-6.el7.4                             @os
Available Packages
libxml2.i686                               2.9.1-6.el7.4                             os 
# 安装 libxml2-dev
yum install libxml2-devel

# 没有 php-fpm 加上 --with-config-file=/usr/local/php/etc
./configure --prefix=/usr/local/php --enable-fpm
# 别人写的
##下载源码
$wget http://am1.php.net/distributions/php-7.2.2.tar.gz
##解压
$tar -zxvf php-7.2.2.tar.gz
##创建安装目录
$mkdir php7
$mv php-7.2.2 php7
$cd php7/php-7.2.2/
## 编译前配置
$./configure --prefix=/home/test/php7 --with-config-file-path=/home/test/php7/etc --with-curl --with-freetype-dir --with-gd \
--with-gettext --with-iconv-dir --with-kerberos --with-libdir=lib64 --with-libxml-dir --with-mysqli --with-openssl --with-pcre-regex \
--with-pdo-mysql --with-pdo-sqlite --with-pear --with-png-dir --with-jpeg-dir --with-xmlrpc --with-xsl --with-zlib --with-bz2 \
--with-mhash --enable-fpm --enable-bcmath --enable-libxml --enable-inline-optimization --enable-gd-native-ttf --enable-mbregex \
--enable-mbstring --enable-opcache --enable-pcntl --enable-shmop --enable-soap --enable-sockets --enable-sysvsem --enable-sysvshm \
--enable-xml --enable-zip --with-ldap
 
##编译时间略长，耐心等待
$make
##安装
$make install
```

### 需要安装的扩展包

#### No package 'libxml-2.0'[^libxml-2.0] found 

```bash
yum install -y libxml2-devel
```

#### No package 'sqlite3'[^sqlite3] found

```bash
yum install -y sqlite-devel
```



### 下载 php 源码

[php 官网下载地址](https://www.php.net/downloads.php) 

```bash
wget https://www.php.net/distributions/php-7.4.6.tar.gz
```

#### sha256 验证

```bash
sha256sum php-7.4.6.tar.gz
```



#### tar.bz2 格式

方式一：利用已经打包好的tar文件，直接执行压缩命令：

> 压缩：bzip2 [原文件名].tar
> 解压：bunzip2 [原文件名].tar.bz2

方式二：一次性打包并压缩、解压并解包

> 打包并压缩： tar -jcvf [目标文件名].tar.bz2 [原文件名/目录名]
> 解压并解包： tar -jxvf [原文件名].tar.bz2

#### tar.xz格式

方式一：利用已经打包好的tar文件，直接用压缩命令：

> 压缩：xz [原文件名].tar
> 解压：unxz [原文件名].tar.xz

方式二：一次性打包并压缩、解压并解包

> 打包并压缩： tar -Jcvf [目标文件名].tar.xz [原文件名/目录名]
> 解压并解包： tar -Jxvf [原文件名].tar.xz

### 查看 php 安装了哪些扩展

```bash
php -m
# 默认 php 源码编译安装的扩展
[root@VM_0_10_centos php]# php -m
[PHP Modules]
Core
ctype
date
dom
fileinfo
filter
hash
iconv
json
libxml
pcre
PDO
pdo_sqlite
Phar
posix
Reflection
session
SimpleXML
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter

[Zend Modules]


```

### 设置 php 快捷键

```bash
vim ~/.bash_profile

export PATH
alias php=/usr/local/php/bin/php

source ~/.bash_profile
```

### 查看 php.ini 位置

```bash
php -i | grep php.ini

C:\Windows\Temp 拒绝访问
```

### php.ini 修改

#### cgi.force_redirect 设置

`cgi.force_redirect` 要设置为 0 ，该参数默认开启，会导致重定向 php 文件执行

#### cgi.fix_pathinfo 设置

`cgi.fix_pathinfo` 要设置为 0，该参数默认开启，会导致上传后缀文件 .jpg 之类的 php 文件执行

#### short_open_tag 设置

`short_open_tag` 默认是 Off，将其改为 On，可以使 php 解析标签简写的 php 代码如：

```php
<? echo 123; ?>
```





### php-fpm 控制

INT, TERM 立刻终止
QUIT 平滑终止
USR1 重新打开日志文件
USR2 平滑重载所有worker进程并重新载入配置和二进制模块

```bash
# 重启 php-fpm
kill -USR2 4
```



## 脚注

[^libxml-2.0]: libxml2以及libxml-devel libxml2是一个c语言的xml程序库，可以简单的对xml进行各种操作，并支持xpath查询，以及部分支持xslt转换等功能。
[^sqlite3]: SQLite是一个进程内的库，实现了自给自足的、无服务器的、零配置的、事务性的 SQL 数据库引擎。它是一个零配置的数据库，这意味着与其他数据库一样，您不需要在系统中配置。就像其他数据库，SQLite 引擎不是一个独立的进程，可以按应用程序需求进行静态或动态连接。SQLite 直接访问其存储文件。

