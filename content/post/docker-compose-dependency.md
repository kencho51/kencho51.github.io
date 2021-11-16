+++
description = "Docker Compose Dependency"
title = "To resolve XDebug dependency problem"
date = 2021-01-07T15:04:22+08:00
tags = ["Docker", "Docker compose"]
author = "Ken Cho"

+++  
### Problem
```bash
 ---> Running in 4c7fe5b9cf5e
pecl/xdebug requires PHP (version >= 7.2.0, version <= 8.0.99), installed version is 7.1.30
No valid packages found
install failed
ERROR: Service 'test' failed to build : The command '/bin/sh -c if [ ${INSTALL_XDEBUG} = true ]; then   if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then     pecl install xdebug-2.5.5;   else     pecl install xdebug;   fi &&   docker-php-ext-enable xdebug ;fi' returned a non-zero code: 1
```

### Effect
The `docker-compose run --rm test` cannot be run. Then the `test` service cannot be built.

### Solution
1. Try 1   
Change the PHP version from `7.1` to `7.3` in `.env`:
```dotenv
PHP_VERSION=7.3
```
But here is the error message:
```bash
Fatal error: Composer detected issues in your platform: Your Composer dependencies require a PHP version ">= 7.3.0". You are running 7.1.30. in /var/www/vendor/composer/platform_check.php on line 24
```

So, the `PHP_VERSION` has to revert to `7.1`.  

2. Try 2  
After reading the `XDebug` [release note](https://pecl.php.net/package/xdebug), the latest `XDebug` requires `7.2.0 < PHP version < 8.0.99`.
So, hardcoded the `XDebug` version in `Dockerfile`:
```dockerfile
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
  # Install the xdebug extension
  if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then \
    pecl install xdebug-2.5.5; \
  else \
    pecl install xdebug-2.9.8; \
  fi && \
  docker-php-ext-enable xdebug \
;fi
```

### Result
Run `docker-compose run --rm test` again, problem solved.


### Reference


[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

