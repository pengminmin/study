## 事务的隔离级别
ACID(Atomicity,Consistency,Isolation,Durability)原子性、一致性、隔离性、持久性  
脏读  因为另一个事务回滚，导致该事务读取到无效的数据。  
不可重复读  同一个事务中同样的查询，可能得到不同的结果。  
幻读  一个查询后面查询到前面不存在的数据列。

事务隔离级别 | 释义 | 脏读 | 不可重复读 | 幻读
--- | --- | --- | --- | ---
读未提交 | 一个事务还没提交时，它做的变更就能被别的事务看到。| 存在 | 存在 | 存在
读提交 | 一个事务提交之后，它做的变更才会被其它事务看到。| 不存在 | 存在 | 存在 
可重复读 | 一个事务执行过程中看到的数据，总是跟这个事务在启动时看到的数据是一致的。当然在可重复读隔离级别下，未提交变更对其它事务也是不可见的。| 不存在 | 不存在 | 存在
串行化 | 对于同一行记录，写会加写锁，读会加读锁。当出现读写锁冲突的时候，后访问的事务必须等前一个事务执行完成，才能继续执行。| 不存在 | 不存在 | 不存在

## 幻读

### 幻读(phantom read)

- **前提条件**：InnoDB引擎，可重复读隔离级别，使用**当前读**时。

- **表现**：一个事务(同一个read view)在前后两次查询同一范围的时候，后一次查询看到了前一次查询没有看到的行。**两点需要说明**：
   　
   1. 在可重复读隔离级别下，普通查询是快照读，是不会看到别的事务插入的数据的，幻读只在**当前读**下才会出现。
   
   2. 幻读专指**新插入的行**，读到原本存在行的更新结果不算。因为**当前读**的作用就是能读到所有已经提交记录的最新值。
   
      > 如果事务A 按一定条件搜索， 期间事务B 删除了符合条件的某一条数据，导致事务A 再次读取时数据少了一条。这种情况归为 不可重复读

### 幻读的影响

- 会造成一个事务中先产生的锁，无法锁住后加入的满足条件的行。
- 产生数据一致性问题，在一个事务中，先对符合条件的目标行做变更，而在事务提交前有新的符合目标条件的行加入。这样通过binlog恢复的数据是会将所有符合条件的目标行都进行变更的。

### 幻读产生的原因

- 行锁只能锁住行，即使把所有的行记录都上锁，也阻止不了新插入的记录。

### 如何解决幻读

- 将两行记录间的空隙加上锁，阻止新记录的插入；这个锁称为**间隙锁**。
- 间隙锁与间隙锁之间没有冲突关系。跟间隙锁存在冲突关系的，是**往这个间隙中插入一个记录**这个操作。



作者：慧鑫coming
链接：https://www.jianshu.com/p/c53c8ab650b5
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



## 数据库默认事务隔离级别

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

## 数据库备份

```bash
mysqldump -uroot -p database_name > database_name.sql

mysqldump --host=h1 -uroot -p database_name > database_name.sql
# 只备份结构
mysqldump -uroot -p --no-data database_name > database_name.sql

```

## 添加新用户

### 添加新用户

```bash
# 允许本地 IP 访问 localhsot 127.0.0.1
create user 'test'@'localhost' identified by '123456';
# 允许外网 IP 访问
create user 'test'@'%' identified by '123456';
# 刷新权限
flush privileges;
```

### 为用户创建数据库

```bash
create database test DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
```

### 为新用户分配权限

```bash
# 授予用户通过外网 IP 对于该数据库的全部权限
grant all privileges on `testdb`.* to 'test'@'%' identified by '123456';
# 授予用户在本地服务器对该数据库的全部权限
grant all privileges on `testdb`.* to 'test'@'localhost' identified by '123456';
# 刷新权限
flush privileges;
# mysql8
grant all privileges on `testdb`.* to 'test'@'localhost';
# 刷新权限
flush privileges;
```

## 清空表

```sql
truncate table author;
```

