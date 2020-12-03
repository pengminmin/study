#!/bin/bash
# 数据库备份

mysqldump="/usr/bin/mysqldump"
bakuser="jenga_prod_user"
password="co2ykH9Vsi0J8HXe"
database="jenga_production"
bakdir="/home/ubuntu/mysqlbak/data"
# 2020-07-28
d1=`date +%F`

# 定义日志
exec &> /tmp/mysql_bak.log

echo "mysql backup begin at `date`"

$mysqldump -u$bakuser -p$password $database > $bakdir/$database-$d1.sql

# 对 1 天前的所有 sql 文件压缩
find $bakdir/ -type f -name "*.sql" -mtime +1 | xargs gzip

# 查找一周以前的老文件，并删除
find $bakdir/ -type f -mtime +7 | xargs rm

echo "mysql backup end at `date`"