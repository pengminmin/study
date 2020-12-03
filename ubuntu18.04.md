## 配置 阿里源

```shell
echo '
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse 
' > /etc/apt/sources.list.d/aliyun.list

# 更新
apt-get update
```



## 安装 php 7.4

> https://blog.csdn.net/hiqiming/article/details/105245227

```shell
wget https://www.php.net/distributions/php-7.4.0.tar.gz
# 安装依赖
sudo apt-get install -y build-essential pkg-config libxml2-dev libssl-dev sqlite3 libsqlite3-dev libbz2-dev libgmp3-dev libonig-dev libedit-dev libreadline-dev libxslt1-dev libcurl4-openssl-dev
# 编译
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql-sock --with-mysqli --with-libxml-dir --with-openssl --with-mcrypt --with-mhash --with-pcre-regex --with-zlib --with-iconv --with-bz2 --with-curl --with-cdb --with-pcre-dir --with-gd --with-openssl-dir --with-jpeg-dir --with-png-dir --with-zlib-dir --with-freetype-dir --with-gettext --with-gmp --with-mhash --with-libmbfl --with-onig --with-pdo-mysql --with-zlib-dir --with-readline --with-libxml-dir --with-xsl --with-pear --enable-fpm --enable-soap --enable-bcmath --enable-calendar --enable-dom --enable-exif --enable-fileinfo --enable-filter --enable-ftp --enable-gd-native-ttf --enable-gd-jis-conv --enable-json --enable-mbstring --enable-mbregex --enable-mbregex-backtrack --enable-pdo --enable-session --enable-shmop --enable-simplexml --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --enable-zip --enable-mysqlnd-compression-support
# 安装
sudo make
sudo make install

Wrote PEAR system config file at: /usr/local/php/etc/pear.conf
You may want to add: /usr/local/php/lib/php to your php.ini include_path
/var/local/php-7.4.10/build/shtool install -c ext/phar/phar.phar /usr/local/php/bin/phar.phar
ln -s -f phar.phar /usr/local/php/bin/phar
Installing PDO headers:           /usr/local/php/include/php/ext/pdo/


# 创建软连接
ln -s /usr/local/php/bin/php /usr/local/bin/php
# 查看 php 版本
php -v
# 添加 php-fpm 到 service 中
sudo cp /usr/local/sbin/php-fpm /etc/init.d/
update-rc.d php-fpm default

# update-rc.d 操作
# 添加
update-rc.d ServiceName defaults
# 删除
update-rc.d ServiceName remove

# service
[Unit]
Description=The PHP FastCGI Process Manager
After=syslog.target network.target

[Service]
Type=forking
PIDFile=/usr/local/php/var/run/php-fpm.pid
ExecStart=/usr/local/php/sbin/php-fpm
ExecReload=/bin/kill -USR2 $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target

```

### 快速安装

```shell
apt-get install software-properties-common
add-apt-repository ppa:ondrej/php
apt-get update

apt-get install php7.4 php7.4-fpm php7.4-mysql php7.4-gd php7.4-mbstring
service php7.4-fpm start
php -v
```

### nginx

```nginx
server {
    listen       80;
    server_name  localhost;
    access_log  /var/log/nginx/default.access.log  main;
    error_log /var/log/nginx/default.error.log;
    root   /var/www/html;
    location / {
        index  index.html index.htm;
    }
    location ~ \.php$ {
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
}
```



## nginx

```nginx
location ~ \.php$ {
    root /var/www/html;
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}
```

## mysql

```shell
sudo dpkg -i mysql-apt-config_0.8.10-1_all.deb
sudo apt update
sudo apt install mysql-server

# 查看字符集
show variables like '%char%'; 

# 外网访问
update user set Host='%' where User="root";
# 刷新
flush privileges;
```

