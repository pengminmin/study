# 备份MySQL数据库
一台MySQL服务器，跑着5个数据库，在没有主从的情况下，需要对5个库进行备份，具体要求如下:  
1. 每天备份1次，需要备份所有的库
2. 把备份数据存放到/data/backup/下
3. 备份文件名称格式示例: database_name-2018-11-11.sql
4. 需要对1天以前的所有sql文件压缩，格式为gzip
5. 本地数据保留1周
6. 需要把备份的数据同步到远程备份中心，假如本机可以直接通过rsync命令同步，同步目标地址为rsync://10.10.20.100/mysqlbak/
7. 远程备份数据要求保留1个月
## [mysqldump命令](mysqldump.md)

## [date命令](date.md)

## [找出一天以前的文件，find命令](find.md)

## [gzip压缩](gzip.md)

## [rsync远程同步数据工具](rsync.md)

## [backup.sh](backup.sh)