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
   > 
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
   > ```

