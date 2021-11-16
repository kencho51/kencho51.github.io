+++
description = "Steps to build a blog using Yii1.1"
title = "How to build a blog using Yii1.1"
date = 2020-06-01T10:10:24+08:00
tags = ["Yii 1.1", "sqlite", "php"]
author = "Ken Cho"

+++
### Aim
To familiarize the framework of Yii 1.1.  

### How
1. The steps can be found [here](https://www.yiiframework.com/doc/blog/1.1/en/start.testdrive)  
2. The source code is stored at [github repo]()  

### Docker container for Nginx and PHP=FPM webserver, [link](link)



### Steps to note
1. Download the Yii 1.1 source code at [here](https://www.yiiframework.com/download)   
2. Unpack the compressed file and move to dockerfolder/app  
`tar -xvzf yii-1.1.22.bf1d26.tar.gz`  
3. Rename the folder name to `yii-1.1.22`  
4. Go to the framework folder to create a skeleton application by  
`./yiic webapp ../blog-yii1.1`  
5. Establish DB connection in `/protected/config/database.php` 
```php
return array(
	'connectionString' => 'sqlite:'.dirname(__FILE__).'/../data/blog.db',
);
```
6. Allowing Gii for scafolding  `/protected/config/main.php`  
```php
 'import'=>array(
        'application.models.*',
        'application.components.*',
    ),
 
    'modules'=>array(
        'gii'=>array(
            'class'=>'system.gii.GiiModule',
            'password'=>'Password',
            'ipFilters' = False,
        ),
    ),
```

7. How to customize the rules method in `/protected/models/Post.php`
```php
public function normalizeTags($attribute,$params)
{
    $this->tags=Tag::array2string(array_unique(Tag::string2array($this->tags)));
}
```
```php
public function rules()
{
    return array(
        array('title, content, status', 'required'),
        array('title', 'length', 'max'=>128),
        array('status', 'in', 'range'=>array(1,2,3)),
        array('tags', 'match', 'pattern'=>'/^[\w\s,]+$/',
            'message'=>'Tags can only contain word characters.'),
        array('tags', 'normalizeTags'),
 
        array('title, status', 'safe', 'on'=>'search'),
    );
}
```
8. How to customize the rules method in `/protected/models/Tag.php`
```php
public static function string2array($tags)
{
    return preg_split('/\s*,\s*/',trim($tags),-1,PREG_SPLIT_NO_EMPTY);
}
 
public static function array2string($tags)
{
    return implode(', ',$tags);
}
```

9. How to customize the relations method in `protected/models/Post.php`
```php
public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'author' => array(self::BELONGS_TO, 'User', 'author_id'),
			'comments' => array(self::HAS_MANY, 'Comment', 'post_id',
                'condition'=>'comments.status='.Comment::STATUS_APPROVED,
                'order'=>'comments.create_time DESC'),
            'commentCount' => array(self::STAT, 'Comment', 'post_id',
                'condition'=>'status='.Comment::STATUS_APPROVED),
		);
	}
```
10. How to customize the relations method in  `protected/models/Comment.php`
```php
class Comment extends CActiveRecord
{
    const STATUS_PENDING=1;
    const STATUS_APPROVED=2;
    const STATUS_ARCHIVED=3
    ......
```

11. How to create portlets for User Menu, Tag Cloud and Recent Comments  
11.1 [UserMenu portlet](https://www.yiiframework.com/doc/blog/1.1/en/portlet.menu)  
11.2 [TagCloud](https://www.yiiframework.com/doc/blog/1.1/en/portlet.tags)
    - Create a `Tag.php` in `/protected/models/Tag.php` 
    - Add `'tagCloudCount'=>20` in `config/main.php` under param
    
    11.3 [RecentComments](https://www.yiiframework.com/doc/blog/1.1/en/portlet.comments)
    

### Points to note  

