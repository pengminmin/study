## 安装

### PHP扩展

```shell
# php 版本7.2.9 可以正常安装 drupal
php_curl
php_fileinfo
php_gd2
php_mbstring
php_mysqli
php_opcache
php_openssl
php_pdo_mysql
php_pdo_sqlite
```

### nginx配置

```shell
try_files $uri $uri/ /index.php?$query_string;
```





## 日常维护

### 模块管理

#### 项目管理相关命令  pm

```shell
drush | grep pm
```

#### 下载模块

```shell
# 下载 pathauto 模块
drush dl pathauto
# 查看模块信息
drush pmi pathauto
# 手工选择要下载的版本
drush dl pathauto --select
```

#### 启用模块

```shell
drush en pathauto
# 自动输入 y
drush en pathauto -y
drush en flag -y
```

#### 禁用模块

```shell
drush dis overlay
# 自动输入y
drush dis overlay -y
# 查看模块信息
drush pmi overlay
```

#### 卸载模块

```shell
# 先禁用模块
drush dis flag
# 自动输入 y
drush dis flag -y
# 卸载模块
drush pmu flag
# 自动输入 y
drush pmu flag -y
```

#### 升级 Drupal 核心与 Drupal 模块

```shell
# 刷新要更新的信息
drush rf
# 检查更新信息
drush pm-updatestatus
# 设置维护模式
drush vset maintenance_mode 1
# 升级 drupal 核心
drush up drupal
# 查看 drupal 版本信息
drush status
# 升级 pathauto 模块，自动输入 y
drush up pathauto -y
# 查看可更新信息
drush pm-updatestatus
# 关掉维护模式
drush vset maintenance_mode 0
```

### 用户管理

#### 用户与角色

```shell
# 查看 user 开头的命令
drush | grep user-
# 查看角色相关命令
drush | grep role-
```

#### 用户管理

```shell
# 创建用户
drush user-create xiaoxue --mail="xiaoxue@163.com" --password="123456"
# 阻止用户登录
drush user-block xiaoxue
# 查看用户状态
drush user-information xiaoxue
# 解冻用户
drush user-unblock xiaoxue
# 删除用户
drush user-cancel xiaoxue
```

#### 找回用户密码

```shell
# 创建用户 ucrt 是 user-create 的简写
drush ucrt xiaoxue --mail="xiaoxue@163.com"
# 生成一次性登录链接
drush user-login xiaoxue
# 设置密码
drush user-password xiaoxue --password="123456"
# drush 8 没有 --password 参数
drush user-password xiaoxue "123456"
drush user-password administrator "123456"
```

#### 角色管理

```shell
# 查看网站所有用户角色
drush rls
# 创建角色
drush role-create member
# 删除角色
drush role-delete member
```

#### 角色权限

```shell
# 创建角色
drush role-create author
# 给角色添加权限，给 author 添加模块 node 的权限
drush role-add-perm author --module=node
# 给角色删除权限
drush role-remove-prem author --module=node
# 给用户添加角色权限
drush user-add-role author xiaoxue
# 给用户删除角色权限
drush user-remove-role author xiaoxue
# 查询用户信息
drush user-information xiaoxue
```

### 备份与恢复

#### 备份

```shell
drush archive-dump
```

#### 恢复备份

```shell
# 删除数据库， demo_test 是数据库名称
mysqladmin -u root -p drop demo_test;
# 创建数据库
mysqladmin -u root -p create demo_test;
# 恢复网站，备份的压缩包
drush archive-restore demo_test.20140905_051418.tar.gz --destination=/vargant/www
```

#### 导出与导入数据库

```shell
# 清理缓存
drush cc
# 导出数据库
drush sql-dump > ~/demo_test_backup.sql
# 删除数据库
drush sql-drop
# 导入数据库
drush sql-cli < ~/demo_test_backup.sql

```

### 更新翻译

```shell
# 下载备份用的模块
drush en backup-migrate -y
# 查看模块配置界面
drush pmi backup_migrate
# 选择下早模块版本
drush dl l10n_update --select
# 启用模块
drush en l10n_update -y
# 查看 l10n 命令
drush | grep l10n
# 刷新下可用的翻译更新
drush l10n-update-refresh
# 更新下 l10n,下载模块翻译文件
drush l10n-update


```

## 字段

### 安装

#### 安装 Drush8 - 升级 drush

```shell
# 查看 drush 版本
drush --version
# 升级 composer
sudo /usr/local/bin/composer self-update
# 删除 drush
composer global remove drush/drush
# 更新 composer
composer global update
# composer 安装 drush 开发版本
composer global require dursh/drush:dev-master
# 查看 drush 版本
drush --version
```

#### 安装 Drupal8 - 准备

```shell
drush dl drupal-8
```



```shell
  'database' => 'jenga_production',
  'username' => 'jenga_prod_user',
  'password' => 'co2ykH9Vsi0J8HXe',
```





47.241.59.93