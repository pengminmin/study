## [APIDOC](https://apidocjs.com/)

### 基本使用

1. 安装

   > ```
   > npm install apidoc -g
   > ```

2. 生成api文档命令

   > apidoc -i myapp/ -o apidoc/ -t mytemplate/

   

3. 帮助命令

   > apidoc -h

4. 配置 apidoc.json

   apidoc.json

   ```json
   {
     "name": "example",
     "version": "0.1.0",
     "description": "apiDoc basic example",
     "title": "Custom apiDoc browser title",
     "url" : "https://api.github.com/v1"
   }
   ```

   如果放到package.json

   ```json
   {
     "name": "example",
     "version": "0.1.0",
     "description": "apiDoc basic example",
     "apidoc": {
       "title": "Custom apiDoc browser title",
       "url" : "https://api.github.com/v1"
     }
   }
   ```

   