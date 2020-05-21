## [APIDOC](https://apidocjs.com/)

### 基本使用

1. 安装

   > ```
   > npm install apidoc -g
   > ```

2. 生成api文档命令

   > apidoc -i myapp/ -o apidoc/ -t mytemplate/
   >
   > apidoc -i App\Http\Controllers\API\V1 -o public/apidoc

   

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

   ```json
   "apidoc": {
           "name": "vidy的API文档",
           "version": "1.0.0",
           "description": "API文档",
           "title": "vidy的API文档",
           "url" : "http://vidy.com/api",
           "sampleUrl": "http://vidy.com/api",
           "order": [
               "登录"
           ]
       }
   ```

   ```json
   eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC93d3cudmlkeS10ZXN0LmNvbVwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTU4NTg5NTI3OSwiZXhwIjoxNTg3MTA0ODc5LCJuYmYiOjE1ODU4OTUyNzksImp0aSI6InNXUU9uV2I3ZWg3eHlqRE8iLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJ1aWQiOjF9.wylEJag4-jA0IEVcMF9BJKn9HfKn86Dhp2bzfmExMWM
   
   
   {
       "code": 200,
       "message": "成功",
       "data": {
           "user": {
               "read": 0,
               "username": "fage",
               "logo": "https://www.vidi-test.com/images/user_logo/5f3470d0-1ad9-4c4d-819e-cc840e18ff5e.png"
           },
           "notice": [
               {
                   "id": 9,
                   "title": "关于VIDY好看充提USDT的注意事项",
                   "content": "尊敬的VIDY全球会员:\n         VIDY好看钱包地址中的USDT暂时只支持omni链，充提USDT时链类型请选择omni，如选择erc20链会导致充值不到账以及资产丢失的情况；同时，充值购买阅读矿机可以选择ETH和USDT，请会员充值时仔细检查充值币种和地址，以防止地址错误造成不必要的资产丢失。                                                         VIDY",
                   "time": 1569138745,
                   "lang_id": 1,
                   "status": 1
               }
           ],
           "adverts": [
               {
                   "id": 5163,
                   "title": "摩纳哥游艇展世界首映式，超级游艇首映式",
                   "num": 227,
                   "time": 1569292180,
                   "state": 1,
                   "origin_url": "https://www.luxuo.com/motoring/yachting/monaco-yacht-show-world-premieres.html",
                   "display_url": "http://www.vidy-test.com/advert/5d897f8e0d3ac.jpg",
                   "origin_type": 1,
                   "username": "default",
                   "avatar_picture": "http://www.vidy-test.com/avatar/5d897f8e0d3ac.jpg",
                   "is_read": true
               }
           ]
       },
       "time": 1585895787
   }
   
   前端地址：http://47.97.123.82:9797/
   后端地址：http://47.97.123.82:9798/
   
   SSL证书地址
   
   api.jengacorp.com
   /home/ubuntu/api.jengacorp.com.crt
   /home/ubuntu/api_jengacorp_com.pem
   /home/ubuntu/api.jengacorp.com.ca-bundle
   
   jengacorp.com
   /home/ubuntu/jengacorp.com.crt
   /home/ubuntu/jengacorp_com.pem
   /home/ubuntu/jengacorp.com.ca-bundle
   
   ```
   
   

