## Eloquent ORM

1. 创建数据表：migration
2. 填充数据表：seeder
3. 模型配置：定义模型关系
4. 基本使用：增删查改
5. 可能遇到的问题

### 创建数据表

```php
// 生成迁移文件
php artisan make:migration create_identity_cards_table
// 运行迁移文件
php artisan migrate
// 回滚迁移操作
php artisan migrate:rollback
// 字段文档 https://learnku.com/docs/laravel/6.x/migrations/5173#columns
    
```

### 填充数据表

```php
// 生成填充数据工厂文件
php artisan make:factory IdentityCardFactory --model=IdentityCard
// php faker 使用手册地址 https://github.com/fzaninotto/Faker
// faker name 改中文 config/app.php -> faker_local => en_US 改为 zh_CN
php artisan tinker
factory('App\User')->create();
exit;
php artisan make:model IdentityCard
php artisan tinker
factory('App\IdentityCard')->create(['user_id' => factory('App\User')->create()->id])
exit
    
```

## Event

```php
//注册事件 EventServiceProvider.php
protected $listen = [
        Registered::class => [
            SendEmailVerificationNotification::class,
        ],
        'App\Events\RegisterOk' => [
            'App\Listeners\SendMessage'
        ]
    ]; 
// 在 boot 方法里，以闭包方式注册
// event('event.name', $user);
Event::listen('event.name', function ($user) {

});
// 通配符
Event::listen('event.*', function ($eventName, array $data) {
    //
});

// 生成事件文件
php artisan event:generate
```

## broadcasting

```php
// 配置驱动 .env 中 BROADCAST_DRIVER=redis
npm install --save socket.io-client |  echo 'websocket 客户端'
npm install --save laravel-echo     |  echo 'websocket 客户端封装'
npm install -g laravel-echo-server  |  echo 'websocket 服务端'
npm install                         |  echo '安装所有其他依赖'
npm run watch                        |  echo '监控文件变化编译前端资源'
laravel-echo-server init             |  echo '初始化 websocket 服务端'
laravel-echo-server start            |  echo '启动 websocket 服务端'
```

