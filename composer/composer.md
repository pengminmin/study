1. 配置阿里云

   > ```shell
   > composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
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