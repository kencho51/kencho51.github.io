+++
description = "What is Codeception?"
title = "Codeception"
date = 2020-06-23T13:41:41+08:00
tags = ["Codeception", "functional test", "php" ]
author = "Ken Cho"

+++

### What is Codeception?

>Codeception is a framework written in PHP for testing application and its multi-featured test framework powered by famous PHPUnit Framework.

>It can manage Unit, Functional and Acceptance for web application.

![img](/image/tests.png)

### How to create a Unit Test?
Testing pieces of code before coupling them together.

It creates a new ExampleTest file located in the tests/unit directory.  
`php vendor/bin/codecept generate:test unit Example`  
 
Run the newly created test with this command.
`php vendor/bin/codecept run unit ExampleTest`  



### Acceptance Test
>Acceptance testing allows us to test our applications using the normal website viewing process of visit a webpage, fill in a form, and submit the form to see the desired result.

>The difference is with Codeception, we don't have to waste time going to the browser each time we want to test a new feature out, instead we can just run our acceptance tests to see if they pass or not.

>Webserver is required. Can use Nginx from docker container.

### How to generate an acceptance test?
By running this code:  
`./vendor/bin/codecept generate:test_name acceptance`  

Run only acceptance test:  
`./vendor/bin/codecept run acceptance`  

See the full list of the tests (unit, acceptance and functional):  
`./vendor/bin/codecept run acceptance --steps`  



### Functional Test





### Reference
1. [Codeception Introduction](https://codeception.com/docs/01-Introduction)
2. [Codeception Quickstart](https://codeception.com/quickstart)
3. Introduction to Codeception, [medium](https://medium.com/tech-tajawal/introduction-to-codeception-e18503136ba8)
4. [Codeception support in PhpStorm](https://www.youtube.com/watch?v=B3PE7w-jvjQ)
5. [PHPBrowser Installation](https://codeception.com/docs/modules/PhpBrowser)
6. [Codeception and Yii](https://codeception.com/for/yii)