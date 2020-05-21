#!/bin/bash



Install_Docker()
{
	#安装依赖
	yum install -y yum-utils device-mapper-persistent-data lvm2
	#添加软件源
	yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
	#安装docker-ce
	yum clean all
	yum makecache fast
	yum install -y docker-ce
	#启动服务
	systemctl start docker
	#查看版本
	docker version


}
echo "安装docker"
Install_Docker
echo "完成"