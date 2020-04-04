1. 配置文件怎么加载？

   ```shell
   # 怎么解析yml文件内容
   composer crate-project drupal/core-serialization
   # 或者
   composer require drupal/core-serialization
   # 中的Yaml类
   ```

   ```php
   $config = file_get_contents(__DIR__ . '/block.block.missing_schema.yml');
   $config = Yaml::parse($config);
   $connection->insert('config')
     ->fields(['data', 'name', 'collection'])
     ->values([
       'name' => 'block.block.missing_schema',
       'data' => serialize($config),
       'collection' => '',
     ])
     ->execute();
   
   ```

   

2. 新建路由

3. 新建控制器

4. 新建视图

5. 请求限制

6. 模块开发

