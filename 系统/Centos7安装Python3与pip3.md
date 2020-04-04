1. 下载示例

   > ```shell
   > wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
   > ```

2. 解压文件

   > ```shell
   > tar -xf Python-3.6.1.tgz
   > ```

3. 进入解压目录

   > ```shell
   > cd Python-3.6.1
   > ```

4. 安装依赖

   > ```shell
   > yum install gcc-c++
   > yum install pcre pcre-devel
   > yum install zlib zlib-devel
   > yum install openssl openssl--devel
   > # 整理下
   > yum install -y gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl--devel
   > ```

5. 编译安装

   > ```shell
   > #创建目录
   > mkdir /usr/Python-3.6.1
   > #绑定安装目录
   > ./configure --prefix=/usr/Python-3.6.1
   > #编译初始化
   > make
   > #安装
   > make install
   > ```

6. 创建软链接

   > ```shell
   > ln -s /usr/Python-3.6.1/bin/python3 /usr/bin/python3
   > ```

7. 测试

   > python3

8. pip创建软链接

   > ln -s /usr/Python-3.6.1/bin/pip3 /usr/bin/pip3

9. TODO 删除，卸载