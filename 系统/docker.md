## 安装

1. 安装依赖

   > yum install -y yum-utils device-mapper-persistent-data lvm2

2. 添加软件源

   > yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
   >
   > 

3. 安装docker-ce

   > yum clean all
   >
   > yum makecache fast
   >
   > yum install -y docker-ce

4. 启动服务

   > systemctl start docker

5. 查看版本

   > docker version

## 配置阿里云镜像加速器

```shell
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://iepup74k.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## TUDO

1. 简单配置dnmp
2. 镜像加扩展
3. 编排

### nginx

```shell
# /etc/nginx/conf.d 挂载不上去
# 加上 --privileged=true
docker run --name web -p 80:80 -v ~/nginx/www:/usr/share/nginx/html -v ~/nginx/conf/conf.d:/etc/nignx/conf.d --privileged=true 
-d --link myphp-fpm:php nginx
```

