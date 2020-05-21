## 事务的隔离级别
ACID(Atomicity,Consistency,Isolation,Durability)原子性、一致性、隔离性、持久性  
脏读  因为另一个事务回滚，导致该事务读取到无效的数据。  
不可重复读  同一个事务中同样的查询，可能得到不同的结果。  
幻读  
事务隔离级别 | 释义 | 脏读 | 不可重复读 | 幻读
--- | --- | --- | --- | ---
读未提交 | 一个事务还没提交时，它做的变更就能被别的事务看到。| 存在 | 存在 | 存在
读提交 | 一个事务提交之后，它做的变更才会被其它事务看到。| 不存在 | 存在 | 存在 
可重复读 | 一个事务执行过程中看到的数据，总是跟这个事务在启动时看到的数据是一致的。当然在可重复读隔离级别下，未提交变更对其它事务也是不可见的。| 不存在 | 不存在 | 存在
串行化 | 对于同一行记录，写会加写锁，读会加读锁。当出现读写锁冲突的时候，后访问的事务必须等前一个事务执行完成，才能继续执行。| 不存在 | 不存在 | 不存在

### 数据库默认事务隔离级别
Oracle数据库的默认隔离界别读提交  
MySQL的默认隔离级别可重复读  
MySQL查看隔离界别命令
> show variables like 'transaction_isolation';

MySQL设置隔离级别命令
> set tx_isolation='read-committed';

## 查看默认密码

```bash
grep 'temporary password' /var/log/mysqld.log
```

## 重置密码

```bash
# mysql 5.7
set password for 'root'@'localhost'=password('root');
# 报错
# ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
# 修改 validate_password_policy
set global validate_password_policy=0;
# 修改 validate_password_length
set global validate_password_length=1;
# 刷新权限
flush privileges;

# 正确流程
set global validate_password_policy=0;
set global validate_password_length=1;
set password for 'root'@'localhost'=password('root');
flush privileges;
exit;
```

