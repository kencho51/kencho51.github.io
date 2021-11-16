+++
description = "Yii framework Wiki"
title = "Yii1.1 for beginners"
date = 2020-06-04T15:05:46+08:00
tags = ["yii", "yii1.1", "php"]
author = "Ken Cho"

+++
### What is Yii Model-View-Controller architecture?
MVC schema

![img](/image/mvc_schema.png)
1. `Model`
>defines relations among data in DB and rules that must be followed when saving data to DB. It also gives us tools to read/save data from/to DB.

2. `View`
>shows data to user. It doesn’t write to DB or count difficult things. It just receives data and shows them using HTML, CSS, JS, etc.

3. `Controller`
>processes and changes the data, handles user’s actions, decides, counts, thinks and calls models and views. It simply acts.

### Controller
Controller is initiated (and it's code is run) whenever you enter any address in browser. In its code you can read data from POST, GET or SESSION variables, work with DB etc. 
Here shows you how to access controller:  
`www.myweb.com/index.php?r=myController`  
Parameter `r` says that you want to use Controller named `myController`. Controller can have one or more sub-controllers. Each does something else.
Each table in DB has its own model. This model has the same (or similar) name like the table. Each model has 2 important functions. Find data and Save data. 
### Model
Model is very simple thing in Yii. You don’t have to write a single line of its code, it can be created automatically using `Gii`.
### View
It just receives data from Controller and shows them. This is the only place where we use HTML, CSS, JavaScript etc. 
![img](/image/mvc_flow.png)

### What is framework?
Framework is a set of functions that can ease your work. Functions are usually grouped into Classes. In Yii framework there is available class named CHtml.
It provides functions for creating HTML code. (Tables, lists, forms...). 
`echo CHtml::beginForm()` will creates this html code: `<form method=”post” action=”thisScriptName”>`

### What is Gii?
Gii is webpage that comes with Yii framework. In protected/config/main.php you have to uncomment it and enter password for Gii. Than go to you localhost website and run controller gii like this:
`localhost/myproject/index.php?r=gii`

### How to define relations in models manually?
When you created models for all tables, it may be necessary to define relations. his can be done using function relations() in model file. 
The relation is an SQL Join. When you make relation from list of employees to their jobs and name this relation ‘job’, you can then write this in Controller to get employee’s job:
```php
$Employee = Employees::model()->findByPk($employeeId);
$myJobName = $Employee->job->jobName;

/*
Where:
Employees = model of table created using yiic shell. 
jobName = column in Jobs table. 
job = relation name.
$Employee = 1 returned record from table Employees - only one because we were searching by PK. If we searched using findAll() it would return list of records and it would be necessary to walk through them using foreach.

In your model should be cca this function:
*/

public function relations()
{
  return array(
	           'job' => array(self::BELONGS_TO, 'JobsTableName', 'id_job'),
           );
}
```
### How to create the first controller?
Need one file in folder: protected/controllers. The file must be named like this 'NameController.php`. 
Whats inside the controller.php?
```php
<?php
class MyfirstController extends Controller
{
  public function actionIndex()
  {
    // here is your code for this action
  }

  public function actionMyaction()
  {
    // here is your code for this action
    $this->render(‘myview’);
  }

  public function getEmployeeName()
  { 

  }

}
?>
```



 

### Reference
1. [Yii for beginners 1](https://www.yiiframework.com/wiki/250/yii-for-beginners)
2. [Yii for beginners 2](http://www.yiiframework.com/wiki/462/yii-for-beginners-2)
