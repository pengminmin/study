```shell
# centos新增mysql用户并导入数据库
https://www.linuxidc.com/Linux/2018-09/154250.htm
# 使用 jenkins-本地
java -jar jenkins.war --httpPort=8080
# 管理员密码
0418fb1de33147c19d20f3b882baea8a
# jenkins-test 
# ip
47.241.78.226
# password
co2ykH9Vsi0J8HXe
# jenkins-initialAdminPassword
04c6ba3f6b1340dd8a7ed2dfcf368436
# 杭州-jenkins
# ip
47.99.75.203
# docker 运行 jenkins
docker run \
  -u root \
  --rm \  
  -d \ 
  -p 8080:8080 \ 
  -p 50000:50000 \ 
  -v ~/jenkins-data:/var/jenkins_home \ 
  -v /var/run/docker.sock:/var/run/docker.sock \ 
  jenkinsci/blueocean 
 # initialAdminPassword
 faec046f7ecc46cfba5bd4ca730a0901
```

