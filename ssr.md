

## ssr搭建

```bash
Shadowsocksr
# port
65530
# password
1234
# ssr
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssrmu.sh && chmod +x ssrmu.sh && bash ssrmu.sh



10
# 加密算法 不推荐
aes-256-cfb
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
ss://YWVzLTI1Ni1nY206SmRvZGc5WTNjdUBjMzNzMS5qYW1qYW1zLm5ldDoxODE5MQ#JMS-243699@c33s1.jamjams.net:18191
ss://YWVzLTI1Ni1nY206SmRvZGc5WTNjdUBjMzNzMi5qYW1qYW1zLm5ldDoxODE5MQ#JMS-243699@c33s2.jamjams.net:18191

# 第三方
https://www.ivpnx.net/auth/register
https://www.hijk.pw/just-my-socks-buy-and-use-tutorial/
# 推荐blog
https://www.quchao.net/ShadowsocksR.html

之前的过期不能续费了，这是新的ssr链接，共2个可以切换用
ss://YWVzLTI1Ni1nY206M3VhQW1xRnBCdUBjMzVzMS5qYW1qYW1zLm5ldDoxNTM3Mg#JMS-218711@c35s1.jamjams.net:15372


ss://YWVzLTI1Ni1nY206M3VhQW1xRnBCdUBjMzVzMi5qYW1qYW1zLm5ldDoxNTM3Mg#JMS-218711@c35s2.jamjams.net:15372
```

| ssr                    | res                                   |
| ---------------------- | ------------------------------------- |
| Supported Protocols    | TCP + UDP                             |
| ShadowSocks Encryption | Depends on server, see server details |
| ShadowSocks Port       | 60897                                 |
| ShadowSocks Password   | qhMcTo2nx5                            |
| ShadowSocks Server IP  |                                       |

### [小飞机的官方 github 地址](https://github.com/shadowsocks/shadowsocks-windows)

> https://github.com/shadowsocks/shadowsocks-windows

```bash
1.下载小飞机
2.启动小飞机
3.复制 ssr 分享地址
3.右键小飞机-》服务器-》从剪切板导入URL

# mac
https://github.com/shadowsocks/ShadowsocksX-NG/releases/tag/v1.9.4
# android
https://github.com/shadowsocks/shadowsocks-android/releases
```



## ssr centos7 客户端

> https://www.teakki.com/p/5a5745f26689a6f62c276776

```nginx
server {
    listen 80;
    server_name 47.114.117.170;
    
    location / {
       proxy_pass http://www.talenter.club;
    }
}
```



```json
{
    "server":"c33s1.jamjams.net",
    "server_port":18191,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"Jdodg9Y3cu",
    "timeout":300,
    "method":"aes-256-gcm",
    "fast_open": false,
    "workers": 1
}
```

```bash
[Unit]
Description=Shadowsocks

[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks/shadowsocks.json

[Install]
WantedBy=multi-user.target
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

