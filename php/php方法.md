## 字符串

### `strtr()`

> **strtr**    ( string `$str`   , string `$from`   , string `$to`   ) : string

> **strtr**    ( string `$str`   , array `$replace_pairs`   ) : string



替换字符串

```php
echo strtr('baab', 'ab', '01');//1001
$trans = array('ab' => '01');
echo strtr('baab', $trans);//ba01
```

###     `str_repeat()`

重复一个字符串

```php
echo str_repeat('-=', 10);//-=-=-=-=-=-=-=-=-=-=
```

## 方法-参数

### `func_get_args(void):array`

```php

```

返回参数

### `func_num_args(void):int`

返回参数数量

### `func_get_arg(int $arg_num):mixed`

从用户自定义函数的参数列表中获取某个指定的参数。

`$arg_num` 从 0 开始计数

```php

function arr(){
    return func_get_args();
}
$arg_list = arr(3,5,7,9,15);

var_dump($arg_list);
//array (size=5)
//  0 => int 3
//  1 => int 5
//  2 => int 7
//  3 => int 9
//  4 => int 15


function foo()
{
    $numargs = func_num_args();
//    func_get_arg($numargs - 1);//5
//    if($numargs > 2){
//        return func_get_arg($numargs - 1);
//    }
    return func_get_arg(0);//1
}

$arg = foo(1, 2, 3, 4, 5);
var_dump($arg);//5

```



