1. 配置阿里云

   > ```shell
   > # composer 阿里云地址
   > # https://developer.aliyun.com/composer
   > # 全局配置
   > composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
   > # 取消全局配置
   > composer config -g --unset repos.packagist
   > # 项目配置
   > composer config repo.packagist composer https://mirrors.aliyun.com/composer/
   > # 取消项目配置
   > composer config --unset repos.packagist
   > # 调试
   > composer -vvv require alibabacloud/sdk
   > # 版本升级
   > composer self-update
   > # 执行诊断
   > composer diagnose
   > # 清除缓存
   > composer clear
   > # 更新composer.lock文件
   > composer update --lock
   > 
   > drupal chain --file="C:\Users\tom\.console\chain\quick-start.yml"
   > 
   > php -r "readfile('drupal');" | php
   > # dumpautoload
   > composer dumpautoload
   > # 等价于
   > composer dump-autoload
   > ```

2. 取消配置

   > ```shell
   > composer config -g --unset repos.packagist
   > ```

3. 查看配置

   > composer config -g --list
   >
   > //或者
   >
   > composer config -gl

4. 配置中国镜像

   > ```bash
   > composer config -g repo.packagist composer https://packagist.phpcomposer.com
   > 
   > ```

5. 安装指定版本

   ```bash
   composer require drupal/commerce "^2.13"
   ```

   

## composer 多线程配置

```bash
composer global require hirak/prestissimo
```

## centos7 安装 composer

```bash
# 使用命令下载
curl -sS https://getcomposer.org/installer | php
# 移动到 /usr/local/bin 下
mv composer.phar /usr/local/bin/composer
# 修改权限
chmod -R 777 /usr/local/bin/composer
```

