1. >  Fatal error: Allowed memory size of 1610612736 bytes exhausted (tried to allocate 67108864 bytes) in phar://D:/ProgramFiles/phpstudy_pro/Extensions/composer1.8.5/c
   > omposer.phar/src/Composer/DependencyResolver/Solver.php on line 223

   Check https://getcomposer.org/doc/articles/troubleshooting.md#memory-limit-errors for more info on how to handle out of memory errors.

   尝试增加`php.ini`文件中的限制（例如，`/etc/php5/cli/php.ini`对于类似Debian的系统）：

   ```shell
   ; Use -1 for unlimited or define an explicit value like 2G
   memory_limit = -1
   ```

   