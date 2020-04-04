## You have requested a non-existent service "templating". Did you mean one of these: "templating.helpe

```shell
composer require symfony/templating -vvv
```

Then, add the following configuration under the `framework` key in your config.yml:

> ```yaml
> templating:
>     engines: ['twig']
> ```