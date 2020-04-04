## 路由

### 路由示例

#### annotations

```php
// src/AppBundle/Controller/BlogController.php
namespace AppBundle\Controller;
 
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
 
class BlogController extends Controller
{
    /**
     * Matches /blog exactly / 精确匹配了/blog
     *
     * @Route("/blog", name="blog_list")
     */
    public function listAction()
    {
        // ...
    }
 
    /**
     * Matches /blog/* / 匹配的是/blog/*
     *
     * @Route("/blog/{slug}", name="blog_show")
     */
    public function showAction($slug)
    {
        // $slug will equal the dynamic part of the URL
        // e.g. at /blog/yay-routing, then $slug='yay-routing'
        // $slug 必须等同于URL中的动态部分
        // 即，在 /blog/yay-routing 中 $slug='yay-routing'
 
        // ...
    }
}
```

#### YAML

```yaml
# app/config/routing.yml
blog_list:
    path:     /blog
    defaults: { _controller: AppBundle:Blog:list }

blog_show:
    path:     /blog/{slug}
    defaults: { _controller: AppBundle:Blog:show }
```

#### php

```php
// app/config/routing.php
use Symfony\Component\Routing\RouteCollection;
use Symfony\Component\Routing\Route;
 
$collection = new RouteCollection();
$collection->add('blog_list', new Route('/blog', array(
    '_controller' => 'AppBundle:Blog:list',
)));
$collection->add('blog_show', new Route('/blog/{slug}', array(
    '_controller' => 'AppBundle:Blog:show',
)));
 
return $collection;
```



### 通过条件来限制路由匹配

```yaml
contact:
    path:     /contact
    defaults: { _controller: AcmeDemoBundle:Main:contact }
    condition: "context.getMethod() in ['GET', 'HEAD'] and request.headers.get('User-Agent') matches '/firefox/i'"

```



```php
use Symfony\Component\Routing\RouteCollection;
use Symfony\Component\Routing\Route;
 
$collection = new RouteCollection();
$collection->add('contact', new Route(
    '/contact', array(
        '_controller' => 'AcmeDemoBundle:Main:contact',
    ),
    array(),
    array(),
    '',
    array(),
    array(),
    'context.getMethod() in ["GET", "HEAD"] and request.headers.get("User-Agent") matches "/firefox/i"'
));
 
return $collection;
```



## 控制器

### 访问其他服务

```php

$templating = $this->get('templating');
 
$router = $this->get('router');
 
$mailer = $this->get('mailer');
```

到底存在哪些服务？我想要看所有的服务，请使用`debug:container`命令行查看：

``` shell
php bin/console debug:container
```

### 管理错误和404页面 

```php
public function indexAction()
{
    // retrieve the object from database
    $product = ...;
    if (!$product) {
        throw $this->createNotFoundException('The product does not exist');
    }
 
    return $this->render(...);
}
```

### Request对象作为一个控制器参数

```php
use Symfony\Component\HttpFoundation\Request;
 
public function indexAction($firstName, $lastName, Request $request)
{
    $page = $request->query->get('page', 1);
 
    // ...
}
```

```php
use Symfony\Component\HttpFoundation\Request;
 
public function indexAction(Request $request)
{
    $request->isXmlHttpRequest(); // is it an Ajax request?
 
    $request->getPreferredLanguage(array('en', 'fr'));
 
    // retrieve GET and POST variables respectively
    $request->query->get('page');
    $request->request->get('page');
 
    // retrieve SERVER variables
    $request->server->get('HTTP_HOST');
 
    // retrieves an instance of UploadedFile identified by foo
    $request->files->get('foo');
 
    // retrieve a COOKIE value
    $request->cookies->get('PHPSESSID');
 
    // retrieve an HTTP request header, with normalized, lowercase keys
    $request->headers->get('host');
    $request->headers->get('content_type');
}
```

### Response

```php

use Symfony\Component\HttpFoundation\Response;
 
// create a simple Response with a 200 status code (the default)
$response = new Response('Hello '.$name, Response::HTTP_OK);
 
// create a CSS-response with a 200 status code
$response = new Response('<style> ... </style>');
$response->headers->set('Content-Type', 'text/css');
```

也有一些特殊的类能够简化某种响应：

- 对于JSON：这是一个`JosnResponse`。可查看 [创建一个JOSN响应](http://www.symfonychina.com/doc/current/components/http_foundation.html#catalog16)
- 对于文件操作：这是 `BinaryFileResponse`。可查看 [Serving Files](http://www.symfonychina.com/doc/current/components/http_foundation.html#catalog15)。
- 对于流响应，有`StreamedResponse`。请看：[流化一个响应](http://www.symfonychina.com/doc/current/components/http_foundation.html#catalog14)



#### JSON Helper

```php
public function indexAction()
{
    // returns '{"username":"jane.doe"}' and sets the proper Content-Type header
    return $this->json(array('username' => 'jane.doe'));
 
    // the shortcut defines three optional arguments
    // return $this->json($data, $status = 200, $headers = array(), $context = array());
}
```



### 管理Session

```php
use Symfony\Component\HttpFoundation\Request;
 
public function indexAction(Request $request)
{
    $session = $request->getSession();
 
    // store an attribute for reuse during a later user request
    $session->set('foo', 'bar');
 
    // get the attribute set by another controller in another request
    $foobar = $session->get('foobar');
 
    // use a default value if the attribute doesn't exist
    $filters = $session->get('filters', array());
}
```

### Flash Message

```php
use Symfony\Component\HttpFoundation\Request;
 
public function updateAction(Request $request)
{
    $form = $this->createForm(...);
 
    $form->handleRequest($request);
 
    if ($form->isValid()) {
        // do some sort of processing
 
        $this->addFlash(
            'notice',
            'Your changes were saved!'
        );
 
        // $this->addFlash is equivalent to $this->get('session')->getFlashBag()->add
 
        return $this->redirectToRoute(...);
    }
 
    return $this->render(...);
}
```

### 部署

#### 清除缓存

> ```shell
> php bin/console cache:clear --env=prod --no-debug
> ```