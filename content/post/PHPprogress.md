+++
description = "Learning PHP at Codecademy"
title = "PHP progress"
date = 2020-05-19T17:48:07+08:00
tags = ["php", "develop"]
author = "Ken Cho"

+++
### Learning PHP at [Codecademy](https://www.codecademy.com/learn/learn-php)

##### Topics
1. String and variables - Done  
2. Number - Done  
3. Functions - Done  
4. Intro to Built-in PHP functions - Done  
    - find variable types  
    `gettype(); var_dump();`    
    - string functions  
    `strrev();strtolower(); strtoupper(); str_repeat();`  
    - substring  
    `substr_count();`  
    - number function  
    `abs(); round();`  
    - generating random numbers  
    `rand(); getrandmax(); ceil();`  
    - documentation  
    `str_pad();`  
    - check value in array\
    `in_array("valuetocheck", $array)`


5. Ordered Arrays 
    - can be integer or string or any data type    
    `$my_array = array(); or $my_array=[];`       
    - returns the array length  
    `count($array);`        
    - print the array in  array list  
    `print_r();`      
    - print the array into string  
    `implode ("glue", array);`  
    - accessing the array  
    `$my_array[pos];`  
    - adding and changing elements
    `$my_array[pos] = new value;`  
    - pushing and popping  
        - remove the last element  
        `array_pop();`  
        - append the element
        `array_push();`  
        - remove first element  
        `array_shift();`  
        - prepend the element  
        `array_unshit();`       
        - remove the first element  
        `array_shift();` 
        - nestede array  
        `value = $my_array[][][]`  

6. Associative Arrays 
        - concept of dictionary   
        - key and valure pair  
        `$my_array = array("key"=>"value"); or $my_array = ["key"=>"value"];`   
        - remove element  
        `unset();`  
        - joining the array in union manner  
        - assign by reference
```php
function changeArrayValue(&$new) 
{
 $new["new"] = "old";
 return $new;
};
```

7. PHP and HTML  
    7.1 PHP was designed as a back-end web development language  
    7.2 HTML is a front-end language  
    7.3 example code  
```php
<?php 
  echo "<h3>Hello! I'm {$about_me["name"]}!</h3>";
  echo "<p> I'm " . calculateAge($about_me). " years old! That's pretty cool, right?</p>";
  echo "<div>What more is there to say? I love {$about_me["favorite_food"]}, and that's pretty much it!</div>"; 
?>
```    
  
8. HTML From Handling in PHP, `Superglobals` 
    8.1 `<?=` is shorthand for `<?php echo`  
    8.2 `$_GET` is an associative array containing data from a GET request.  
    8.3 `$_POST` is an associative array containing data from a POST request.  
    8.4 `$_REQUEST`is an associative array containing data from both GET and POST requests.  
    8.5 eg. `<form method="get" or "post" action="greet.php">` 
  
9. Booleans and Comparision operators   
    9.1 identical and not identical operators
        `===`  or `!==`  
    9.2 built-in function to get current month  
        `date("F")`  
    9.3 multiple condition  
        `elseif(condition){action;}`    
    9.4 switch statement
```php    
switch($condition){
    case "condition A":
        echo "action":  
        break;
```   
    9.5 ternary operator  
```php
function ternaryCheckout($items) 
{ 
    return $items <= 12 ? "express lane" : "regular lane";
}
```
10. Logical Operators and Compound Conditions  
    10.1 `&&` has higer precedence than `||`\
    10.2 `T || T` is True, `T xor T` is False\
11. Loops  
    11.1 while loop  
    11.2 do...while loop,`the loop will execute at least one time`  
    11.3 for loop  
    11.4 foreach  
    11.5 break and continue  
        11.5.1 `break`: execute, stop and leave  
        11.5.2 `continue`: skip and move on  
12. Loops in HTML  
    12.1 `foreach`  
```php
<?php
$footwear = [
  "sandals" => 4,
  "sneakers" => 7,
	"boots" => 3
];
?>
<p>Our footwear:</p>
<h3>foreach</h3>
<?php
foreach ($footwear as $type => $brands):
?>
<p>We sell <?=$brands?> brands of <?=$type?></p>
<?php
endforeach;
?>
```   

   12.2 `for`

```php
<h3>for</h3>
<?php
$types = [
  "sandals",
  "sneakers",
	"boots"
];
$quantities = [
  4,
  7,
	3
];
for ($i=0; $i<count($types); $i++):
?>
<p>We sell <?=$quantities[$i]?> brands of <?=$types[$i]?></p>
<?php
endfor;
?>
```

   12.3 `while`

```php
<h3>while</h3>
<?php
$types = [
  "sandals",
  "sneakers",
	"boots"
];
$quantities = [
  4,
  7,
	3
];
$i = 0;
while ($i<count($types)):
?>
<p>We sell <?=$quantities[$i]?> brands of <?=$types[$i]?></p>
<?php
$i++;
endwhile;
?>
```  

13. Intro to form validation  
14. Intro to Regular expression 
    - eg. regex to match the following pattern  
    `^[\d|\(][\s|\d]\d[.|\d|-][\)|\d][\s|\d]\d[.|\d|-]\d[\s|\d]?\d*`    
```php
718-555-3810
9175552849
1 212 555 3821
(917)5551298
212.555.8731
``` 
15. Intro to PHP form validation  
    15.1 Simple Validation
```php
<?php
$validation_error = "";
$user_language = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
$user_language = $_POST["language"];
  if ($user_language != "PHP") {
    $validation_error = "* Your favorite language must be PHP!";
  } 
}
?>

<form method="post" action="">
Your Favorite Programming Language: <input type="text" name="language" value="<?php echo $user_language;?>">
<p class="error"><?= $validation_error;?></p>
<input type="submit" value="Submit Language">
</form>
```


   15.2 Basic data sanitizing  
`$email = "aisle.nevertell@yahoo.com   "; 
echo trim($email);`  
`//Prints: aisle.nevertell@yahoo.com`  
`htmlspecialchars()`  
`filter_var($email, FILTER_SANITIZE_EMAIL);`  
`filter_var($bad_email, FILTER_VALIDATE_EMAIL)`  
```php
if ($_SERVER["REQUEST_METHOD"] === "POST"){
  $user_url = $_POST["url"];
  if (!filter_var($user_url, FILTER_VALIDATE_URL)){
    $validation_error = "* This is an invalid URL.";
    $form_message = "Please retry and submit your form again.";
  }else{
    $form_message = "Thank you for your submission.";
  }
}
```


   15.3 Custom Validation  
```php
<?php
$feedback = "";
$success_message = "Thank you for your donation!";
$error_message = "* There was an error with your card. Please try again.";

$card_type = "";
$card_num = "";
$donation_amount = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $card_type = $_POST["credit"];
    $card_num = $_POST["card-num"];
    $donation_amount = $_POST["amount"];

    if (strlen($card_num)<100){
      if ($card_type === "mastercard"){
        if (preg_match("/5[1-5][0-9]{14}/", $card_num) === 1){
          $feedback = $success_message;
        } else {
          $feedback = $error_message;
        }
  	  } else if ($card_type === "visa") {
        if (preg_match("/4[0-9]{12}([0-9]{3})?([0-9]{3})?/", $card_num) === 1){
          $feedback = $success_message;
        } else {
          $feedback = $error_message;
       }
    }
  } else {
      $feedback = $error_message;
    }
}
?>
<form action="" method="POST">
  <h1>Make a donation</h1>
    <label for="amount">Donation amount?</label>
      <input type="number" name="amount" value="<?= $donation_amount;?>">
      <br><br>
    <label for="credit">Credit card type?</label>
      <select name="credit" value="<?= $card_type;?>">
        <option value="mastercard">Mastercard</option>
        <option value="visa">Visa</option>
      </select>
      <br><br>
      <label for="card-num">Card number?</label>
      <input type="number" name="card-num" value="<?= $card_num;?>">
      <br><br>   
      <input type="submit" value="Submit">
</form>
<span class="feedback"><?= $feedback;?></span>
```
The above code will output:
![img](/image/formvalidation.png)

   15.4 Validating against back-end data
    
```php
<?php
$users = ["coolBro123" => "password123!", "coderKid" => "pa55w0rd*", "dogWalker" => "ais1eofdog$"];  
  
  
$feedback = "";
$message = "You're logged in!";
$validation_error = "* Incorrect username or password.";
$username = "";

// Write your code here:
if ($_SERVER["REQUEST_METHOD"] == "POST"){
  $username = $_POST["username"];
  $password = $_POST["password"];
  if (isset($users[$username]) && $users[$username]===$password){
    $feedback = $message;
  }else{
    $feedback = $validation_error;
  }
};

?>
  
<h3>Welcome back!</h3>
<form method="post" action="">
Username:<input type="text" name="username" value="<?php echo $username;?>">
<br>
Password:<input type="text" name="password" value="">
<br>
<input type="submit" value="Log in">
</form>
<span class="feedback"><?= $feedback;?></span>
```
The above code will output:
![img](/image/backend.png)

   15.5 Sanitizing for back-end storage  
It is essential to sanitize all data before storing it in our own databases. We’ll also want to sanitize the formatting: make sure the data stored in our database follows consistent formatting.
To sanitize data formatting, we can use the built-in `preg_replace()` function
```php
$contacts = ["Susan" => "5551236666", "Alex" => "7779991717", "Lily" => "8181117777"];  
$message = "";
$validation_error = "* Please enter a 10-digit North American phone number.";
$name = "";
$number = "";

 if ($_SERVER["REQUEST_METHOD"] == "POST") {
   $name = $_POST["name"];
   $number  = $_POST["number"];
   // Write your code here:
   if (strlen($number)<30){
     $formatted_number = preg_replace("/[^0-9]/", "", $number);
     if (strlen($formatted_number)===10){
       $contacts[$name] = $formatted_number;
       $message = "Thanks ${name}, we'll be in touch.";
     } else {
       $message = $validation_error;
     } 
   } else {
     $message = $validation_error;
   }
};
?>

<html>
	<body>
  <h3>Contact Form:</h3>
		<form method="post" action="">
			Name:
			<br>
  		<input type="text" name="name" value="<?= $name;?>">
 			<br><br>
  		Phone Number:
  		<br>
  		<input type="text" name="number" value="<?= $number;?>">
  		<br><br> 
  		<input type="submit" value="Submit">
		</form>
		<div id="form-output">
			<p id="response"><?= $message?></p>
    </div>
	</body>
</html>

```
The above code will output:
![img](/image/contactform.png)

   15.6 Rerouting  
If the user has submitted a valid form, `header()` function can be used to perform redirects.
```php
if (/* Is the submission data validated? */) {
  header("Location: https://www.best-puppy-pix.com/");
  exit;
}
```


16. Classes and Object  
>A class is a blueprint.
>Once the class is defined, specific instances(`Object`) can be created.
```php
<?php

class Beverage {
  public $color, $opacity, $temperature;
}
```


16.1 In PHP, objects are instantiated using the `new` keyword followed by the class name and parentheses.
We interact with an object’s properties using the object operator (`->`) followed by the name of the property (without the dollar sign, `$`).
>Create an instance of this class and assign it to the variable `$tea`.
>Set the temperature of the object to `hot`.
>Print the value of the temperature property of `$tea`.
```php
$tea = new Beverage();
$tea->temperature = "hot";

echo $tea->temperature;

```

16.2 Define class method  
Methods are defined with the same syntax we use when declaring functions. Methods are accessed in a similar fashion to properties, using the object operator (`->`), but in order to invoke them, use parentheses at the end:  
`$my_object->classMethod();`
>Add `getInfo` method to the `Beverage` class, it should return statement about the beverage with tempurature and color.
>Print the result of calling `getInfo` on the object.
```php
<?php
class Beverage {
  public $temperature, $color, $opacity;
  function getInfo() {
    return "This beverage is $this->temperature and $this->color.";
  }
}

$soda = new Beverage();
$soda->color = "black";
$soda->temperature = "cold";

echo $soda->getInfo();
```
16.3 Constructor Method  
This method is automatically called when an object is instantiated. A constructor method is defined with the special method name `__construct`.
If we wanted to initialize the `deserves_love` property assigned to `TRUE` for every instance of the `Pet` class, we could use the following constructor:
```php
class Pet {
  public $deserves_love;
  function __construct() {
    $this->deserves_love = TRUE;
  }
}
$my_dog = new Pet();
if ($my_dog->deserves_love){
  echo "I love you!";
}
// Prints: I love you!
```
Constructors can also have parameters. These correspond to arguments passed in when using the `new` keyword. For example, maybe we want to allow for setting the `name` of the `Pet` on instantiation

```php
class Pet {
  public $name;
  function __construct($name) {
    $this->name = $name;
  }
} 
$dog = new Pet("Lassie");
echo $dog->name; // Prints: Lassie
```

```php
<?php
class Beverage {
  public $temperature, $color, $opacity;

  function getInfo() {
    return "This beverage is $this->temperature and $this->color.";
  }
  function __construct($temperature, $color){
    $this->temperature = $temperature;
    $this->color = $color;
  }
}

// Object instantiating
$coke = new Beverage("cold", "black");

echo $coke->getInfo();

// Prints: This beverage is cold and black.
```
16.4 Inheritance  
To define a class that inherits from another, we use the keyword extends:
```php
class ChildClass extends ParentClass {

}
```
Define a Dog class that extends our Pet class. Each Dog instance will have an additional method called bark():  
```php
class Dog extends Pet {
  function bark() {
    return "woof";
  }
}
```
Now, objects of class `Dog` can `bark`, but objects of `Pet` cannot.  
16.5 Overloading Methods  
Sometimes, we want to change how methods behave for subclasses from the original parent definition. This is called overloading a method. To do this, define a new method within the subclass with the same name as the parent method. 
```php
<?php
class Beverage {
  public $temperature;
  
  function getInfo() {
    return "This beverage is $this->temperature.";
  }
}

class Milk extends Beverage {
  function __construct() {
    $this->temperature = "cold";
  }
  function getInfo(){
    return parent::getInfo() . " I like my milk this way.";
  }
  
}
$milk = new Milk();
echo $milk->getInfo(); //Prints: This beverage is cold. I like my milk this way.
```

16.6 Getters and Setters  
The concept of only accessing properties through methods is commonly referred to as using getters and setters.  
```php
class Pet {
  private $name;
  function setName($name) {
    $this->name = $name;
  }
  function getName() {
    return $this->name;
  }
}
```
```php
<?php
class Beverage {
  private $color;
  // Add a methond called setColor that sets the color property.
  // And the store the color as lowercase.
  function setColor($color) {
    $this->color = strtolower($color);
  }
  //Add a method call getColor that returns the value of the color property.
  function getColor() {
    return $this->color;
  }
}

$soda = new Beverage();
```

16.7 Static Members  
Instantiating objects is the most common way to use classes and is also the most in-line with OOP principles. 
Sometimes though, it can be useful to group a set of utility functions and variables together into a single class. 
Since these don’t change for every instance, we don’t need to instantiate them. 
We can use them statically.
```php
<?php
class AdamsUtils {
  public static $the_answer = 42;
  public static function addTowel($string) {
    return $string . " and a towel.";
  }
}

$items = "I brought apples";
echo AdamsUtils::$the_answer;
echo "\n";
echo AdamsUtils::addTowel($items);

//Prints:
42
I brought apples and a towel.
```

### Reference 
1. [PHP cheatsheet](https://www.codecademy.com/learn/learn-php/modules/classes-and-objects-in-php/cheatsheet)