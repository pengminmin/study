

## 初始Nginx

### 编译自己的Nginx

#### 编译安装

```bash
# 下载nginx
wget http://nginx.org/download/nginx-1.16.1.tar.gz
# 解压
tar zxvf nginx-1.16.1.tar.gz
# 进入解压后的nginx文件夹
cd nginx-1.16.1
# 把contrib中的vim拷贝到自己的vim中用于高亮显示nginx配置语法
cp -r contrib/vim/* ~/.vim
# 查看man下的nginx帮助文档
man ./man/nginx.8
# 查看 configure 支持哪些参数
./configure --help | more
# 指定安装目录
./configure --prefix=/usr/local/nginx
# 编译
make
# 安装
make install
```

#### 编译安装shell脚本

```bash
#!/usr/bin/env bash

nginx_install()
{
  # 安装依赖
  yum -y install pcre-devel zlib-devel
  # 下载nginx
  wget http://nginx.org/download/nginx-1.16.1.tar.gz
  # 解压
  tar zxvf nginx-1.16.1.tar.gz
  # 进入解压后的nginx文件夹
  cd nginx-1.16.1
  # 指定安装目录
  ./configure --prefix=/usr/local/nginx
  # 编译
  make
  # 安装
  make install
}

echo "开始安装nginx"
nginx_install
echo "结束安装nginx"

```



#### 编译异常

```bash
# make时异常
./configure: error: the HTTP rewrite module requires the PCRE library.
You can either disable the module by using --without-http_rewrite_module
option, or install the PCRE library into the system, or build the PCRE library
statically from the source with nginx by using --with-pcre=<path> option.
# 安装pcre-devel
yum -y install pcre-devel
# make时异常
./configure: error: the HTTP gzip module requires the zlib library.
You can either disable the module by using --without-http_gzip_module
option, or install the zlib library into the system, or build the zlib library
statically from the source with nginx by using --with-zlib=<path> option.
# 安装zlib-devel
yum install -y zlib-devel
```

### Nginx命令行

- 格式 : nginx -s reload
- 帮助 : -?  -h
- 使用指定的配置文件 : -c
- 指定配置指令 : -g
- 指定运行目录 : -p
- 发送信号 : -s
  - 立刻停止服务 : stop
  - 优雅的停止服务 : quit
  - 重载配置文件 : reload
  - 重新开始记录日志文件 : reopen
- 测试配置文件是否有语法错误 : -t   -T
- 打印nginx版本信息、编译信息等 : -v  -V

### Nginx热部署

```bash
# 复制老的nginx二进制文件
cp nginx nginx.old
# 将编译的新版本nginx二进制文件覆盖nginx二进制文件

# 查看nginx进程id
ps -ef | grep nginx
root      8794     1  0 22:47 ?        00:00:00 nginx: master process ./nginx
nobody    8795  8794  0 22:47 ?        00:00:00 nginx: worker process

# 给老的nginx进程发送热部署信号
kill -USR2 8794
# 查看nginx进程信息
ps -ef | grep nginx
root      8794     1  0 22:47 ?        00:00:00 nginx: master process ./nginx
nobody    8795  8794  0 22:47 ?        00:00:00 nginx: worker process
root     13490  8794  0 22:55 ?        00:00:00 nginx: master process ./nginx
nobody   13491 13490  0 22:55 ?        00:00:00 nginx: worker process
root     13493  2766  0 22:56 pts/0    00:00:00 grep --color=auto nginx
# 给老的nginx优雅关闭work进程
kill -WINCH 8794
# 查看nginx进程信息
ps -ef | grep nginx
root      8794     1  0 22:47 ?        00:00:00 nginx: master process ./nginx
root     13490  8794  0 22:55 ?        00:00:00 nginx: master process ./nginx
nobody   13491 13490  0 22:55 ?        00:00:00 nginx: worker process
root     13502  2766  0 22:58 pts/0    00:00:00 grep --color=auto nginx
```

### Nginx 日志切割

```bash
nginx -s reopen
# 或者
kill -USR1 $(cat /usr/local/openresty/nginx/logs/nginx.pid)

:<<BLOCK
1、在没有执行kill -USR1 `cat ${pid_path}`之前，即便已经对文件执行了mv命令也只是改变了文件的名称，nginx还是会向新命名的文件” access.log.20161024”中照常写入日志数据。原因在于linux系统中，内核是根据文件描述符来找文件的

2、USR1是自定义信号，也就是进程编写者自己确定收到这个信号该干什么。而在nginx中它自己编写了代码当接到USR1信号的时候让nginx重新打开日志文件（重新打开的日志就是配置文件中设置的位置和名称）
BLOCK
```

### goaccess

```bash
# 安装
yum install -y goaccess
# 执行命令
# access.log 是要分析的日志文件
# -o 输出的分析静态文件
# /var/www/html/report.html 是输出分析文件地址
# --real-time-html 实时跟新
# --time-format goaccess 与日志文件对应的格式
goaccess access.log -o report.html --real-time-html --time-format='%H:%M:%S' --date-format='%d/%b/%Y' --log-format=COMBINED


```

nginx.conf

```nginx
location /report.html {
    #root /usr/local/nginx-1.4.7/logs/report.html;
    alias /usr/local/nginx-1.4.7/logs/report.html;
}
```

### web静态资源服务器

```nginx
location /res {
    alias /usr/local/src;
    # 开始web静态资源服务
    autoindex on;
    # 限速
    set $limit_rate 100k;
}
```

### 用Nginx搭建有缓存功能的反向代理服务

```nginx
# 127.0.0.1:8080 只能本机访问
listen      127.0.0.1:8080;
#server_name  localhost;

upstream local {
    server 127.0.0.1:8080;
}

# 设置共享内存地址
proxy_cache_path /tmp/nginxcache levels=1:2 keys_zone=my_cache:10m max_size=10g inactive=60m use_tmp_path=off;

proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

proxy_cache my_cache;

proxy_cache_key $host$uri$is_args$args;
proxy_cache_valid 200 304 302 1d;
proxy_pass http://local;
```



### 编译安装openresty

#### 安装异常

```bash
./configure: error: SSL modules require the OpenSSL library.
You can either do not enable the modules, or install the OpenSSL library
into the system, or build the OpenSSL library statically from the source
with nginx by using --with-openssl=<path> option.

```

```bash
# 解决命令
yum install -y openssl openssl-devel
```

### ssl证书

```bash
# 下载颁发证书工具
yum install -y python2-certbot-nginx
# 
certbot --nginx --nginx-srver-root=/usr/local/openresty/nginx/conf/ -d geektime.taohui.pub

certbot --nginx --nginx-srver-root=/usr/local/openresty/nginx/conf/ -d res.pengminmin.cn


```

## Nginx基础架构

## HTTP模块

### Listen指定的用法

```nginx
# 监听sock地址
listen unix:/var/run/nginx.sock;
# 监听地址加端口
listen 127.0.0.1:8000;
# 只监听地址，默认监听80端口
listen 127.0.0.1;
listen 8000;
listen *:8000;
listen localhost:8000 bind;
listen [::]:8000 ipv6only=on;
listen [::1];
```

### 正则表达式

#### 元字符

| 代码 | 说明                           |
| ---- | ------------------------------ |
| .    | 匹配除换行符以外的任意字符     |
| \w   | 匹配字母、数字、下划线、或汉字 |
| \s   | 匹配任意的空白符               |
| \d   | 匹配数字                       |
| \b   | 匹配单词的开始或结束           |
| ^    | 匹配字符串的开始               |
| $    | 匹配字符串的结束               |

#### 重复

| 代码  | 说明             |
| ----- | ---------------- |
| *     | 重复零次或多次   |
| +     | 重复一次或更多次 |
| ？    | 重复零次或一次   |
| {n}   | 重复n次          |
| {n,}  | 重复n次或更多次  |
| {n,m} | 重复n到m次       |

#### 示例

```nginx
# 原始url : /admin/website/article/35/change/uploads/party/5.jpg
# 转换后的url : /static/uploads/party/5.jpg

# 匹配原始url的正则:
/^\/admin\/webstie\/article\/(\d+)\/change\/uploads\/(\w+)\/(\w+)\.(png|jpg|gif|jpeg|bmp)$/

# rewrite
rewrite^/admin/website/solution/(\d+)/change/uoloads/(.*)\.(png|jpg|jpeg|gif|bmp)$

/static/uploads/$2/$3.$4 last;
```

### server_name 指令

```nginx
# 指定完整域名
server_name taohui.pub;
# 泛域名，仅支持在前面或在后面
server_name *.taohui.pub;
# 正则表达式: 加~前缀
server_name ~^www\d+\.taohui\.tech$;
```

##### 正则表达式变量提取：用小括号()

```nginx
server {
    # ~ 表示使用正则
    # ^ 表示开头
    # ? 表示零次或一次
    # . 表示除换行符外任意字符
    # + 表示一次或多次
    # $ 表示结尾
    # () 表示匹配一组
    # \. 转义 . 
    server_name ~^(www\.)?(.+)$;
    location / {
        root /sites/$2;
    }
}

server {
    # ?<domain>.+ 表示这组匹配使用变量domain表示
    server_name ~^(www\.)?(?<domain>.+)$;
    location / {
        root /sites/$domain;
    }
}
```

- .taohui.tech 可以匹配 taohui.tech *.taohui.tech
- _ 匹配所有
- “” 匹配没有传host

#### server_name_in_redirect 用法

```nginx
# server_name_in_redirect on|of 默认 off
server_name www.test.com res.test.com;
# 
```

#### Server 匹配顺序

1. 精确匹配

2. *在前的泛域名

3. *在后的泛域名

4. 按文件中的顺序匹配正则表达式域名

   ```bash
   # TODO
   # 怎么理解按文件中的顺序匹配
   ```

5. default server

   - 第1个

   - listen 指定 default

     ```nginx
     listen pengminmin.cn default;
     ```

### 11个阶段

- postread阶段
  - realip
- rewrite阶段
  - rewrite
  - find_config
  - rewrite
- preaccess阶段
  - limit_req
  - limit_conn
- access阶段
  - access
  - auth_basic
  - auth_request
- precontent阶段
  - try_files
  - mirrors
- content阶段
  - concat
  - random_index
  - index
  - auto_index
  - static
- log阶段
  - log

#### postread阶段

##### 获取真实客户端地址的realip模块

X-Forwarded-For 可以放多个ip用逗号分隔，X-Real-IP则不能

```nginx
X-Forwarded-For: 115.204.33.1,1.1.1
X-Real-IP: 115.204.33.1
```

变量 binary_remote_addr 、 remote_addr 拿真是IP

***realip模块默认不会编译进Nginx，通过 --with-http_realip_module 启用功能***

```nginx
server {
    server_name realip.taohui.tech;
    
    error_log logs/myerror.log debug;
    # 当前请求地址是 116.62.160.193时，才进行替换X-Forwarded-For操作
    set_real_ip_from 116.62.160.193;
    # real_id_header X-Real-IP;
    real_id_recursive off;
    # real_id_recursive on;
    # 为什么用 X-Forwarded-For 而不用 X-Real-IP
    # 因为 X-Real-IP 是Nginx独有的，不是RFC规范，如果client间还有其它非Nginx软件实现代理，将取不到X-Real-IP头部
    real_ip_header X-Forwarded-For;
    
    location / {
        return 200 "Client real ip: $remote_addr\n";
    }
}
```

#### rewrite阶段

##### return指令

```nginx
# Syntax:
return code [text];
return code URL;
return URL;
# Default:
___
# Context:
server,location,if
```

- 返回状态码
  - 444 : 关闭连接

###### error_page

```nginx
# 404 返回404.html 页面
error_page 404 /404.html;
# 500 502 503 505 返回 50x.html 页面
error_page 500 502 503 505 /50x.html;
# 404 返回empty.gif图片，返回码为200
error_page 404 =200 /empty.gif;
# 404 返回404.php资源
error_page 404 = /404.php;
# 根据 @ 符号内部跳转
location / {
    error_page 404 = @fallback;
}
location @fallback {
    proxy_pass http://backend;
}
# 403 返回指定url
error_page 403 http://example.com/forbidden.html;
# 404 返回指定url，返回码301
error_page 404 =301 http://example.com/notfound.html;
```

###### 权重

```nginx
server {
    server_name return.taohui.tech;
    listen 8080;
    
    root html/;
    # 第三
    error_page 404 /403.html;
    # 第一
    return 403;
    location / {
        # 第二
        return 404 "find nothing!";
    }
}
```

##### rewrite指令

```nginx
# Syntax
rewrite regex replacement [flag];
# Default
---
# Context
server,location,if
```

```nginx
# flag
# 用replacment这个URI进行新的location匹配
--last
# break 等价于独立的 break
--break
# 返回 302 重定向
--redirect
# 返回 301 重定向
--permanent
# 开启rewrite日志
# 位置 logs/rewrite_error.log
# rewrite_log on;
```

##### if指令

```nginx
# Syntax
if(condition){...}
# Default
---
# Context
server,location
```

1. 检查变量为空或值是否为0，直接使用
2. 将变量与字符串做匹配，使用 = 或者 !=
3. 将变量与正则表达式做匹配
   - 大小写敏感，~ 或者 !~
   - 大小写不敏感，~* 或者 !~*
4. 检查文件是否存在，使用 -f 或者 !-f
5. 检查目录是否存在，使用 -d 或者 !-d
6. 检查文件、目录、软连接是否存在，使用 -e 或者 !-e
7. 检查是否为可执行文件，使用 -x 或者 !-x

###### 示例

```nginx
# 判断是否是IE浏览器
if($http_user_agent ~ MSIE){
    # . 表示除换行符外任意字符
    # * 表示零次或多次
    rewrite ^(.*)$ /misie/$1 break;
}
# 忽略大写
# ^; 以分号开始
# + 表示一次或多次
if($http_cookie ~* "id=([^;]+)(?:;|$)"){
    set $id $1;
}
# 判断请求方法是否是POST
if($request_method = POST){
    return 405;
}
# $slow 默认为空，当我们给他传个1则会进去判断
if($slow){
    limit_rate 10k;
}
# 判断是否盗链
if($invalid_referer){
    return 403;
}
```

#### find_config阶段

##### 找到请求的location指令块

```nginx
# Syntax
# = 前缀字符串精确匹配，匹配到了则不会进行后续匹配
# ~ 正则匹配，区分大小写
# ~* 正则匹配，不区分大小写
# ^~ 前缀字符串匹配后，匹配到了则不会进行正则匹配
# 匹配遵循最长原则
location [=|~|~*|^~] uri {...}
# @name 内部跳转
location @name {...}
# Default
---
# Context
# location 可以嵌套
server,location
```

#### preaccess阶段

##### 对连接做限制的limit_conn模块，限制客户端并发数

- 生效阶段：NGX_HTTP_PREACESS_PHASE阶段
- 模块：http_limit_conn_module
- 默认编译进nginx,通过 --without-http_limit_conn_module 禁用
- 生效范围：
  - 全部worker范围(基于共享内存)
  - 进入preaccess阶段前不生效
  - 限制的有效性取决于key的设计：依赖postread阶段的realip模块取到的真实ip

##### limit_conn指令

1. 定义共享内存

   ```nginx
   # Syntax
   # key 一般是来源ip
   # name 给下面限制并发连接数用的
   limit_conn_zone key zone=name:size;
   # Default:
   ---
   # Context
   http
   ```

2. 限制并发连接数

   ```nginx
   # Syntax
   limit_conn zone number;
   # Default
   ---
   # Context
   http,server,location
   ```

3. 限制发生时的日志级别

   ```nginx
   # Syntax
   # 日志级别可以设置小写减少error_log的压力
   limit_conn_log_level info | notice | warn | error;
   # Default
   limit_conn_log_level error;
   # Context
   http,server,location
   ```

4. 限制发生时向客户端返回的错误码

   ```nginx
   # Syntax
   # 可以修改code自定义返回状态码
   limit_conn_status code;
   # Default
   limit_conn_status 503;
   # Context
   http,server,location
   ```

###### 示例

```nginx
# limit_conn.conf
# $binary_remote_addr 二进制来源ip只有4个字节，效率高，使用他来做key
# zone=addr 定义共享内存空间名称addr
# 10m 开个10m共享内存
limit_conn_zone $binary_remote_addr zone=addr:10m;

server {
    server_name limit.taohui.tech;
    root html/;
    error_log logs/myerror.log info;
    
    location / {
        # 返回状态码500
        limit_conn_status 500;
        limit_conn_log_level warn;
        # 设置传输每秒50字节
        limit_rate 50;
        # 设置最大并发数为1
        limit_conn addr 1;
    }
}
```

##### 对连接做限制的limit_req模块，限制客户端速率

- 生效阶段：NGX_HTTP_PREACCESS_PHASE阶段
- 模块：http_limit_req_module
- 默认编译进nginx，通过 --without-http_limit_req_module 禁用功能
- 生效算法：leaky bucket 算法
- 生效范围
  - 全部worker进程(基于共享内存)
  - 进入preaccess阶段前不生效

##### limit_req指令

1. 定义共享内存（包括大小），以及key关键字和限制速率

   ```nginx
   # Syntax
   limit_req_zone key zone=name:size rate=rate;
   # Default
   ---
   # Context
   http
   # r/s 每秒请求最大数
   # r/m 没分钟请求最大数
   # rate单位r/s或者r/m
   ```

2. 限制并发连接数

   ```nginx
   # Syntax
   # burst 最大请求数
   limit_req zone=name [burst=nmber] [nodelay];
   # Default
   ---
   # Context
   http,server,location
   # burst默认0
   # nodelay, 对burst中的请求不在采用延时处理的做法，而是立刻处理
   ```

3. 限制发生时的日志级别

   ```nginx
   # Syntax
   limit_req_log_level info | notice | warn | error;
   # Default
   limit_req_log_level error;
   # Context
   http,server,location
   ```

4. 限制发生时向客户端返回的错误码

   ```nginx
   # Syntax
   limit_req_status code;
   # Default
   limit_req_status 503;
   # Context
   http,server.location
   ```

###### 示例

```nginx
# limit_conn.conf
# limit_req 在 limit_conn 前执行
# rate=2r/m 表示每分钟请求最大数为2个
limit_conn_zone $binary_remote_addr zone=addr:10m;
limit_req_zone $binary_remote_addr zone=one:10m rate=2r/m;
server {
    server_name limit.taohui.tech;
    root html/;
    error_log logs/myerror.log info;
    
    location / {
        # 返回状态码500
        limit_conn_status 500;
        limit_conn_log_level warn;
        # 设置传输每秒50字节
        limit_rate 50;
        # 设置最大并发数为1
        limit_conn addr 1;
        #limit_req zone=one burst=3 nodelay;
        limit_req zone=one;
    }
}
```

#### access阶段

##### 对ip做限制的access模块

- 生效阶段：NGX_HTTP_ACCESS_PHASE 阶段
- 模块：http_access_module
- 默认编译进nginx，通过 --without-http_access_module 禁用
- 生效范围
  - 进入access阶段前不生效

##### allow指令

```nginx
# Syntax
allow address | CIDR | unix: | all;
# Default
---
# Context
http,server,location,limit_except
```

##### deny指令

```nginx
# Syntax
deny address | CIDR | unix: | all;
# Default
---
# Context
http,server,location,limit_except
```

##### 示例

```nginx
location / {
    # 执行顺序从上往下执行
    deny 192.168.1.1;
    allow 192.168.1.0/24;
    allow 10.1.1.0/16;
    # ipv6
    allow 2001:0db8::/32;
    deny all;
}
```

#### content阶段

##### static模块

##### root和alias

```nginx
# Syntax
alias path;
# Default
---
# Context
location

# Synctax
root path;
# Default
root html;
# Context
http,server,location,if in location
```

- 功能
  - 将url映射为文件路径，以返回静态文件内容
- 差别
  - root会将完整url映射进文件路径中
  - alias只会将location后的URL映射到文件路径

##### static模块三个变量$request_filename、$document_root、$realpath_root

### referer模块防盗链

```nginx
server {
    server_name referer.taohui.tech;
    
    error_log logs/myerror.log debug;
    root html;
    location / {
        valid_referers none blocked server_names *.taohui.pub www.taohui.org.cn/nginx/ ~\.google\.;
        # $invalid_referer 为空则可以访问，不为空则为1，不可以访问
        if ($invalid_referer){
            return 403;
        }
        return 200 'valid\n';
    }
}
```

### 防盗链另一种解决方案：secure_link 模块

默认未编译进nginx，需要通过 --with-http_secure_link_module 添加





## 反向代理与负载均衡

### 负载均衡策略： round-robin

基础的负载均衡算法，使用X轴的水平扩展

```nginx
# Syntax
upstream name {...}
# Default
---
# Context
http

# Syntax
server address [parameters];
# Default
---
# Context
upstream

```

```nginx
upstream rrups {
    # weight 服务器访问权重，默认是1
    # max_conns server的最大并发连接数，仅作用于单worker进程。默认是0，表示没有限制
    # max_fails 在fail_timeout时间段内，最大的失败次数。当达到最大失败时，会在fail_timeout秒内这台server不允许再次被选择
    # fail_timeout 单位为秒，默认10秒
    server 127.0.0.1:8011 weight=2 max_conns=2 max_fails=2 fail_timeout=5;
    server 127.0.0.1:8012;
    # keeplive 最多保持多少个空闲的tcp连接
    keeplive 32;
}

server {
    server_name rrups.taohui.tech;
    error_log myerror.log info;
    
    location / {
        proxy_pass http://rrups;
        # proxy_http_version 1.1;
        # proxy_set_header Connection "";
        # 上面两个配置用户 keeplive 的配置
        proxy_http_version 1.1;
        proxy_set_header Connection "";
    }
}
```



### 负载均衡哈希算法：ip_hash 与 hash 模块

当使用Z轴的同一类用户请求分到指定服务器时，可以使用ip_hash算法

```nginx
upstream iphashups {
    # 使用 ip_hash 算法
    ip_hash;
    # 使用特定字符串作为 hash key
    #hash user_$arg_username;
    server 127.0.0.1:8011 weight=2 max_conns=2 max_fails=2 fail_timeout=5;
    server 127.0.0.1:8012 weight=1;
}

server {
    # 设置可信任IP
    set_real_ip_from 116.62.160.193;
    real_ip_recursive on;
    # 使用 X-Forwarded-For 获取原始IP地址
    real_ip_header X-Forwarded-For;
    server_name iphash.taohui.tech;
    error_log myerror.log info;
    
    
    
    location / {
        proxy_pass http://iphashups;
        # proxy_http_version 1.1;
        # proxy_set_header Connection "";
        # 上面两个配置用户 keeplive 的配置
        proxy_http_version 1.1;
        proxy_set_header Connection "";
    }
}
```

### 一致性hash算法

宕机或者扩容时，hash算法引发大量路由变更，可能导致缓存大范围失效

```nginx
# Syntax
# hash user_$arg_username [consistent];
hash key [consistent];
# Default
---
# Context
upstream
```

### 优先选择连接最少的上游服务器：upstream_least_conn模块

```nginx
# Syntax
least_conn;
# Context
upstream
```

### 使用共享内存使负载均衡策略对所有worker进程生效：upstream_zone模块

```nginx
# Syntax
zone name [size];
# Context
upstream
```

### proxy模块

```nginx
# Syntax
proxy_pass URL;
# Context
location,if in location,limit_except
```

[test][1]

## Nginx的系统层性能优化

## 从源码视角深入使用Nginx和OpenResty

[1]: https://www.bilibili.com/video/BV1S54y1R7SB