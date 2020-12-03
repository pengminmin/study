## dnmp

> ```
> https://github.com/yeszao/dnmp
> ```



## docker 命令

### docker pull

```bash
# pull 默认last版本
docker pull php
# pull 指定版本
docker pull php:7.3
```

### docker inspect

```bash
# 查镜像详细信息
# 76a5dae0c884 是 IMAGE ID
docker inspect 76a5dae0c884

docker inspect 470671670cac


docker inspect 5e35e350aded

```

### docker run

```bash
# --rm 容器停止自动删除
docker run -itd --rm --name ubuntu-test ubuntu
# run 指定版本
docker run -itd --rm centos:7
```

### docker exec

```bash
docker exec -it 434 /bin/bash
docker exec -it 434 bash
```

### docker commit

```bash
# 将正在运行的容器导入到自定义镜像中
docker commit cac test/centos:v1
```

### docker export

```bash
# 将容器导出
docker export -o cac.tar cac
```

### docker import

```bash
# 导入镜像文件
docker import cac.tar learn/centos-v3:v3
# 启动镜像,要加个bash
docker run -itd --rm 199 bash
```

### docker save

```bash
# 导出镜像
docker save -o nginx.tar nginx:laster
```

### docker load

```bash
# 导入镜像
docker load -i nginx.tar
```

### docker tag

```bash
# 镜像重命名
docker tab 9f48be9166e3 learn/nginx-v1:v1
```

## docker-compose 配置

```yml
# :ro 表示只读 :rw 表示可读可写
- ${SOURCE_DIR}:/www/:rw
```

## docker 安装脚本

```bash
#!/bin/bash

remove_docker(){
	yum remove docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-engine
}

```

