+++
description = "PHP coding standards"
title = "PHP standards"
date = 2020-06-17T11:35:32+08:00
tags = ["PHP", "PSR-1", "PSR-2"]
author = "Ken Cho"
+++

### What is PSR?
>PSR is a standard established by PHP-FIG(PHP Framework Interop Group).

>PSR consists of several standards such as PSR-1, PSR-2 and PSR-4. 

>PSR-0 and PSR-4 are coding standards for PHP’s autoloaders,
PSR-1 and PSR-2 are basic coding standards. 

>PHP code MUST use only UTF-8 without BOM(Byte Order Mark).

### PSR-1 Basic Coding Standard, defines basic parts of PHP coding
- Only `<?php ?>` or `<?= ?>` are allowed for PHP tags
- Files must be in UTF-8 without BOM(Byte Order Mark)
- Namespaces and class names must follow the standards in PSR-0 and PSR-4
- Class names must be defined in `UpperCamelCase`
- Class variables must be defined in `UPPER_SNAKE_CASE`
- Method names must be defined in `camelCase`
```php
// defining normal properties in camelCase
// defining static properties in UpperCamelCase
// Class constants MUST be declared in all upper case with underscore separators
class Something
{
    public $normalPropterty;
    public static $StaticProperty;
    const VERSION = '1.0';
    const DATE_APPROVED = '2000-12-01';
}

```

### PSR-2 Coding style Guide, an extension of PSR-1
- You must follow PSR-1 coding standards
- 4 spaces must be used for indents. Using tabs is not allowed
- There is no limit to line length, but it should be under 120 characters, and best if under 80
- You must put a newline before curly braces for classes and methods
- Methods and properties must be defined with `abstract/final` first, followed with `public/protected`, and finally `static`.
- You must not put a newline before curly braces in conditional statements
- You must not put any spaces before ( and ) in conditional statements

### PSR-12: Extended Coding Style, is now recommended for PSR-2.
- .php files must use Unix LF(linefeed) line `\n` ending only.
- .php files must end with a non-blank line.
- closing `?>` tag must be omitted from .php files containing only php.
- Compound namespaces with a depth of more than two MUST NOT be used.  
`namespace SubnamespaceOne\Anothernamespace\ClassA;`  
```php
<?php

/**
 * This file contains an example of coding styles.
 */


declare(strict_types=1);
// MUST be one blank line after the namespace declaration
namespace Vendor\Package;

// MUST be one blank line after the block of use declarations.
use Vendor\Package\{ClassA as A, ClassB, ClassC as C};
use Vendor\Package\SomeNamespace\ClassD as D;
use function Vendor\Package\{functionA, functionB, functionC};
use const Vendor\Package\{ConstantA, ConstantB, ConstantC};
use Vendor\Package\FirstTrait;


// Opening braces for classes MUST go on the next line, and closing braces MUST go on the next line after the body.
class Foo extends Bar implements FooInterface
{
    // use keyword used inside the classes to implement traits MUST be declared on the next line after the opening brace.
    use FirstTrait;
    // Opening braces for methods MUST go on the next line, and closing braces MUST go on the next line after the body.
    public function sampleFunction(int $a, int $b = null): array
    {
        if ($a === $b) {
            bar();
        } elseif ($a > $b) {
            $foo->bar($arg1);
        } else {
            BazClass::bar($arg2, $arg3);
        }
    }

    // abstract and final MUST be declared before the visibility; 
    // static MUST be declared after the visibility.
    final public static function bar()
    {
        // method body
    }
    
    

}
```


### Reference
1. [PSR-1](https://www.php-fig.org/psr/psr-1/)
2. [PSR-2](https://www.php-fig.org/psr/psr-2/)
3. [PSR-12](https://www.php-fig.org/psr/psr-12/)
4. [5 PHP coding statands](https://blog.sideci.com/5-php-coding-standards-you-will-love-and-how-to-use-them-adf6a4855696)
5. [Code Sytle Guide](https://phptherightway.com/#code_style_guide)