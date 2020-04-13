# 狂神聊Redis

- nosql讲解
- 阿里巴巴架构演进
- nosql数据模型
- nosql四大分类
- CAP
- BASE
- Redis入门
- Redis安装(Window & Linux)
- 五大基本数据类型
  - String
  - List
  - Set
  - Hash
  - Zset
- 三种特殊数据类型
  - geo
  - hyperloglog
  - bitmap
- Redis配置详解
- Redis持久化
  - RDB
  - AOF
- Redis 事务操作
- Redis 实现订阅发布
- Redis 主从复制
- Redis 哨兵模式
- 缓存穿透及解决方案
- 缓存击穿及解决方案
- 缓存雪崩及解决方案
- 基础API之jedis 详解
- SpringBoot 集成 Redis操作
- Redis 的实践分析

## Nosql概述

### 为什么要用Nosql

1. 单机模式
2. 读写分离，垂直拆分
3. 分库分表，水平拆分
4. 现在数据爆炸增长

### 什么是NoSQL

### NoSQL的四大分类

- 键值对
  - Redis
- 文件储存
  - mongoDb
- 列存储
- 拓扑存储，关系存储，图存储

## Redis 入门

### 概述

- 定义
- 能干什么
- 特性

### 安装

#### windows 安装



#### linux安装

```shell
# 下载
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
# 解压
tar -zxvf redis-5.0.5.tar.gz
# 进入解压的redis文件夹
cd redis-5.0.5
# 安装依赖
yum install -y gcc-c++
# 查看gcc版本
gcc -v
# 编译安装
make && make install
# 进入redis命令文件夹
cd /usr/local/bin
# 复制配置文件
mkdir redis-config
cp /opt/redis-5.0.5/redis.conf ./
# 修改配置文件
cd redis-config
vim redis.conf
# 将 daemonize 改为yes，效果是将redis 设置为后台启动
# 修改完后使用自定义配置启动redis
redis-server redis-config/redis.conf
# cli链接redis
redis-cli
# 测试命令
ping
set name tom
get name
keys *
# 关闭redis
shutdown
# 退出cli
exit
# 启动redis
redis-server redis-config/redis.conf
# 查看redis服务
ps -ef | grep redis
```

#### redis-benchmark 性能测试

```bash
# 100个并发，10万请求
redis-benchmark -c 100 -n 100000
```

#### 基础知识

redis 默认有16个数据库

```bash
# 默认选择第0个数据库
# 查看所有的key
keys *
# 查看数据库大小
dbsize
# 设置值
set name tom
# 获取值
get name
# 切换数据库,切换到3号数据库
select 3
# 清空当前数据库
flushdb
# 清空所有数据库
flushall
```

## 五大数据类型

### Redis-Key

```bash
# 查看所有的key
keys *
# 设置key
set name tom
# 获取key 的值
get name
# 查看 key 是否存在
exists name
# 删除 key , 1 是 db
move name 1
# 设置key过期时间
expire name 10
# 查看key剩余时间
ttl name

127.0.0.1:6379> flushall
OK
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> set name tom
OK
127.0.0.1:6379> exists name
(integer) 1
127.0.0.1:6379> move name 1
(integer) 1
127.0.0.1:6379> exists name
(integer) 0
127.0.0.1:6379> set name tom 10
(error) ERR syntax error
127.0.0.1:6379> exists name
(integer) 0
127.0.0.1:6379> set name tom
OK
127.0.0.1:6379> exists name
(integer) 1
127.0.0.1:6379> keys *
1) "name"
127.0.0.1:6379> expire name 10
(integer) 1
127.0.0.1:6379> ttl name
(integer) 8
127.0.0.1:6379> ttl name
(integer) 4
127.0.0.1:6379> keys *
(empty list or set)
127.0.0.1:6379> exists name
(integer) 0
# 查看 key 类型
127.0.0.1:6379> set name tom
OK
127.0.0.1:6379> set age 10
OK
127.0.0.1:6379> type name
string
127.0.0.1:6379> type age
string
127.0.0.1:6379> 

```

### String(字符串)

```bash
# set
# get
# exists
# append
# strlen
127.0.0.1:6379> flushall     # 清空所有数据库
OK 
127.0.0.1:6379> set key1 v1   # 设置值
OK
127.0.0.1:6379> get key1       #获取值
"v1"
127.0.0.1:6379> keys *         # 获得所有的key
1) "key1"
127.0.0.1:6379> exists key1    # 判断 key1 是否存在
(integer) 1
127.0.0.1:6379> append key1 hello # 追加字符串
(integer) 7
127.0.0.1:6379> get key1 
"v1hello"
127.0.0.1:6379> strlen key1  # 获取字符串长度
(integer) 7
127.0.0.1:6379> append key1 alihal
(integer) 13
127.0.0.1:6379> strlen key1
(integer) 13
127.0.0.1:6379> get key1
"v1helloalihal"
127.0.0.1:6379> 

127.0.0.1:6379> keys *
1) "key1"
127.0.0.1:6379> append age 10 # 当key 不存在,append相对于 set key
(integer) 2
127.0.0.1:6379> get age
"10"
127.0.0.1:6379> 
############################################
# i++
# i+=
127.0.0.1:6379> set views 0
OK
127.0.0.1:6379> get vies
(nil)
127.0.0.1:6379> get views
"0"
127.0.0.1:6379> incr views  # i++
(integer) 1
127.0.0.1:6379> incr views
(integer) 2
127.0.0.1:6379> incr views
(integer) 3
127.0.0.1:6379> get views
"3"
127.0.0.1:6379> decr views  # i--
(integer) 2
127.0.0.1:6379> decr views
(integer) 1
127.0.0.1:6379> decr views
(integer) 0
127.0.0.1:6379> decr views
(integer) -1
127.0.0.1:6379> get views
"-1"
127.0.0.1:6379> incrby views 10 # i+=10
(integer) 9
127.0.0.1:6379> incrby views 10
(integer) 19
127.0.0.1:6379> decrby views 10  # i-=10
(integer) 9
127.0.0.1:6379> decrby views 10
(integer) -1
127.0.0.1:6379> get views
"-1"
127.0.0.1:6379> decrby views 10
(integer) -11
127.0.0.1:6379> get views
"-11"
############################################
# range 字符串范围
127.0.0.1:6379> set key1 hello,world
OK
127.0.0.1:6379> get key1
"hello,world"
127.0.0.1:6379> getrange key1 0 3 # 获取[0,3]
"hell"
127.0.0.1:6379> getrange key1 0 -1 # 获取所有字符串
"hello,world"

#  setrange 替换
127.0.0.1:6379> set key2 abcdefg   # 设置 key2 的值
OK
127.0.0.1:6379> get key2           # 获取 key2 的值
"abcdefg"
# 替换 从下标为2 替换xx
127.0.0.1:6379> setrange key2 2 xx
(integer) 7
127.0.0.1:6379> get key2
"abxxefg"
############################################
# setex (set with expire) # 设置过期时间
# setnx (set if not exists) # 不存在再设置 (常用于分布式锁中)
# 设置 key3 的值为hello过期时间为30秒
127.0.0.1:6379> setex key3 30 hello
OK
# 查看 key3 剩余过期时间
127.0.0.1:6379> ttl key3
(integer) 27
127.0.0.1:6379> ttl key3
(integer) 25
# 如果mykey不存在设置值为redis
127.0.0.1:6379> setnx mykey redis
(integer) 1
# 查看所有key
127.0.0.1:6379> keys *
1) "key2"
2) "key1"
3) "key3"
4) "mykey"
# 查看key3剩余过期时间
127.0.0.1:6379> ttl key3
(integer) 9
# 如果mykey不存在设置值为mongoDB
127.0.0.1:6379> setnx mykey mongoDB
(integer) 0
# 获取mykey的值
127.0.0.1:6379> get mykey
"redis"
# 获取key3的值
127.0.0.1:6379> get key3
(nil)
127.0.0.1:6379> 
############################################
# mset 同时设置多个值
# mget 同时获取多个值
# msetnx 如果不存在，同时设置多个值
# 清空当前数据库
127.0.0.1:6379> flushdb
OK
# 获取所有key
127.0.0.1:6379> keys *
(empty list or set)
# 同时设置多个值
127.0.0.1:6379> mset k1 v1 k2 v2 k3 v3
OK
# 获取所有key
127.0.0.1:6379> keys *
1) "k2"
2) "k1"
3) "k3"
# 同时获取多个key的值
127.0.0.1:6379> mget k1 k2 k3
1) "v1"
2) "v2"
3) "v3"
# msetnx 是一个原子性操作，要么一起成功，要么一起失败
127.0.0.1:6379> msetnx k1 v1 k4 v4
(integer) 0
# 获取 k4 的值
127.0.0.1:6379> get k4
(nil)
# 获取所有key
127.0.0.1:6379> keys * 
1) "k2"
2) "k1"
3) "k3"
############################################
# 对象
# 设置 user:1 对象的值为 json 字符串
127.0.0.1:6379> set user:1 {name:zhangsan,age:3}
OK
127.0.0.1:6379> get user
(nil)
127.0.0.1:6379> get user:1:name
(nil)
127.0.0.1:6379> get user:1
"{name:zhangsan,age:3}"
# 这里的key是一个巧妙的设计： user:{id}:{filed} 在Redis是完全OK的
127.0.0.1:6379> mset user:1:name tom user:1:age:18
(error) ERR wrong number of arguments for MSET
127.0.0.1:6379> mset user:2:name ali user:2:age 12
OK
127.0.0.1:6379> mget user:2:name user:2:age
1) "ali"
2) "12"
127.0.0.1:6379> mset article:100:views 10
OK
127.0.0.1:6379> get article:100:views
"10"
127.0.0.1:6379> 

############################################
# getset 先get然后再set
# 如果不存在值，返回nil
127.0.0.1:6379> getset db redis
(nil)
127.0.0.1:6379> get db
"redis"
# 如果存在值，先返回原来的值，并设置新的值
127.0.0.1:6379> getset db mongodb
"redis"
127.0.0.1:6379> get db
"mongodb"

############################################
```

### List(队列)

