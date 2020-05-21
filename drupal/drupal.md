# [drupal](https://www.drupal.org/)

## 安装

### 问题

### drupal The translation server is offline.

从https://localize.drupal.org/download 下载语言文件上传到/sites/default/files/translations

从https://localize.drupal.org/translate/languages/zh-hans 下载语言文件上传到/sites/default/files/translations

### 清空缓存命令

> drush cache-rebuild

## 安装drupal命令

> composer global require drush/drush:dev-master --prefer-dist -vvv --profile
>
> composer global require drush/drush  --prefer-dist -vvv --profile
>
> composer global require drush/drush --ignore-platform-reqs -vvv

---prefer-dist 不安装版本控制

-vvv 显示安装过程信息

--profile 显示耗费的内存和时间

## 安装中文文件

将文件 drupal-8.8.3.zh-hans.po 放到 /site/default/files/translations/ 文件夹内

```none
composer require symfony/templating
```

## drush 命令

```shell
drush dl drupal-7.30 -v
```

drush dl rules

```shell
#清理缓存
drush cc 
#cache:rebuild
drush cr
```

## 随记

1. entity，实体是面向对象的实现，里面有数据，操作方法，配置，是子系统
2. 要建立数据库，需要给模块建立一个install文件，例如：dblog.install
3. 路由与常见的mvc格式不同，而是将路由表达与系统内部解耦，可以使用任意的字符串表达路由，路由的使用要生成 name.routing.yml (name为模块名)文件来定义





http://192.168.101.32:8989/api/v1/order_form/payment



```php
header('Access-Control-Allow-Origin: *');
```

authenticator

https://jengacorp.com/

https://checkout.stripe.com

```json
{
	"result": {
		"id": "cs_test_xKzQC0RDqaJu7myvnqVJAfEHzDdoIOUzfGWVnab3IOOqf7gjVlc3FwKL",
		"object": "checkout.session",
		"billing_address_collection": null,
		"cancel_url": "http:\/\/jengacorp.com\/order\/thankyou\/cancel",
		"client_reference_id": "100863",
		"customer": null,
		"customer_email": "540965717@qq.com",
		"display_items": [{
			"amount": 420510,
			"currency": "usd",
			"custom": {
				"description": null,
				"images": null,
				"name": "Jenga Order"
			},
			"quantity": 1,
			"type": "custom"
		}],
		"livemode": false,
		"locale": null,
		"metadata": {},
		"mode": "payment",
		"payment_intent": "pi_1GSJj0G9w5x7aWT7jkWDc24s",
		"payment_method_types": ["card"],
		"setup_intent": null,
		"shipping": null,
		"shipping_address_collection": null,
		"submit_type": "pay",
		"subscription": null,
		"success_url": "http:\/\/jengacorp.com\/order\/thankyou\/success"
	},
	"error": false,
	"stripeSessionId": "cs_test_xKzQC0RDqaJu7myvnqVJAfEHzDdoIOUzfGWVnab3IOOqf7gjVlc3FwKL",
	"request": {
		"submit_type": "pay",
		"client_reference_id": "100863",
		"customer_email": "540965717@qq.com",
		"payment_method_types": ["card"],
		"line_items": [{
			"name": "Jenga Order",
			"amount": 420510,
			"currency": "usd",
			"quantity": 1
		}],
		"success_url": "http://jengacorp.com/order/thankyou/success",
		"cancel_url": "http:\/\/jengacorp.com\/order\/thankyou\/cancel"
	}
}
```

