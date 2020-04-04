## 网络
### 网络地址转换(NAT)
NAT模式是VirtualBox的默认网络模式，可以从虚拟机访问外网，但不能从外网访问虚拟机。如想从外网访问虚拟机需要做端口转发。
### NAT 网络
NAT网络模式是前一种NAT模式的变体，同样的，虚拟机可以访问外网，但外网不能访问虚拟机。不同的是，多个虚拟机之间可以组网。
### 桥接网络
在这种模式下，虚拟机将作为一个独立主机直接加入宿主机所在的网络。
### 内部网络
虚拟机之间组网。相同内部网络的虚拟机之间可以互通，不能与宿主机或外网通信。
### 仅宿主机(Host-Only)网络
主机与多个虚拟机组网，但虚拟机不能连外网。

网络模式 | 虚拟机->宿主 | 虚拟机<-宿主 | 虚拟机1<->虚拟机2 | 虚拟机->外网 | 虚拟机<-外网
--- | --- | --- | --- | --- |---
仅宿主机(Host-Only) | + | + | + | - | - 
内部网络 | - | - | + | - | - 
桥接网络 | + | + | + | + | + 
网络地址转换(NAT) | + | 端口转发 | - | + | + 
NAT网络 | + | 端口转发 | + | + | 端口转发
[参考资料](https://www.qikegu.com/uncategorized/1374)  
[端口转发](https://www.qikegu.com/uncategorized/1195)

## IP静态化设置

```shell
vim /etc/sysconfig/network-scripts/ifcfg-enp0s3
ONBOOT=yes 这里指系统启动时就启动网络服务
#BOOTPROTO=dhcp 将动态分配ip地址注释
BOOTPROTO=static 使用静态ip地址
IPADDR=192.168.0.117 ip地址
NETMASK=255.255.255.0 子网掩码
GATEWAY=192.168.0.1 网关

#重启网卡
service network restart
#查看网络信息
ifconfig
```

