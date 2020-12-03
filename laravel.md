```bash
# 使用composer创建一个laravel项目,下载不带git,使用本地缓存下载
composer create-project --prefer-dist laravel/laravel blog
# 下载源码带git
composer create-project --prefer-source laravel/laravel blog7-source
# 安装指定版本
composer create-project --prefer-dist laravel/laravel blog6 "6.*"
# 不加上面参数，查看默认是使用 --prefer-dist 还是 --preper-source
# 默认使用 --prefer-dist
composer create-project laravel/laravel blog-default
```

## migrate 数据迁移

```bash
# 数据迁移
php artisan migrate
# 异常: SQLSTATE[42000]: Syntax error or access violation: 1071 Specified key was too long; max key length is 1000 bytes
# 在 app/Providers/下 AppServiceProvider.php 
# use Illuminate\Support\Facades\Schema;
# boot方法中 Schema::defaultStringLength(191);


```

### [数据迁移字段类型及字段长度](https://www.cnblogs.com/love-snow/articles/8891071.html)



## homestead

### homestead使用vagrant在win10上运行慢

原因是vagrant在win10上共享文件的IO问题，需要安装vagrant插件

```bash
vagrant plugin install vagrant-winnfsd
```

```bash
$ vagrant plugin install vagrant-winnfsd --plugin-clean-sources --plugin-source https://rubygems.org
Installing the 'vagrant-winnfsd' plugin. This can take a few minutes...
Installed the plugin 'vagrant-winnfsd (1.4.0)'!

```

安装成功后修改配置文件

1. homestead/scripts/homestead.rb

   ```erb
   # Register All Of The Configured Shared Folders
   if settings.include? 'folders'
       settings["folders"].each do |folder|
           if File.exists? File.expand_path(folder["map"])
               mount_opts = []
   
               if (folder["type"] == "nfs")
                   mount_opts = folder["mount_options"] ? folder["mount_options"] : ['actimeo=1', 'nolock']
               elsif (folder["type"] == "smb")
                   mount_opts = folder["mount_options"] ? folder["mount_options"] : ['vers=3.02', 'mfsymlinks']
               end
   
               # For b/w compatibility keep separate 'mount_opts', but merge with options
               options = (folder["options"] || {}).merge({ mount_options: mount_opts })
   
               # Double-splat (**) operator only works with symbol keys, so convert
               options.keys.each{|k| options[k.to_sym] = options.delete(k) }
   
               config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil, **options
   
               # Bindfs support to fix shared folder (NFS) permission issue on Mac
               if Vagrant.has_plugin?("vagrant-bindfs")
                   config.bindfs.bind_folder folder["to"], folder["to"]
               end
           else
               config.vm.provision "shell" do |s|
                   s.inline = ">&2 echo \"Unable to mount one of your folders. Please check your folders in Homestead.yaml\""
               end
           end
       end
   end
   ```

   替换为下面

   ```erb
   if settings.include? 'folders'
     settings["folders"].sort! { |a,b| a["map"].length <=> b["map"].length }
   
     settings["folders"].each do |folder|
       config.vm.synced_folder folder["map"], folder["to"], 
       id: folder["map"],
       :nfs => true,
       :mount_options => ['nolock,vers=3,udp,noatime']
     end
   end
   ```

2. Homestead.yaml

   ```bash
   folders:
       - map: ~/Code
         to: /home/vagrant/Code
         type: nfs
   ```

重启vagrant

```bash
vagrant provision && vagrant reload
```

- `vagrant provision` 是命令 Vagrant 重新加载 `Homestead.yaml` 配置

## 路由

### resource

```php
/**
 * HTTP 请求 | URL                 | 动作                           | 作用
 * POST     | 	/statuses         | StatusesController@store       | 处理创建微博的请求
 * DELETE   | /statuses/{status} | StatusesController@destroy      | 处理删除微博的请求
 *
 */
Route::resource('statuses', 'StatusesController', ['only' => ['store', 'destroy']]);
```

```php
// 生成 controller
php artisan make:controller PhotoController --resource
// route
Route::resource('photos', 'PhotoController');
//相当于
//展示照片列表
Route::get('photos', 'PhotoController@index')->name('photos.index');
//展示一张照片
Route::get('photos/{photo}', 'PhotoController@show')->name('photos.show');
//展示用来创建照片的表单
Route::get('photos/create', 'PhotoController@create')->name('photos.create');
//展示编辑照片表单
Route::get('photos/{photo}/edit', 'PhotoController@edit')->name('photos.edit');
//添加照片
Route::post('photos', 'PhotoController@store')->name('photos.store');
//更新一张照片
Route::put('photos/{photo}', 'PhotoController@update')->name('photos.update');
Route::patch('photos/{photo}', 'PhotoController@update')->name('photos.update');
//移除一张照片
Route::delete('photos/{photo}', 'PhotoController@destroy')->name('photos.destroy');
```

| 方法      | uri                 | 路由名称       | 控制器@方法             | 用途                   |
| --------- | ------------------- | -------------- | ----------------------- | ---------------------- |
| GET       | photos              | photos.index   | PhotoController@index   | 展示照片列表           |
| POST      | photos              | photos.store   | PhotoController@store   | 添加照片               |
| GET       | photos/create       | photos.create  | PhotoController@create  | 展示用来创建照片的表单 |
| GET       | photos/{photo}      | photos.show    | PhotoController@show    | 展示一张照片           |
| PUT/PATCH | photos/{photo}      | photos.update  | PhotoController@update  | 更新一张照片           |
| DELETE    | photos/{photo}      | photos.destroy | PhotoController@destroy | 移除一张照片           |
| GET       | photos/{photo}/edit | photos.edit    | PhotoController@edit    | 展示编辑照片表单       |

```php

* GET /photos
index()  //  展示照片列表

* POST /photos
store()  // 添加照片

* GET /photos/create
create()  // 展示用来创建照片的表单

* GET /photos/{id}
show($id)  // 展示一张照片

* PUT /photos/{id}
update($id)  // 更新一张照片

* DELETE /photos/{id} 
destroy($id)  // 移除一张照片

* GET /photos/{id}/edit
edit($id)  // 展示编辑照片表单
    
```

## JWT



## 开启日志

```php
 //开启执行日志
//        DB::connection()->enableQueryLog();
 //记录日志
//        info('query log', [DB::getQueryLog()]);
```

