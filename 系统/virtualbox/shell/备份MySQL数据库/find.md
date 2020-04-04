## find命令常见用法
1. 找到 logs 目录下一周以前的老文件  
` find logs/ -type f -mtime +7 `
2. 找到 /etc/ 目录下所有文件名以 .cnf 结尾的文件  
` find /etc/ -type f -name "*.cnf" `
3. 找到当前目录下所有权限为 777 的目录  
` find . -type d -perm 777 `
4. 找到 /tmp/ 下大小超过 1MB 的文件  
` find /tmp/ -size +1M `
5. 找到当前目录下 10 天以前的文件并删除  
` find . -type f -mtime +10 -exec rm -f {} \;  `  
` find . -type f -mtime +10 |xargs rm `  
找到 1 天前的备份文件  
` find /data/backup/ -name "*.sql" -mtime +1 `
