+++
description = "Tool to detect and correct PHP coding style"
title = "PHP_CodeSniffer"
date = 2020-07-07T14:28:56+08:00
tags = ["PHP", "PHP_CodeSniffer"]
author = "Ken Cho"

+++
### What is PHP_CodeSniffer?
PHP_CodeSniffer is a set of two PHP scripts:
1. `phpcs` script that tokenizes PHP, JavaScript and CSS files to detect violations of a defined coding standard.
2. `phpcbf` script to automatically correct coding standard violations.

### Installation 
Follow [here](https://github.com/squizlabs/PHP_CodeSniffer)


### Usage
1. Checking files and folders  
`vendor/bin/phpcs /path/to/code`

2. Printing summary report  
`vendor/bin/phpcs --report=summary /path/to/code`  

3. Specifying a Coding Standard  
`vendor/bin/phpcs --standard=PEAR /path/to/code/myfile.php`  

4. List all installed coding standards  
`vendor/bin/phpcs -i`  
eg.The installed coding standards are PEAR, PSR1, PSR12, PSR2, Squiz and Zen  

### Reporting
1. Example `phpcs` output:
```bash
% vendor/bin/phpcs --standard=PSR2 -s tests/functional/AdminSiteAccessTest.php

FILE: /Volumes/kencho/learning_stuff/test/yii2/basic/tests/functional/AdminSiteAccessTest.php
-------------------------------------------------------------------------------------------------------------------------------------------------------
FOUND 7 ERRORS AND 1 WARNING AFFECTING 5 LINES
-------------------------------------------------------------------------------------------------------------------------------------------------------
  7 | ERROR   | [ ] Each class must be in a namespace of at least one level (a top-level vendor name)
    |         |     (PSR1.Classes.ClassDeclaration.MissingNamespace)
 21 | ERROR   | [x] No space found after comma in argument list (Generic.Functions.FunctionCallArgumentSpacing.NoSpaceAfterComma)
 21 | ERROR   | [x] No space found after comma in argument list (Generic.Functions.FunctionCallArgumentSpacing.NoSpaceAfterComma)
 35 | ERROR   | [x] No space found after comma in argument list (Generic.Functions.FunctionCallArgumentSpacing.NoSpaceAfterComma)
 35 | ERROR   | [x] No space found after comma in argument list (Generic.Functions.FunctionCallArgumentSpacing.NoSpaceAfterComma)
 54 | WARNING | [ ] Line exceeds 120 characters; contains 121 characters (Generic.Files.LineLength.TooLong)
 62 | ERROR   | [x] A closing tag is not permitted at the end of a PHP file (PSR2.Files.ClosingTag.NotAllowed)
 62 | ERROR   | [x] Expected 1 newline at end of file; 0 found (PSR2.Files.EndFileNewline.NoneFound)
-------------------------------------------------------------------------------------------------------------------------------------------------------
PHPCBF CAN FIX THE 6 MARKED SNIFF VIOLATIONS AUTOMATICALLY
-------------------------------------------------------------------------------------------------------------------------------------------------------

Time: 46ms; Memory: 6MB
```

2. Printing a code report  
```bash
% vendor/bin/phpcs --standard=PSR2 -s --report=code  tests/functional/AdminSiteAccessTest.php

FILE: /Volumes/kencho/learning_stuff/test/yii2/basic/tests/functional/AdminSiteAccessTest.php
--------------------------------------------------------------------------------------------------------------------------------------------------------
FOUND 7 ERRORS AND 1 WARNING AFFECTING 5 LINES
--------------------------------------------------------------------------------------------------------------------------------------------------------
LINE  7: ERROR   [ ] Each class must be in a namespace of at least one level (a top-level vendor name) (PSR1.Classes.ClassDeclaration.MissingNamespace)
--------------------------------------------------------------------------------------------------------------------------------------------------------
    5:  ·*/
    6:  
>>  7:  class·AdminSiteAccessTest·extends·FunctionalTesting
    8:  {
    9:  ····use·BrowserSignInSteps;
--------------------------------------------------------------------------------------------------------------------------------------------------------
LINE 21: ERROR   [x] No space found after comma in argument list (Generic.Functions.FunctionCallArgumentSpacing.NoSpaceAfterComma)
LINE 21: ERROR   [x] No space found after comma in argument list (Generic.Functions.FunctionCallArgumentSpacing.NoSpaceAfterComma)
--------------------------------------------------------------------------------------------------------------------------------------------------------
   19:  ····public·function·testItShouldBeDisplayedToUsersWithAdminRole()
   20:  ····{
>> 21:  ········$this->loginToWebSiteWithSessionAndCredentialsThenAssert("admin@gigadb.org","gigadb","Joe's·GigaDB·Page");
   22:  ········$url·=·"http://gigadb.dev/site/admin";
   23:  ········$this->visitPageWithSessionAndUrlThenAssertContentHasOrNull($url,·"Administration·Page");
--------------------------------------------------------------------------------------------------------------------------------------------------------
LINE 35: ERROR   [x] No space found after comma in argument list (Generic.Functions.FunctionCallArgumentSpacing.NoSpaceAfterComma)
LINE 35: ERROR   [x] No space found after comma in argument list (Generic.Functions.FunctionCallArgumentSpacing.NoSpaceAfterComma)
--------------------------------------------------------------------------------------------------------------------------------------------------------
   33:  ····public·function·testItShouldNotBeDisplayedToUsersWithUserRole()
   34:  ····{
>> 35:  ········$this->loginToWebSiteWithSessionAndCredentialsThenAssert("user@gigadb.org","gigadb","John's·GigaDB·Page");
   36:  ········$url·=·"http://gigadb.dev/site/admin";
   37:  ········$this->visitPageWithSessionAndUrlThenAssertContentHasOrNull($url,·"Error·403");
--------------------------------------------------------------------------------------------------------------------------------------------------------
LINE 54: WARNING [ ] Line exceeds 120 characters; contains 121 characters (Generic.Files.LineLength.TooLong)
--------------------------------------------------------------------------------------------------------------------------------------------------------
   52:  ········//·To·confirm·User·has·been·re-directed·to·/site/login
   53:  ········$current_site·=·$this->getCurrentUrl();
>> 54:  ········$this->assertTrue($current_site·==·"http://gigadb.dev/site/login",·"The·current·site·has·not·been·re-directed.");
   55:  
   56:  ········$this->session->visit($url);
--------------------------------------------------------------------------------------------------------------------------------------------------------
LINE 62: ERROR   [x] A closing tag is not permitted at the end of a PHP file (PSR2.Files.ClosingTag.NotAllowed)
LINE 62: ERROR   [x] Expected 1 newline at end of file; 0 found (PSR2.Files.EndFileNewline.NoneFound)
--------------------------------------------------------------------------------------------------------------------------------------------------------
   60:  ····}
   61:  }
>> 62:  ?>
--------------------------------------------------------------------------------------------------------------------------------------------------------
PHPCBF CAN FIX THE 6 MARKED SNIFF VIOLATIONS AUTOMATICALLY
--------------------------------------------------------------------------------------------------------------------------------------------------------
Time: 44ms; Memory: 6MB

```

### Fixing Errors Automatically
1. Printing a Diff report
```bash
% vendor/bin/phpcs --standard=PSR2 -s --report=diff  tests/functional/AdminSiteAccessTest.php
--- tests/functional/AdminSiteAccessTest.php
+++ PHP_CodeSniffer
@@ -18,7 +18,7 @@
      */
     public function testItShouldBeDisplayedToUsersWithAdminRole()
     {
-        $this->loginToWebSiteWithSessionAndCredentialsThenAssert("admin@gigadb.org","gigadb","Joe's GigaDB Page");
+        $this->loginToWebSiteWithSessionAndCredentialsThenAssert("admin@gigadb.org", "gigadb", "Joe's GigaDB Page");
         $url = "http://gigadb.dev/site/admin";
         $this->visitPageWithSessionAndUrlThenAssertContentHasOrNull($url, "Administration Page");
     }
@@ -32,7 +32,7 @@
      */
     public function testItShouldNotBeDisplayedToUsersWithUserRole()
     {
-        $this->loginToWebSiteWithSessionAndCredentialsThenAssert("user@gigadb.org","gigadb","John's GigaDB Page");
+        $this->loginToWebSiteWithSessionAndCredentialsThenAssert("user@gigadb.org", "gigadb", "John's GigaDB Page");
         $url = "http://gigadb.dev/site/admin";
         $this->visitPageWithSessionAndUrlThenAssertContentHasOrNull($url, "Error 403");
     }
@@ -59,4 +59,3 @@
         $this->assertFalse(strpos($out, "Administration Page"), "Ordinary User can visit admin page.");
     }
 }
-?>
\ No newline at end of file
Time: 114ms; Memory: 6MB
```

2. Using the `phpcbf` to fix the style  
`vendor/bin/phpcbf /path/to/code --suffix=.fixed`

3. Viewing the Debug Information  
`vendor/bin/phpcs --standard=PSR2 -vv --report=diff  AdminSiteAccessTest.php`


### Reference
1. PHP_CodeSniffer, [github](https://github.com/squizlabs/PHP_CodeSniffer)



