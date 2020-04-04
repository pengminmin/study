1. 大文件拆成小文件

   ```shell
   # 将1.txt文件每10行拆封到小文件中，文件名test后面添加一些字母
   split -10 1.txt test
   ```

2. tmux

   ```shell
   # 文档 https://www.cnblogs.com/foohack/p/10030940.html
   # 安装
   yum install -y tmux
   # 默认创建一个会话
   tmux
   # 新建会话，已 ccc 命名
   tmux new -s ccc
   # 在后台新建会话，加上参数 -d
   tmux new -s aaa -d
   # 查看创建的所有会话
   tmux ls
   # 登录一个已知会话，aaa 是会话名称，第一个 a 也可以写成 attach
   tmux a -t aaa
   # 退出会话，但是不关闭, ctrl - b + d
   # 退出会话并关闭会话，ctrl + d
   # 关闭会话，bbb 是会话名称
   tmux kill-session -t bbb
   # 重命名会话，aaa 与 bbb 是会话名称
   tmux rename -t aaa bbb
   # 面板操作
   # ctrl + b 进入操作命令
   # % 左右分屏
   # “ 上下分屏
   # 方向键切换选择的分屏
   # x 关闭当前面板
   ```

3. centos7 安装官方 epel 源

   ```shell
   rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
   ```

4. 阿里 epel 源

   ```shell
   wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
   ```

5. htop

   ```shell
   # 先安装 epel 源
   # 安装 htop
   yum install -y htop
   ```

6. ln

   ```shell
   # 创建软连接，其中 aaa 是已存在的文件或者文件夹，bbb 是要创建的软链接
   ln -s aaa bbb
   ```

7. centos7查看正在运行的端口

   ```shell
   netstat -tunpl
   ```

   