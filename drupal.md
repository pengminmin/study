## 基础概念

实体、插件、释文、钩子、主题、区块

### 实体-Entity

实体官方解释：客观存在并可相互区别的事物。指的是存放信息及操作方法的容器。

实体就是包含数据和操作方法

### 插件-



```bash
https://jengacorp.com/order-form/58
https://jengacorp.com/order-form/59
https://jengacorp.com/order-form/66



1.of改成to
测试地址: http://116.62.134.184:9797/order-form/58
测试地址修改好了，没问题我就同步修改线上地址
2.标题和下面内容之间的距离有点太宽
其它页面标题和下面内容之间的距离是一样的
3.红色字体下面请加上下划线
测试地址: http://116.62.134.184:9797/order-form/65
测试地址修改好了，没问题我就同步修改线上地址
4.字体间距不对
这个字体间距如果要和设计稿一致，效果有点奇怪
```

## drupal安装

```bash
# 创建项目目录
mkdir drupal
# 进入目录
cd drupal
# 下载最新drupal最新版本并解压
# --strip-components=1 表示解压去除第一层目录结构
curl -sSL https://www.drupal.org/download-latest/tar.gz | tar -xz --strip-components=1
```

## drupal console 安装

```bash
# 推荐使用composer安装
composer require "drupal/console"
```

## Commerce安装

```bash
# 推荐使用composer安装
composer require "drupal/commerce"
```

- 使用commerce模块

```bash
# 使用drupal console工具安装模块
drupal module:install commerce_product commerce_checkout commerce_cart
```

## 中文语音包

```bash
# 地址
https://ftp.drupal.org/files/translations/8.x/drupal/
# 表示 8.8.5版本简体中文包
drupal-8.8.5.zh-hans.po
# 表示 8.8.5版本繁体中文包
drupal-8.8.5.zh-hant.po 
```

## session

drupal中的session需要修改php.ini中的 session.auto_start = 1 改为 0



