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

9. PHP Fatal error:  Interface 'JsonSerializable' not found

   ```bash
   yum install -y php-json
   ```

10. SQLSTATE[HY000] [2002] No such file or directory

    ```bash
    localhost 改为 127.0.0.1
    
    新的jengacorp
    
    ```

11. PHP message: Uncaught PHP Exception RuntimeException: "The bcmath extension is required by CurrencyFormatter."

    ```bash
    yum install -y php-bcmath
    
    # 报错
    Error: php72w-common conflicts with php-common-5.4.16-46.1.el7_7.x86_64
     You could try using --skip-broken to work around the problem
     You could try running: rpm -Va --nofiles --nodigest
     # 运行
    yum install -y php72w-bcmath
    
    ```

12. /bin/bash^M: bad interpreter: No such file or directory

    ```bash
     查看脚本文件是dos格式还是unix格式的几种办法。
    （1）cat -A filename  从显示结果可以判断，dos格式的文件行尾为^M$，unix格式的文件行尾为$。
    （2）od -t x1 filename 如果看到输出内容中存在0d 0a的字符，那么文件是dos格式，如果只有0a，则是unix格式。
    （3）vi filename打开文件，执行 : set ff，如果文件为dos格式在显示为fileformat=dos，如果是unxi则显示为fileformat=unix。
    
      解决方法：
    （1）使用linux命令dos2unix filename，直接把文件转换为unix格式
    （2）使用sed命令sed -i "s/\r//" filename  或者 sed -i "s/^M//" filename直接替换结尾符为unix格式
    （3）vi filename打开文件，执行 : set ff=unix 设置文件为unix，然后执行:wq，保存成unix格式。
    ```

13. 2020/04/09 11:15:48 [error] 1472#46096: *41 FastCGI sent in stderr: "Uncaught PHP Exception Drupal\Core\Extension\InfoParserException: "Missing required keys (core) in modules/contrib/plugin/plugin.info.yml" at D:\www\jengacorp-backend\core\lib\Drupal\Core\Extension\InfoParserDynamic.php line 29" while reading response header from upstream, client: 127.0.0.1, server: jengacorp-backend.com, request: "GET /admin/modules HTTP/1.1", upstream: "fastcgi://127.0.0.1:9000", host: "jengacorp-backend.com", referrer: "http://jengacorp-backend.com/admin/modules"

    ```bash
    # 在怕plugin.info.yml中添加core字段
    core: 8.x
    ```

14. ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock'

    ```bash
    
    ```

15. ERROR 1819 (HY000): Your password does not satisfy the current policy requirements

    ```bash
    set global validate_password_policy=0;
    set global validate_password_length=1;
    ```

16. unix:/run/php-fpm/www.sock failed (13: Permission denied) while connecting to upstream,

    ```bash
    # 修改php-fpm.d/www.conf中user group 与nginx一致
    # 查看php-fpm运行用户
    ps -ef | grep php-fpm
    # 查看nginx 运行用户
    ps -ef | grep nginx
    # 修改www.conf中listen.mode=0666
    ```

17. SQLSTATE[HY000] [1045]

    ```bash
    grant all on jenga_production to 'jenga_prod_user'@'localhost';
    flush privileges;
    set password for jenga_prod_user=password("co2ykH9Vsi0J8HXe");
    
    update user set password=password("co2ykH9Vsi0J8HXe") where user="jenga_prod_user";
    
    set password fro "jenga_prod_user"@"localhost"=password("co2ykH9Vsi0J8HXe");
    
    ```
# 创建用户并授权
    create user 'jenga_prod_user'@'localhost' identified by 'co2ykH9Vsi0J8HXe';
    
    select host,user,password from user;
    select host,user,authentication_string from user;
    update mysql.user set password='co2ykH9Vsi0J8HXe' where user='jenga_prod_user';
    
    update mysql.user set authentication_string='co2ykH9Vsi0J8HXe' where user='jenga_prod_user';
    
    mysql -ujenga_prod_user -p
    co2ykH9Vsi0J8HXe
    
    set PASSWORD for 'jenga_prod_user'@'localhost'=PASSWORD('co2ykH9Vsi0J8HXe');
    set PASSWORD for 'jenga_prod_user'=PASSWORD('co2ykH9Vsi0J8HXe');
    
    # 创建用户
    create user 'jenga_prod_user'@'localhost' identified by 'co2ykH9Vsi0J8HXe';
    
    # 授权
    grant all on jenga_production.* to 'jenga_prod_user'@'localhost';
    
    # 刷新权限
    flush privileges;
    
    116.62.134.184:9798
    116.62.134.184:9797
    116.62.134.184:8088
    116.62.134.184:9009
    116.62.134.184:8089
    116.62.134.184:80
    # 需要开 8089 8088 安全组
    # rap2 前端
    116.62.134.184:8080
    
    goaccess access.log -o /var/www/html/report.html --real-time-html --time-format='%H:%M:%S' --date-format='%d/%b/%Y' --log-format=COMBINED
    
    # 测试环境
    # jengacorp后台
    116.62.134.184:9798
    # jengacorp前端
    116.62.134.184:9797
    # vidy后台
    116.62.134.184:8889
    # vidy的API
    116.62.134.184:8088
    # rap2前端
    116.62.134.184
    
    还需要开个8088的安全组给vidy的api服务
    还需要开个8089的安全组端口给haokanadmin
    
    ```


​    

## win10 中 virtualbox 报错：`Call to VidMessageSlotMap failed: Last=0xc000000d/87 (VERR_NEM_VM_CREATE_FAILED).`

```bash
# 需要关闭 Hyper-V 和 Containers
```

## Call to VidMessageSlotMap failed: Last=0xc000000d/87 (VERR_NEM_VM_CREATE_FAILED).

必须以管理员的身份启动window命令窗口并运行 `bcdedit /set hypervisorlaunchtype off`

然后重启电脑