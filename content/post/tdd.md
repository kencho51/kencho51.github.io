+++
description = "Test Driving Development"
title = "What is Tdd?"
date = 2020-06-10T14:28:31+08:00
tags = ["TDD", ]
author = "Ken Cho"

+++
### What is TDD?
![img](/image/tdd.gif)

>Before writing any code that adds new functionality to an application, the developer first writes an automated test describing how the new code should behave, and watches it turn red (fail to pass). 

>They then write the code to the specification, and the test turns green (it passes).

>Finally, the developer takes a little time to make sure that the code just written is as clean as possible (refactoring).

![img](/image/red-green-refactor.png)
The red, green, refactor approach helps developers compartmentalize their focus into three phases:
   - Red — think about what you want to develop
   - Green — think about how to make your tests pass
   - Refactor — think about how to improve your existing implementation
### Advantages o TDD
1. TDD helps to prevent bugs  
2. Self Explanatory code  
3. Advoid he bugger debugger problem  
>When talking tech about software development, there are two main types of testing that can be integrated: functional and non-functional.

![img](/image/testing.jpeg)

>Unit and Integration tests to be performed by developers before handing out builds to testers

>User acceptance testing to be performed by the testers

>Performance testing and UI testing should be done by both

4. You can forecast troubles  
>The benefit of a comprehensive test suite is that it alerts you to changes early.
5. Save Money
![img](/image/money.png)
When code is complicated, it gets much harder to get anything done — one little change over here can result in a big problem over there. 
When following TDD, developers can make changes with confidence and your QA team will catch fewer regressions. 
In development speak, `time saved is equal to money earned`.

6. Invest the saved time in innovations and research

7. TDD Helps You Avoid Scope Creep
>The nightmare of any project manager is scope creep — any unexpected growth in the scope of work which leads to delays in project delivery.

>Scope creep can happen for various reasons: poorly defined tasks, misinterpretation of project requirements, lack of documentation, and so on. There are many methods aimed at mitigating scope creep, and `TDD` is one of them.

### How to perform TDD test
![img](/image/tddtest.png)



### Acceptance TDD and developer TDD
When you first go to implement a new feature, the first question that you ask is whether the existing design is the best design possible that enables you to implement that functionality. 
If so, you proceed via a `TFD`, the first development, approach. If not, you refactor it locally to change the portion of the design affected by the new feature, enabling you to add that feature as easy as possible. 
As a result you will always be improving the quality of your design, thereby making it easier to work with in the future.
![img](/image/acceptance.jpg)

1. Acceptance TDD:  
With ATDD you write a single acceptance test. This test fulfills the requirement of the specification or satisfies the behavior of the system. After that write just enough production/functionality code to fulfill that acceptance test. Acceptance test focuses on the overall behavior of the system. ATDD also was known as Behavioral Driven Development (BDD).    
2. Developer TDD:  
With Developer TDD you write single developer test i.e. unit test and then just enough production code to fulfill that test. The unit test focuses on every small functionality of the system. Developer TDD is simply called as TDD.  
The main goal of ATDD and TDD is to specify detailed, executable requirements for your solution on a just in time (JIT) basis. JIT means taking only those requirements in consideration that are needed in the system. So increase efficiency.  


### Example of TDD in [defining a class](https://www.guru99.com/test-driven-development.html) `password`

### Test stages
1. Setup
- Create sample data  
- Decide on inputs  
2. Execution  
- Call the code  
3. Assertions  
- Confirm expected output  

### TDD and The Terminator
This [video](https://www.youtube.com/watch?v=EcoIjf3RABI) shows how to implement a TDD.


### TDD in practice
[The site](http://sites.google.com/site/tddproblems/all-problems-1)offers a good variety of problems that are particularly suitable for resolution using the TDD approach.
[Source](https://hackernoon.com/introduction-to-test-driven-development-tdd-61a13bc92d92)


### Reference
1. [Test-driven development might seem like twice the work](https://www.freecodecamp.org/news/isnt-tdd-test-driven-development-twice-the-work-why-should-you-care-4ddcabeb3df9/)
2. [Introduction to TDD](http://agiledata.org/essays/tdd.html)
3. [What is Test Driven Development (TDD)? Tutorial with Example](https://www.guru99.com/test-driven-development.html)
4. What is TDD? [YouTube](https://www.youtube.com/watch?v=-7E00lFE89s)
5. TDD and The Terminator [YouTube](https://www.youtube.com/watch?v=EcoIjf3RABI)
6. [Test Driven Development: what it is, and what it is not.](https://www.freecodecamp.org/news/test-driven-development-what-it-is-and-what-it-is-not-41fa6bca02a2/)
7. PHP Test Driven Development Part 1: Introduction[medium](https://medium.com/@sameernyaupane/php-test-driven-development-part-1-introduction-5483362d79b5)
8. [Red-Green-Refactor](https://www.codecademy.com/articles/tdd-red-green-refactor)