+++
description = "Behavioural Driven Development"
title = "Bdd"
date = 2020-07-15T10:58:32+08:00
tags = ["BDD", "php"]
author = "Ken Cho"

+++
### What is Behavior Driven Development?
>Behavior Driven Development (BDD) is a branch of Test Driven Development (TDD).

>BDD uses human-readable descriptions of software user requirements as the basis for software tests.

### Introduction of BDD from Konstantin Kudryashov, the creator of Behat
[YouTube](https://youtu.be/njcHzGYv7nI)

### What is gherkin language?
>Gherkin is a Business Readable, Domain Specific Language created specifically for behavior descriptions.
>Gherkin is a whitespace-oriented language that uses indentation to define structure.  

Here is an example of gherkin:
```gherkin
Feature: Some terse yet descriptive text of what is desired
  In order to realize a named business value
  As an explicit system actor
  I want to gain some beneficial outcome which furthers the goal

  Additional text...

  Scenario: Some determinable business situation
    Given some precondition
    And some other precondition
    When some action by the actor
    And some other action
    And yet another action
    Then some testable outcome is achieved
    And something else we can check happens too
```
The `Feature` are not parsed by Behat and don’t have a required structure.

### Given-When-Then combo, [source](https://docs.behat.org/en/latest/user_guide/writing_scenarios.html)
Example 1
```gherkin
Scenario: Multiple Givens
  Given one thing
  Given another thing
  Given yet another thing
  When I open my eyes
  Then I see something
  Then I don't see something else
```

Example 2
```gherkin
Scenario: Multiple Givens
  Given one thing
  And another thing
  And yet another thing
  When I open my eyes
  Then I see something
  But I don't see something else
```

### Scenario Outline can reduce tedious and repetitive scenario setting by using a template with placeholders
```gherkin
Scenario Outline: Eating
  Given there are <start> cucumbers
  When I eat <eat> cucumbers
  Then I should have <left> cucumbers

  Examples:
    | start | eat | left |
    |  12   |  5  |  7   |
    |  20   |  5  |  15  |
```

### Don’t confuse tables with scenario outlines
```gherkin
Scenario:
  Given the following people exist:
    | name  | email           | phone |
    | Aslak | aslak@email.com | 123   |
    | Joe   | joe@email.com   | 234   |
    | Bryan | bryan@email.org | 456   |
```
>Outlines declare multiple different values for the same scenario, while tables are used to expect a set of data.



### Reference
1. [Behat](https://docs.behat.org/en/latest/)
2. Using Behat in PhpStorm, [here](https://blog.jetbrains.com/phpstorm/2014/07/using-behat-in-phpstorm/), [tutorial](https://www.jetbrains.com/help/phpstorm/using-behat-framework.html?_ga=2.3096944.1184181343.1594803417-1683120704.1594803417)
3. BDD in Codeception, [here](https://codeception.com/docs/07-BDD)
4. 


