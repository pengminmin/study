## 安装软件

```bash
# 查看ubuntu版本
cat /proc/version
Linux version 4.15.0-91-generic (buildd@lgw01-amd64-013) (gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)) #92-Ubuntu SMP Fri Feb 28 11:09:48 UTC 2020
# 安装nginx
apt install -y nginx
# 查看nginx版本
nginx -v
# 
```

### 问题

- 安装软件如果提示没有package

  ```
  # 更新包
  apt update -y
  ```

  

