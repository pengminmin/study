## git 清理 Untracked files

```bash
git clean -f -d
```

## 设置代理

```bash
git config --list
git config --global http.proxy http://127.0.0.1:1080
git config --list
git config --global --unset http.proxy
git config --list
```