+++
description = "Yii 2.0 learning progress"
title = "Yii 2.0 - Getting Started"
date = 2020-05-26T11:05:40+08:00
tags = ["Yii", "php", "composoer"]
author = "Ken Cho"

+++
### Install Composer via Composer on Mac OS X
`curl -sS https://getcomposer.org/installer | php` 
`sudo mv composer.phar /usr/local/bin/composer`  

### Install Yii
`composer create-project --prefer-dist yiisoft/yii2-app-basic basic` 

### Installing Assets
`Add the following lines to /basic/composer.json`
```
"replace": {
    "bower-asset/jquery": ">=1.11.0",
    "bower-asset/inputmask": ">=3.2.0",
    "bower-asset/punycode": ">=1.3.0",
    "bower-asset/yii2-pjax": ">=2.0.0"
},
```
### Verify the Installation
Go into the basic/  
`php yii serve`  
User browser to access:  
`http://localhost:8080/`

### CHeck if the minimum requirements are met by running
`cd basic`  
`php requirements.php`

### Apache Configuration
Update `/etc/apache2/httpd.conf` accordingly
```
# Set document root to be "basic/web"
DocumentRoot "path/to/basic/web"

<Directory "path/to/basic/web">
    # use mod_rewrite for pretty URL support
    RewriteEngine on
    
    # if $showScriptName is false in UrlManager, do not allow accessing URLs with script name
    RewriteRule ^index.php/ - [L,R=404]
    
    # If a directory or a file exists, use the request directly
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    
    # Otherwise forward the request to index.php
    RewriteRule . index.php

    # ...other settings...
</Directory>
```

### Yii static structure of an application
![Application Structure](/image/application-structure.png)

### Yii Request Lifecycle
![Request Lifecycle](/image/request-lifecycle.png)
```
1. A user makes a request to the entry script web/index.php.
2. The entry script loads the application configuration and creates an application instance to handle the request.
3. The application resolves the requested route with the help of the request application component.
4. The application creates a controller instance to handle the request.
5. The controller creates an action instance and performs the filters for the action.
6. If any filter fails, the action is cancelled.
7. If all filters pass, the action is executed.
8. The action loads some data models, possibly from a database.
9. The action renders a view, providing it with the data models.
10. The rendered result is returned to the response application component.
11. The response component sends the rendered result to the user's browser.
```
### Working with forms
Add the following to /basic/controllers/SiteController.php  
`use app\models\EntryForm;`  

### Working with Databases
Mac has pre-installed [sqlite3](https://www.sitepoint.com/getting-started-sqlite3-basic-commands/)
1. Create a yii2basic database with table `country`
```
CREATE TABLE `country` (
  `code` CHAR(2) NOT NULL PRIMARY KEY,
  `name` CHAR(52) NOT NULL,
  `population` INT(11) NOT NULL DEFAULT '0');

INSERT INTO `country` VALUES ('AU','Australia',24016400);
INSERT INTO `country` VALUES ('BR','Brazil',205722000);
INSERT INTO `country` VALUES ('CA','Canada',35985751);
INSERT INTO `country` VALUES ('CN','China',1375210000);
INSERT INTO `country` VALUES ('DE','Germany',81459000);
INSERT INTO `country` VALUES ('FR','France',64513242);
INSERT INTO `country` VALUES ('GB','United Kingdom',65097000);
INSERT INTO `country` VALUES ('IN','India',1285400000);
INSERT INTO `country` VALUES ('RU','Russia',146519759);
INSERT INTO `country` VALUES ('US','United States',322976000);
```  
2. DB connection
Update path in `config/db.php`  
`'dsn' => 'sqlite:/path/to/sqlite/db/file'`

3. Create CRUD with Gii
To enter Gii interface  
`http://localhost:8080/index.php?r=gii`  
### Reference
1. [Yii Getting Started](https://www.yiiframework.com/doc/guide/2.0/en/start-prerequisites)
2. [Database Access](https://www.tutorialspoint.com/yii/yii_database_access.htm)

