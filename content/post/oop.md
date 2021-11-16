+++
description = "What is Object Oriented Programming?"
title = "OOP"
date = 2020-05-26T10:13:43+08:00
tags = ["OOP", "php"]
author = "Ken Cho"

+++
### What is OOP?
Object-oriented programming is a style of coding that allows developers to group similar tasks into classes. This helps keep code following the tenet "don't repeat yourself" (DRY) and easy-to-maintain.
>Object-oriented programming is a style of coding that allows developers to group similar tasks into classes.
### What is a class?
>A `blueprint for a house`. It defines the shape of the house on paper, with relationships between the different parts of the house clearly defined and planned out, even though the house doesn't exist.
### What is an object?
>An objectis like the `actual house` built according to that blueprint. The data stored in the object is like the wood, wires, and concrete that compose the house: without being assembled according to the blueprint, it's just a pile of stuff. However, when it all comes together, it becomes an organized, useful house.

### Example of Class and Object in OOP
![img](/image/oop_cars.jpg)

### WHy OOP is so powerful?
`Classes form the structure of data and actions` and use that information `to build objects`. `More than one object` can be built from the `same class` at the `same time`, each one `independent` of the others.
`OOP keeps objects as separate entities.`

### What is Visibility/Access modifier?
>Any property, constant or method in class can be accessed with visibility. Visibility is usually declared in class by constant, property, method before the announcement.

### 3 types of [visibility](http://www.w3programmers.com/visibility-or-access-modifier-in-php/) in PHP
![img](/image/visibility.jpg)
1. `private`
>If the constant, property, method in class is to restrict the usage of only the same class or class, then those constant, property, methods are to be declared private.

>eg. The property can only be accessed within the class. 
2. `protected`
> If constant, property, method in class is to restrict the usage of only the same class or class itself and its child class, then those constant, property, methods are to be declared protected.

>eg. The property can only be accessed by the current class and it's child class.
3. `public`
>If you want constant, property, methods in class, use the same class or class itself, child class and class outside, then those constant, property, methods are to be declared public.

>eg. The property declared in a class can be accessed from the current class, child class and even outside of the class.
### Some useful terms and syntax
1. `Parent Class`
>When a class inherits from another class, then the class from which the new class is created, is called parent class. Parent class is called base class or super class.
2. `Child Class`
>When a class is inherited from another class, it is called child class. The child class is called subclass or derived class.
3. `Property`
>Variables in the class in PHP are called properties. Properties are also called “attributes” or “fields”. Property in PHP is to define with any one visibility: public, private, protected.
4. `Method`
>Functions in class in PHP are called method. The methods in PHP are to declare with any one of the visibility: public, private, protected.
5. `static keyword`
> If you want to give access to any property or method without any instance or object, or if you want to access it directly by class, then static keyword is used.
6. `"::" scope resolution operator`
>To use any static property, static method and constant in the class in PHP, use “:: scope resolution operator” if you want to use it inside or outside the class.
7. `"$this" pseudo variable`
>Originally contained the object of the current class. If you want to use any non-static property in PHP and non-static method within the class, you need to use “$this” pseudo-variable.
>When working within a method, use `$this` in the same way you would use the object name outside the class.
8. `->`
>Accesses the contained properties and methods of a given object.  

### Example code
```php
<?php
 
class MyClass
{
  public $prop1 = "I'm a class property!";
 
  public function setProperty($newval)
  {
      $this->prop1 = $newval;
  }
 
  public function getProperty()
  {
      return $this->prop1 . "\n";
  }
}
 
// Create two objects
$obj = new MyClass;
$obj2 = new MyClass;
 
// Get the value of $prop1 from both objects
echo $obj->getProperty();
echo $obj2->getProperty();
 
// Set new values for both objects
$obj->setProperty("I'm a new property value!");
$obj2->setProperty("I belong to the second instance!");
 
// Output both objects' $prop1 value
echo $obj->getProperty();
echo $obj2->getProperty();
 
?>
```
The above code will return as below:  
>I'm a class property!  
>I'm a class property!  
>I'm a new property value!  
>I belong to the second instance  

### What are the Magic Methods in OOP in PHP?
[link](https://code.tutsplus.com/tutorials/object-oriented-php-for-beginners--net-12762)

### Comparing Object Oriented and Procedural Code
##### The Procedural Approach
```php
<?php
 
function changeJob($person, $newjob)
{
  $person['job'] = $newjob; // Change the person's job
  return $person;
}
 
function happyBirthday($person)
{
  ++$person['age']; // Add 1 to the person's age
  return $person;
}
 
$person1 = array(
  'name' => 'Tom',
  'job' => 'Button-Pusher',
  'age' => 34
);
 
$person2 = array(
  'name' => 'John',
  'job' => 'Lever-Puller',
  'age' => 41
);
 
// Output the starting values for the people
echo "<pre>Person 1: ", print_r($person1, TRUE), "</pre>";
echo "<pre>Person 2: ", print_r($person2, TRUE), "</pre>";
 
// Tom got a promotion and had a birthday
$person1 = changeJob($person1, 'Box-Mover');
$person1 = happyBirthday($person1);
 
// John just had a birthday
$person2 = happyBirthday($person2);
 
// Output the new values for the people
echo "<pre>Person 1: ", print_r($person1, TRUE), "</pre>";
echo "<pre>Person 2: ", print_r($person2, TRUE), "</pre>";
 
?>
```
The code above will output:
```php
Person 1: Array
(
  [name] => Tom
  [job] => Button-Pusher
  [age] => 34
)
Person 2: Array
(
  [name] => John
  [job] => Lever-Puller
  [age] => 41
)
Person 1: Array
(
  [name] => Tom
  [job] => Box-Mover
  [age] => 35
)
Person 2: Array
(
  [name] => John
  [job] => Lever-Puller
  [age] => 42
)
``` 
##### The OOP Aproach
```php
<?php
 
class Person
{
  private $_name;
  private $_job;
  private $_age;
 
  public function __construct($name, $job, $age)
  {
      $this->_name = $name;
      $this->_job = $job;
      $this->_age = $age;
  }
 
  public function changeJob($newjob)
  {
      $this->_job = $newjob;
  }
 
  public function happyBirthday()
  {
      ++$this->_age;
  }
}
 
// Create two new people
$person1 = new Person("Tom", "Button-Pusher", 34);
$person2 = new Person("John", "Lever Puller", 41);
 
// Output their starting point
echo "<pre>Person 1: ", print_r($person1, TRUE), "</pre>";
echo "<pre>Person 2: ", print_r($person2, TRUE), "</pre>";
 
// Give Tom a promotion and a birthday
$person1->changeJob("Box-Mover");
$person1->happyBirthday();
 
// John just gets a year older
$person2->happyBirthday();
 
// Output the ending values
echo "<pre>Person 1: ", print_r($person1, TRUE), "</pre>";
echo "<pre>Person 2: ", print_r($person2, TRUE), "</pre>";
 
?>
```
The code above will output:
```php
Person 1: Person Object
(
  [_name:private] => Tom
  [_job:private] => Button-Pusher
  [_age:private] => 34
)
 
Person 2: Person Object
(
  [_name:private] => John
  [_job:private] => Lever Puller
  [_age:private] => 41
)
 
Person 1: Person Object
(
  [_name:private] => Tom
  [_job:private] => Box-Mover
  [_age:private] => 35
)
 
Person 2: Person Object
(
  [_name:private] => John
  [_job:private] => Lever Puller
  [_age:private] => 42
)
```
### What is [`Method Chaining`](http://www.w3programmers.com/php-oop-method-chaining/) in PHP and example code?
>When many methods are called in a single instruction, in PHP’s term it is called Method Chaining.  

General class and its results:
```php
<?php
 class person
 {
    private $name="";
    private $age="";
 
    public function setName($name="")
    {
      $this->name=$name;
    }
    public function setAge($age="20")
    {
      $this->age=$age;
    }
    public function getInfo()
    {
      echo "Hello, My name is ".$this->name." and my age is ".$this->age." years.";
    }
}
 
$person = new person();
  $person->setName("Ken");
  $person->setAge("25");
  $person->getInfo();
?>
```
Result will be:  
>Hello, My name id Ken and my age is 25 years.

Method Chaining way
```php
<?php
class person
{
  private $name="";
  private $age="";
 
  public function setName($name="")
  {
    $this->name=$name;  
    return $this;
  }
  public function setAge($age="20")
  {
    $this->age=$age;
    return $this;
  }
 
  public function getInfo()
  {
    echo "Hello, My name is ".$this->name." and my age is ".$this->age." years.";
  }
}
 
$person = new person();
  $person->setName("Ken")->setAge("25")->getInfo();
 ?>
```
Explanation
>return $this pseudo-variable between setName() method and setAge() method.
>“$this” pseudo-variable originally contained the object of the current class.
>$person->setName(‘Ken’) to call setName() Method and set Ken to name property as value.
>setName () method will return $this, which will return the Object person

### PHP OOP [inheritance](http://www.w3programmers.com/php-oop-inheritance/)
>If a child class inherits some of the features of it’s parent class and then use it, this process is called inheritance.  
```php
<?php
class Member {
    public $username = "";
    private $loggedIn = false;
    public function login() {
        $this->loggedIn = true;
    }
    public function logout() {
        $this->loggedIn = false;
    }
    public function isLoggedIn() {
        return $this->loggedIn;
    }
}
 
class Administrator extends Member {
    public function createForum( $forumName ) {
        echo "$this->username created a new forum: $forumName<br>";
    }
    public function banMember( $member ) {
        echo "$this->username banned the member: $member->username<br>";
    }
}
 
// Create a new member and log them in
$member = new Member();
$member->username = "Ken";
$member->login();
echo $member->username . " is " . ( $member->isLoggedIn() ? "logged in" : "logged out" ) . "<br>";
 
// Create a new administrator and log them in
$admin = new Administrator();
$admin->username = "Peter";
$admin->login();
echo $admin->username . " is " . ( $member->isLoggedIn() ? "logged in" : "logged out" ) . "<br>";
// Displays "Peter created a new forum: W3programmers"
$admin->createForum( "W3programmers" );
// Displays "Peter banned the member: Ken"
$admin->banMember( $member );
?>
```

### Abstract class and methods
![img](/image/abstract.png)
>Abstract Class in PHP is a special class from which an object can not instantiate or be created.

>But from Abstract Classes you can create a child class or can inherit.

Example 1
```php
<?php
abstract class AbstractClass{
    // Our abstract method only needs to define the required arguments
    abstract protected function getName($name);
    }
 
class childClass extends AbstractClass{
    public function getName($name) {
        return "Hi ".$name." !";
    }
}
 
$class = new childClass;
echo $class->getName("Ken"), "\n";
?>
```
Result:
`Hi! Ken`

Example 2
```php
<?php
abstract class AbstractClass{
    // Our abstract method only needs to define the required arguments
    abstract protected function getName($name);
    }
 
class childClass extends AbstractClass{
    public function getName($name,$prefix="Mr. ") {
        return "Hi ".$prefix.$name." !";
    }
}
 
$class = new childClass;
echo $class->getName("Ken"), "\n";
?>
```
Result:
`Hi Mr. Ken !`

### What is Interfaces in OOP?



### Reference 
1. [Object-Oriented PHP for Beginners](https://code.tutsplus.com/tutorials/object-oriented-php-for-beginners--net-12762)
2. [OOP](https://searchapparchitecture.techtarget.com/definition/object-oriented-programming-OOP) 
3. [PHP Object Oriented Programming Part I: PHP OOP Basics](http://www.w3programmers.com/php-oop-basics/)
4. [PHP Object Oriented Programming Part-2: Making and Using Class, Object and Class Members](http://www.w3programmers.com/making-and-using-class/)
5. [PHP Object Oriented Programming Part-3: PHP OOP Method Chaining](http://www.w3programmers.com/php-oop-method-chaining/)
6. [PHP Object Oriented Programming Part-5: Visibility or Access Modifier in PHP](http://www.w3programmers.com/visibility-or-access-modifier-in-php/)
7. [PHP Object Oriented Programming Part-8: Abstract Class and Methods](http://www.w3programmers.com/abstract-class-and-methods/)
8. [Understanding Functional Programming in Javascript — A Complete Guide](https://levelup.gitconnected.com/understanding-functional-programming-in-javascript-a-complete-guide-e85ed13b42c8)

