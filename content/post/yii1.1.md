+++
description = " Yii Quick Start"
title = "Yii 1.1 Quick Start"
date = 2020-05-27T12:50:48+08:00
tags = ["Yii 1.1"]
author = "Ken Cho"

+++
### What is [Yii](https://www.yiiframework.com/doc/guide/1.1/en/quickstart.what-is-yii)?

>Yii is a high-performance, component-based PHP framework for developing large-scale Web applications rapidly. 
>It enables maximum reusability in Web programming and can significantly accelerate your Web application development process. 

### What is Yii best for?
>Yii is a generic Web programming framework that can be used for developing virtually any type of Web application. 
>Because it is light-weight and equipped with sophisticated caching mechanisms, it is especially suited to high-traffic applications, such as portals, forums, content management systems (CMS), e-commerce systems, etc.

### Set up webserver with nginx and PHP-FPM using Docker, [link](https://medium.com/@isakhauge/create-a-basic-web-server-with-nginx-and-php-fpm-using-docker-5def5c32e628)
1. Build the images  
`sudo docker build -t peter/fpm ./images/fpm/ && docker build -t peter/ngx ./images/nginx/`

2. Build and start the container  
`docker-compose up`

### Installation and create skeleton application, [link](https://www.yiiframework.com/doc/blog/1.1/en/start.testdrive#user-notes)
1. download Yii 1.1 source code at [here](https://www.yiiframework.com/download)
2. unpack the .tar.gz and move to dockerfolder/app/ 
 `tar -xvzf yii-1.1.22.bf1d26.tar.gz`  
3. go into the framework folder  
 `./yiic webapp ../testdrive`  

### Update the ngx_conf/locations.conf
```
# yii-1.1.22 location
location /yii-1.1.22/ {
    autoindex on;
    autoindex_exact_size on;
    autoindex_format html;
    autoindex_localtime on;
} 
```

### Make sqlite db connection in `protected/config/main.php` within `return array`  
```
return array(
// sqlite database connection
    'components'=>array(
        'db'=>array(
            'connectionString'=>'sqlite:protected/data/testdrive.db',
        ),
    ),
);
```

### Allow Gii modules in `/protected/config/main.php` within `return array`     
```
    'modules'=>array(
        // uncomment the following to enable the Gii tool
        'gii'=>array(
            'class'=>'system.gii.GiiModule',
            'password'=>'Password',
            // If removed, Gii defaults to localhost only. Edit carefully to taste.
            // 'ipFilters'=>array('127.0.0.1','::1'),
               'ipFilters'=> False,
        ),
    ),
```  

### Allow path-format URLS to access Gii in `/protected/config/main.php` within `components`, [link](https://www.yiiframework.com/doc/api/1.1/GiiModule)      
```
    'urlManager'=>array(
        'urlFormat'=>'path',
        'rules'=>array(
            'gii'=>'gii',
            'gii/<controller:\w+>'=>'gii/<controller>',
            'gii/<controller:\w+>/<action:\w+>'=>'gii/<controller>/<action>',
        ),
    ),
```  
### Static structure of Yii application
![img](/image/static_structure.png)

### A Typical Worflow
![img](/image/typical_flow.png)

### The flow of MCV
![img](/image/mcv.png)

##### Reference
1. [An Introduction to PHP YII Framework For The Beginners](http://www.w3programmers.com/an-introduction-to-php-yii-framework-for-the-beginners/)  
2. [An introduction to Yii framework- part 2](http://www.w3programmers.com/introduction-yii-framework-part2/)  
3. [Introducing Gii of Yii framework](http://www.w3programmers.com/introducing-gii-of-yii-framework/)
