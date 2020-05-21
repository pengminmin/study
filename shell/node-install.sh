#!/bin/bash

Node_Install()
{
	#安装wget
	yum install -y wget
	#下载nodejs最新的tar包
	wget https://nodejs.org/dist/v12.16.2/node-v12.16.2-linux-x64.tar.xz
	#解压包
	tar -xvf node-v12.16.2-linux-x64.tar.xz
	#部署bin文件
	ln -s `pwd`/node-v12.16.2-linux-x64/bin/node /usr/bin/node
	ln -s `pwd`/node-v12.16.2-linux-x64/bin/npm /usr/bin/npm
	#测试
	node -v
	npm -v
}

echo "开始安装node"
Node_Install
echo "node安装完成"