1. 跨域问题

   ```php
   header('Access-Control-Allow-Origin: *');
   header('Access-Control-Allow-Origin: https://jengacorp.com');
   ```

2. 服务器磁盘满了，可能导致mysql停止服务

   ```shell
   # 原因是磁盘满了，mysql自动保护机制会停止服务
   service mysql status
   service mysql restart
   ```

3. React项目打包后的文件路由访问404

   ```shell
   # 这个是React路由需要nginx配置隐藏index.html
   try_files $uri $uri/ /index.html?$query_string
   ```

4. 不同域名ajax请求失去cookie

   ```shell
   https://blog.csdn.net/fdipzone/article/details/54576626
   ```

5. 编译安装PHP时可能会报错

   ```shell
   # Please reinstall the BZip2 distribution
   yum install -y bzip2 bzip2-devel
   # checking for cURL 7.10.5 or greater... configure: error: cURL version 7.10.5 or later is required to compile php with cURL support
   yum install -y curl-devel
   ```

6. docker run nginx时，/etc/nginx/conf.d挂载不进去，应该是权限问题

   ```shell
   # 加上 --privileged=true
   docker run --name web -p 80:80 -v ~/nginx/conf/conf.d:/etc/nignx/conf.d --privileged=true 
   -d nginx
   ```

7. win10 查看8080端口被占用

   ```shell
   netstat -ano | findstr 8080
   # 通过 pid 查看程序
   tasklist | findstr 6556
   ```

8. php -v

   ```shell
   Warning: Module 'mysqli' already loaded in Unknown on line 0
   
   Deprecated: Directive 'track_errors' is deprecated in Unknown on line 0
   PHP 7.2.9 (cli) (built: Aug 15 2018 23:09:20) ( NTS MSVC15 (Visual C++ 2017) x64 )
   Copyright (c) 1997-2018 The PHP Group
   Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
       with Zend OPcache v7.2.9, Copyright (c) 1999-2018, by Zend Technologies
     
   # php.ini 中注释掉 msqli 扩展
   
   Deprecated: Directive 'track_errors' is deprecated in Unknown on line 0
   PHP 7.2.9 (cli) (built: Aug 15 2018 23:09:20) ( NTS MSVC15 (Visual C++ 2017) x64 )
   Copyright (c) 1997-2018 The PHP Group
   Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
       with Zend OPcache v7.2.9, Copyright (c) 1999-2018, by Zend Technologies
   
   # php.ini 中注释掉 track_errors 扩展
   ```

   
