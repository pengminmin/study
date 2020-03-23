## 基本安装

设置默认vmbox文件夹，共享粘贴板，拖放设置，网络设置，显卡设置，存储设置

### 设置默认vmbox文件夹

在管理-》全局设定-》常规-》默认虚拟电脑位置

### 共享粘贴板，拖放设置

设置-》常规-》高级-》共享粘贴板，拖放

### 网络设置

网络-》链接方式-》桥接网卡

### 显卡设置

显示-》显示控制器-》VBoxVGA

### 存储设置

``` json
{
    存储:{
        控制器 IDE:{
        	分配光驱
    	},
    	控制器 SATA :{
    		使用主机输入\输出IO
    		centos7 vdi : {
    			固态驱动器
			}
		}
    }
}
```



## 基础网络配置和常用命令安装

替换成阿里云源

https://developer.aliyun.com/mirror/

### 替换成阿里云源

``` shell
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache

yum install -y wget
yum install -y net-tools
yum install -y vim



```



## nginx安装

```shell
# 安装依赖
yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel
# 安装PCRE
cd /usr/local/src/
wget http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz
tar zxvf pcre-8.35.tar.gz
cd pcre-8.35
./configure
make && make install
pcre-config --version
# 安装 nginx
cd /usr/local/src/
wget http://nginx.org/download/nginx-1.6.2.tar.gz
tar zxvf nginx-1.6.2.tar.gz
cd nginx-1.6.2
./configure --prefix=/usr/local/webserver/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/pcre-8.35
make
make install
/usr/local/webserver/nginx/sbin/nginx -v
# 创建 nginx 运行使用的用户
/usr/sbin/groupadd www 
/usr/sbin/useradd -g www www
vim /usr/local/webserver/nginx/conf/nginx.conf
# 将 users root; 改为 user www www;
# 检查 nginx.conf 正确性
/usr/local/webserver/nginx/sbin/nginx -t
# 启动nginx
/usr/local/webserver/nginx/sbin/nginx
```

### Nginx 其他命令

```shell
/usr/local/webserver/nginx/sbin/nginx -s reload            # 重新载入配置文件
/usr/local/webserver/nginx/sbin/nginx -s reopen            # 重启 Nginx
/usr/local/webserver/nginx/sbin/nginx -s stop              # 停止 Nginx
```

### 防火墙80端口添加

```shell
firewall-cmd --zone=public --add-port=80/tcp --permanent
systemctl restart filewalld
```

## 安装PHP

```shell
scp php-7.3.16.tar.gz root@192.168.31.184:/usr/local/src
tar zxvf php-7.3.16.tar.gz
cd php-7.3.16
# 查看帮助
./configure --help
./configure --enable-fpm --with-mysql
# 如果报libxml2错误
yum install -y libxml2-devel
make
make install

```



