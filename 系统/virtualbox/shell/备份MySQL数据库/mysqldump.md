## mysqldump    
用户名backup 密码34KpmyzUq  
` mysqldump -ubackup -p34KpmyzUq db1 > db1.sql `  
加上IP和Port  
` mysqldump -ubackup -p34KpmyzUq -h192.168.100.100 -P3308 db1 > db1.sql `  
## mysqldump工具常用的几个用法
1. 只备份表结构，不备份数据  
` mysqldump -ubackup -p34KpmyzUq -h192.168.100.100 -P3308 -d db1 > db1.sql `
2. 只备份数据，不备份表结构  
` mysqldump -ubackup -p34KpmyzUq -h192.168.100.100 -P3308 -t db1 > db1.sql `
3. 只备份指定表  
` mysqldump -ubackup -p34KpmyzUq -h192.168.100.100 -P3308 db1 tb1 > db1_tb1.sql `
4. 导出全部数据库  
` mysqldump -ubackup -p34KpmyzUq -h192.168.100.100 -P3308 -A > all_db.sql `
5. 到处指定多个库  
` mysqldump -ubackup -p34KpmyzUq -h192.168.100.100 -P3308 -B db1 db2 > db12.sql `
6. --master-data  
如果MySQL数据量很大，比如有几十GB,使用mysqldump备份工具会特别慢，推荐使用percona-xtrabackup备份工具。该工具官方下载地址为 
https://www.percona.com/software/mysql-database/percona-xtrabackup