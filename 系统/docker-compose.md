## 安装

1. 安装命令

   > ```shell
   > sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   > ```

2. 添加执行权限

   > ```shell
   > sudo chmod +x /usr/local/bin/docker-compose
   > ```

3. 添加软连接

   > ```shell
   > sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
   > ```

4. 查看版本

   > ```shell
   > docker-compose --version
   > ```

## 卸载

> ```shell
> sudo rm /usr/local/bin/docker-compose
> ```

## pip安装

推荐pip安装，因为pip安装会为你自动对应版本问题。

1. 安装pip

   > ```shell
   > yum -y install epel-release
   > yum -y install python-pip
   > ```

2. 确认版本

   > ```shell
   > pip --version
   > ```

3. 更新pip

   > ```undefined
   > pip install --upgrade pip
   > ```

4. 安装docker-compose

   > ```shell
   > pip install docker-compose 
   > ```

5. 查看版本

   > docker-compose version

