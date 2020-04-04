## rsync命令常见用法
rsync 同步一个目录，最常用的命令为:
> rsync -av /source_dir/ user@p::module_name/dest_dir/

rsync几个常用选项:

-a 归档模式，表示以递归方式传输文件，并保持所有属性，等同于 -rlptgoD , -a 选项后面可以跟一个 --no-OPTION 这个表示关闭 -rlptgoD 中的某一个例如 -a --no-l 等同于 -rptgoD

-r 对子目录以递归模式处理，主要针对目录来说的，如果单独传一个文件不需要加 -r , 但传输的是目录必须加 -r 选项

-v 打印一些信息出来，比如速率，文件数量等

-l 保留软链接

-L 向对待常规文件一样处理软连接，如果是 SRC 中有软连接文件，则加上该选项后将会把软链接指向的目标文件拷贝到 DST

-p 保持文件权限

-o 保持文件属主信息

-g 保持文件属组信息

-D 保持设备文件信息

-t 保持文件时间信息

--delete 删除那些 DST 中 SRC 没有的文件

--exclude=PATTERN 指定排除不需要传输的文件，等号后面跟文件名，可以是万用字符模式(如 *.txt)

--progress 在同步的过程中可以看到同步的过程状态，比如统计要同步的文件数量、同步的文件传输速度等

-u 加上这个选项后将会把 DST 中比 SRC 还新的文件排除掉，不会覆盖

常用的 -a -v --delete --exclude

1. 准备工作
```
mkdir rsync
cd rsync
mkdir test1
cd test1
touch 1 2 3
ln -s /root/123.txt ./123.txt
ls -l
cd ..
```
2. 使用 -a 选项
```
rsync -a test1 test2
要记得加 / 
rsync -a test1/ test2/
使用 --no-OPTION
rsync -av --no-l test1/ test2/
这样会跳过非普通文件123.txtS
```
3. 使用 -L 选项 
```
rsync -avL test1/ test2/
可以把 test1/ 中的软链接的目标文件给拷贝到 test2/ 中
```
4. 使用 -u 选项
```
rsync -avu test1/ test2/
```
5. 使用 --delete 选项
```
rsync -av --delete test1/ test2/
```
6. 使用 --exclude 选项
```
rsync -av --exclude="*.txt" test1/ test2/ 
```