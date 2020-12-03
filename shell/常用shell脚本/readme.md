> https://www.cnblogs.com/cangqinglang/p/11218645.html

## 等腰三角形

```sh
#!/bin/bash
# 等腰三角形
read -p "Please input the length: " n
for i in `seq 1 $n`
do
for ((j=$n;j>i;j--))
do
echo -n " "
done

for m in `seq 1 $i`
do
echo -n "* "
done
echo 
done



# 菱形
read -p "Please input the length: " n

for i in `seq 1 $n`
do
for ((j=$n;j>i;j--))
do
echo -n " "
done
for m in `seq 1 $i`
do
echo -n "* "
done
echo 
done

for i in `seq 1 $n`
do
for((j=1;j<=$i;j++))
do
echo -n " "
done
for((k=$i;k<=$len-1;k++))
do
echo -n "* "
done
echo 
done
```

## 倒直角三角形

```shell
#! /bin/bash
# 倒直角三角形
read -p "Please input the length: " len
for i in `seq 1 $len`
do
for j in `seq $i $len`
do
echo -n "* "
done
echo
done
```



```sh
#!/bin/bash
# 截取字符串
var="http://www.aaa.com/root/123.htm"
#1.
echo $var |awk -F '//' '{print $2}'
#2.
echo $var |awk -F '/' '{print $5}'
#3.
echo $var |grep -o 'http.*root'
#4.
echo $var |awk -F '/' '{print $1}'
#5.
echo $var |grep -o 'http://'
#6.
echo $var |grep -o 'www.*htm'
#7.
echo $var |grep -o '123'
#8.
echo $var |grep -o '123.htm'
```

```shell
#!/bin/bash
# tomcat 启动脚本
# chkconfig:2345 64 36
# description: Tomcat start/stop/restart script.

### BEGIN INIT INFO
# Provides: tomcat
# Required-Start: 
# Should-Start: 
# Required-Stop: 
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: start and stop Tomcat
# Description: Tomcat Service start&restart&stop script
### END INIT INFO

##Written by zero.##
JAVA_HOME=/usr/local/jdk1.8/
JAVA_BIN=/usr/local/jdk1.8/bin
JRE_HOME=/usr/local/jdk1.8/jre
PATH=$PATH:/usr/local/jdk1.8/bin:/usr/local/jdk1.8/jre/bin
CLASSPATH=/usr/local/jdk1.8/jre/lib:/usr/local/jdk1.8/lib:/usr/local/jdk1.8/jre/lib/charsets.jar
TOMCAT_BIN=/usr/local/tomcat/bin
RETVAL=0
prog="Tomcat"

start()
{
echo "Starting $prog......"
/bin/bash $TOMCAT_BIN/startup.sh
RETVAL=$?
return $RETVAL
}
stop()
{
echo "Stopping $prog......"
/bin/bash $TOMCAT_BIN/shutdown.sh
RETVAL=$?
return $RETVAL
}
restart(){
echo "Restarting $prog......"
stop
start
}

case "$1" in
start)
start
;;
stop)
stop
;;
restart)
restart
;;
*)
echo $"Usage: $0 {start|stop|restart}"
RETVAL=1
esac
exit $RETVAL
```

```shell
#!/bin/bash
# 自定义 rm 命令
fileName=$1
now=`date +%Y%m%d%H%M`
read -p "Are you sure delete the file or directory $1? yes|no: " input

if [ $input == "yes" ] || [ $input == "y" ]
then
mkdir /data/.$now
rsync -aR $1/ /data/.$now/$1/
/bin/rm -rf $1
elif [ $input == "no" ] || [ $input == "n" ]
then
exit 0
else
echo "Only input yes or no"
exit
fi
```

```shell
#!/bin/bash
# 复杂实现
fileName=$1
now=`date +%Y%m%d%H%M`
f_size=`du -sk $1 |awk '{print $1}'`
disk_size=`LANG=en; df -k |grep -vi filesystem |awk '{print $4}' |sort -n |tail -n1`
big_filesystem=`LANG=en; df -k |grep -vi filesystem |sort -n -k4 |tail -n1 |awk '{print $NF}'`

if [ $f_size -lt $disk_size ]
then
read -p "Are you sure delete the file or directory: $1 ? yes|no: " input
if [ $input == "yes" ] || [ $input == "y" ]
then
mkdir -p $big_filesystem/.$now && rsync -aR $1 $big_filesystem/.$now/ && /bin/rm -rf $1
elif [ $input == "no" ] || [ $input == "n" ]
then
exit 0
else
echo "Only input 'yes' or 'no'."
fi
else
echo "The disk size is not enough to backup the file: $1."
read -p "Do you want to delete "$1"? yes|no: " input
if [ $input == "yes" ] || [ $input == "y" ]
then
echo "It will delete "$1" after 5 seconds whitout backup."
for i in `seq 1 5`; do echo -ne "."; sleep 1; done
echo
/bin/rm -rf $1
elif [ $input == "no" ] || [ $input == "n" ]
then
echo "It will not delete $1."
exit 0
else
echo "Only input 'yes' or 'no'."
fi
fi
```

```shell
#!/bin/bash
# 数字求和
while :
do
read -p "Please enter a positive integer: " n
if [ $n -lt 1 ]
then
echo "It can't be less than 1"
else
break
fi
done

num=1
for i in `seq 2 $n`
do
num=$[$num+$i]
done

echo $num
```

```shell
#!/bin/bash
# 拷贝目录
cd /root/
list=(`ls`)

for i in ${list[@]}
do
if [ -d $i ]
then
cp -r $i /tmp/
fi
done
```

```shell
#!/bin/bash
group=`cat /etc/group |grep -o users`
if [ $group == "users" ]
then
for i in `seq 0 100`
do
if [ $i -lt 10 ]
then
useradd -g users user_0$i
else
useradd -g users user_$i
fi
done
else
echo "users group not found!"
exit 1
fi
```



