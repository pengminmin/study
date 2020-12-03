## docker 命令

```bash
docker run -d --name showdoc --user=root --privileged=true -p 4999:80 -v /d/www/tmp/showdoc_data/html:/var/www/html/ star7th/showdoc

# 必须要加 --user=root，不然会出现文件权限的问题
docker run -d --name showdoc --user=root -p 4999:80 \
-v /d/www/tmp/html/:/var/www/html/ star7th/showdoc

```

