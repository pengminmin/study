#!/bin/bash
##该脚本用来备份本机数据库
##本地保留一周，远程保留一个月

mysqldump="/usr/local/mysql/bin/mysqldump"
backuser="backup"
passwd="34KpmyzUq"
bakdir="/data/backup"
remote_dir="rsync://10.10.20.100/mysqlbak"
d1=`date +%F`
d2=`date +%d`

#定义日志
exec &> /tmp/mysql_bak.log
# &> 指定正确输出和错误输出到 /tmp/mysql_bak.log

echo "mysql backup begin at `date`"

#对所有数据库进行遍历
for db in db1 db2 db3 db4 db5
do
    $mysqldump -u$backuser -p$passwd $db > $bakdir/$db-$d1.sql
done

#对1天前的所有sql文件压缩
find $bakdir/ -type f -name "*.sql" -mtime +1 |xargs gzip

#查找1周前的老文件，并删除
find $bakdir/ -type f -mtime +7 |xargs rm

#把当天的备份文件同步到远程
for db in db1 db2 db3 db4 db5
do
    rsync -a $bakdir/$db-$d1.sql $remote_dir/$db-$d2.sql
done

echo "mysql backup end at `date`"