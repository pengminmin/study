#!/bin/bash

Redis_Install()
{
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
}

echo "开始安装redis"
Redis_Install
echo "结束安装redis"
