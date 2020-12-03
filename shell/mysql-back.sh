#!/bin/bash
# 数据库备份

mysqldump="/usr/bin/mysqldump"
bakuser="backup"
password="123123"
bakdir="/data/backup"
d1=`date +%F`
d2=`date +%d`

# 定义日志
exec & > /tmp/mysql_bak.log

echo "mysql backup begin at `date`"

# 对所有数据库进行遍历
for db in db1 db2 db3 db4 db5
do
  $mysqldump -u$bakuser -p$password $db >$bakdir/$db-$d1.mysql
done

# 对 1 天前的所有 sql 文件压缩
find $bakdir/ -type -f -name "*.sql" -mtime +1 | xargs gzip

# 查找一周以前的老文件，并删除
find $bakdir/ -type f -mtime +7 | xargs rm

echo "mysql backup end at `date`"