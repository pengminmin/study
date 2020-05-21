

## ssr搭建

```bash
Shadowsocksr
# port
65530
# password
support@!k23e
# ssr
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssrmu.sh && chmod +x ssrmu.sh && bash ssrmu.sh

65530
1234
10

```

## [[Just My Socks](https://justmysocks.net/members/index.php)]

```bash
# 官网
https://justmysocks.net/
# email
540965717@qq.com
# pwd
sg@TdHhUuiH8nEd
# 优惠码
JMS9272283

Supported Protocols TCP + UDP [help]
ShadowSocks Encryption Depends on server, see server details
ShadowSocks Port   60897
ShadowSocks Password   qhMcTo2nx5
ShadowSocks Server IP  
c25s1.jamjams.net | aes-256-gcm
c25s2.jamjams.net | aes-256-gcm
c25s3.jamjams.net | obfs=tls, aes-256-gcm, no udp
c25s4.jamjams.net | obfs=tls, aes-256-gcm, no udp
c25s5.jamjams.net | aes-256-cfb


c25s1.jamjams.net | aes-256-gcm -> 144.34.191.77
c25s2.jamjams.net | aes-256-gcm -> 107.182.183.205
c25s3.jamjams.net | obfs=tls, aes-256-gcm, no udp -> 199.193.124.233
c25s4.jamjams.net | obfs=tls, aes-256-gcm, no udp -> 162.211.220.49
c25s5.jamjams.net | aes-256-cfb -> 67.209.177.243

# 本地 
http://127.0.0.1:1080/pac?hash=DUHICSKRgX188OEbeRzabg2&secret=E7imyzOXjT_HMsJBNSgPd-9pYKQRphyQbxKIjjJD52Y1

ss://YWVzLTI1Ni1nY206cWhNY1RvMm54NUBjMjVzMS5qYW1qYW1zLm5ldDo2MDg5Nw==#JMS-191604%40c25s1.jamjams.net%3a60897

ss://YWVzLTI1Ni1nY206cWhNY1RvMm54NUBjMjVzMi5qYW1qYW1zLm5ldDo2MDg5Nw==#JMS-191604%40c25s2.jamjams.net%3a60897

# 第三方
https://www.ivpnx.net/auth/register
https://www.hijk.pw/just-my-socks-buy-and-use-tutorial/
# 推荐blog
https://www.quchao.net/ShadowsocksR.html
```

| ssr                    | res                                   |
| ---------------------- | ------------------------------------- |
| Supported Protocols    | TCP + UDP                             |
| ShadowSocks Encryption | Depends on server, see server details |
| ShadowSocks Port       | 60897                                 |
| ShadowSocks Password   | qhMcTo2nx5                            |
| ShadowSocks Server IP  |                                       |

### [小飞机的官方 github 地址](https://github.com/shadowsocks/shadowsocks-windows)

```bash
1.下载小飞机
2.启动小飞机
3.复制 ssr 分享地址
3.右键小飞机-》服务器-》从剪切板导入URL
```





## git代理设置

```bash
# 查看当前代理设置
git config --global http.proxy
git config --global https.proxy

# 设置当前代理为 http://127.0.0.1:1080 或 socket5://127.0.0.1:1080
git config --global http.proxy 'http://127.0.0.1:1080'
git config --global https.proxy 'https://127.0.0.1:1080'

git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'

# 删除 proxy
git config --global --unset http.proxy
git config --global --unset https.proxy
```

