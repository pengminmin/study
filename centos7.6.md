## 查看磁盘

```bash
df -h
```

## 查看内存

```shell
free -mh
```

## 开机自启动

```shell
systemctl enable nginx
```

## 取消开机自启动

```shell
systemctl disable nginx
```

## sha256 验证

```shell
sha256sum php-7.3.19.tar.gz > a
cat a 
# 809126b46d62a1a06c2d5a0f9d7ba61aba40e165f24d2d185396d0f9646d3280 php-7.3.19.tar.gz
```



### 安装 PHP

```shell
# 好的 blog
# https://blog.csdn.net/PHPArchitect/article/details/88555810

```

### 异常

-  Cannot find OpenSSL's <evp.h>

  ```shell
  # 好的 blog
  # https://www.cnblogs.com/onephp/p/6119836.html
  yum install -y openssl-devel
  ```

- checking for libzip... configure: error: system libzip must be upgraded to version >= 0.11

  ```shell
  # 好的blog
  # https://blog.csdn.net/kiramario/article/details/106231833?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase
  ```

  