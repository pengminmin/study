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

## migrate

```bash
# 数据迁移
php artisan migrate
# 异常: SQLSTATE[42000]: Syntax error or access violation: 1071 Specified key was too long; max key length is 1000 bytes
# 在 app/Providers/下 AppServiceProvider.php 
# use Illuminate\Support\Facades\Schema;
# boot方法中 Schema::defaultStringLength(191);


```

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

