## gzip命令常见用法
gzip 支持压缩文件，但不支持压缩目录，压缩一个文件的命令是:
> gzip file  

此时，该文件被压缩为file.gz，也就是说该文件被压缩后也会被删除掉。解压 .gz 的文件，使用 gzip 命令的 -d 选项，如:
> gzip -d file.gz

本例把一天前的备份文件压缩的命令为:
> find /data/backup/ -name "*.sql" -mtime +1 |xargs gzip