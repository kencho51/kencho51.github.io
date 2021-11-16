+++
description = "Commands for running and testing Local gigaDB"
title = "Commands use to run gigadb"
date = 2020-07-24T16:03:12+08:00
tags = ["gigadb", "yii2", "docker", "psql"]
author = "Ken Cho"

+++  
### To start a local gigaDB server
`docker-compose run --rm webapp`  
[Link](http://gigadb.gigasciencejournal.com:9170/) to test if the web page is up
 
### If there are some build errors
1. Rebuild and up the webapp containers again.  
`docker-compose run --rm webapp`  
2. If not work, `restart` the docker container app and rebuild the containers.  
3. If not work, check if psql, `gigadb`, database is presented in `~/.containers/-data` and remove it.  
`rm -rf ~/.containers-data/gigadb`
4. Run `docker-compose run --rm webapp` again to rebuild the containers.  

### How to remove images
1. List all images  
`docker images -a`  
2. Remove all images  
`docker rmi $(docker images -a -q)`  

### How to remove container
1. List all containers  
`docker ps -a`  
2. Stop the containers  
`docker stop $(docker ps -a -q)`    
2. Remove stopped containers  
`docker rm $(docker ps -a -q)`  
[source](https://linuxize.com/post/how-to-remove-docker-images-containers-volumes-and-networks/)  
[digital ocean](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)  

### How to run a functional test in a docker environment for testing?
1. Write unit test script and place in `protected/tests/functional-test` folder.
2. Change the `unit_functional` script
`./bin/phpunit protected/tests/functional-test  --verbose --configuration protected/tests/phpunit.xml --no-coverage`
3. Run specific unit test:  
`docker-compose run --rm test ./tests/unit_functional`
4. Output will be like this:
```bash
PHPUnit 5.7.27 by Sebastian Bergmann and contributors.

Runtime:       PHP 7.1.30 with Xdebug 2.9.6
Configuration: /var/www/protected/tests/phpunit.xml

...                                                                 3 / 3 (100%)

Time: 7.15 seconds, Memory: 14.00MB

OK (3 tests, 7 assertions)
```

### How to run a functional test on a single file in docker environment?
1. docker oneliner  
`docker-compose run --rm test ./bin/phpunit --testsuite functional --bootstrap protected/tests/bootstrap.php --verbose --configuration protected/tests/phpunit.xml --no-coverage protected/tests/functional/AdminSiteAccessTest.php`  
2. Or go into docker bash and run `phpunit`  
`docker-compose run --rm test bash`  
`root@45a46a8441d3:/var/www# ./bin/phpunit --testsuite functional --bootstrap protected/tests/bootstrap.php --verbose --configuration protected/tests/phpunit.xml --no-coverage protected/tests/functional/AdminSiteAccessTest.php`  
```bash
root@45a46a8441d3:/var/www# ./bin/phpunit --testsuite functional --bootstrap protected/tests/bootstrap.php --verbose --configuration protected/tests/phpunit.xml --no-coverage protected/tests/functional/AdminSiteAccessTest.php

PHPUnit 5.7.27 by Sebastian Bergmann and contributors.

Runtime:       PHP 7.1.30 with Xdebug 2.9.6
Configuration: /var/www/protected/tests/phpunit.xml

...                                                                 3 / 3 (100%)

Time: 4.18 seconds, Memory: 14.00MB

OK (3 tests, 7 assertions)
```

### How to run a Behat test in a docker environment for testing
1. Update the `scenario syntax` specific *.feature file, like:  
```gherkin
@ok @files
	Scenario: Files - Call to Actions
		Given I am not logged in to Gigadb web site
		When I go to "/dataset/101001"
		And I follow "Files"
		Then I should see a link "(FTP site)" to "ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/" with title "FTP site"
		Then I should see a button "Table Settings"
```
2. Check if related functions in `features/bootstrap/*.php` needed to be updated, eg:
```php
public function iShouldSeeTabWithTable($arg1, TableNode $table)
    {
        if ("Funding" == $arg1) {
            $this->minkContext->getSession()->getPage()->clickLink($arg1);
            //| Funding body                    | Awardee           | Award ID      | Comments |
            foreach($table as $row) {
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Funding body'])
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Awardee'])
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Award ID'])
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Comments'])
                );
            }
        }
        elseif("Files" == $arg1) {
            //| File name                                        | Sample ID  | Data Type         | File Format | Size      | Release date | link |
            foreach($table as $row) {
                $link = $row['link'];
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['File name']), "File name match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Sample ID']), "Sample ID match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Data Type']), "Data Type match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['File Format']), "File Format match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Size']), "Size match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Release date']), "Release date match"
                );
                if ($link) {
                    $this->minkContext->assertSession()->elementExists('css',"a.download-btn[href='$link']");
                }
            }
        }
        elseif("Sample" == $arg1) {
            //| Sample ID  | Common Name  | Scientific Name         | Sample Attributes                                                                                                                   | Taxonomic ID | Genbank Name |
            foreach($table as $row) {
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Sample ID']), "Sample ID match"
                );
                if($row['Common Name']) {
                    PHPUnit_Framework_Assert::assertTrue(
                        $this->minkContext->getSession()->getPage()->hasContent($row['Common Name']), "Common Name match"
                    );
                }
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Scientific Name']), "Scientific Name match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Sample Attributes']), "Sample Attributes match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Taxonomic ID']), "Taxonomic ID match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Genbank Name']), "Genbank Name match"
                );
            }
        }
        else {
            PHPUnit_Framework_Assert::fail("Unknown type of tab");
        }
    }
```
3. Assign @wip tag to the working scenario in .feature file, this can smooth the running of behat test.  
```gherkin
@wip @files
	Scenario: Files - Call to Actions
		Given I am not logged in to Gigadb web site
		When I go to "/dataset/101001"
```

4. Run the Behat test command on specific scenario.  
`docker-compose run --rm test bin/behat -vv --stop-on-failure --tags @wip`

5. Or can first shell into test container and then run the command:  
```bash
$ docker-compose run --rm test bash
root@2f0dd679a934:/var/www# bin/behat --tags @wip
```

### How to run a behat test with database set up
1. In `all_and_coverage` file  
```bash
#!/usr/bin/env bash

set -e -u

./tests/acceptance
#./tests/unit_functional
#./tests/coverage
```
2. In `acceptance` file  
```bash
#!/usr/bin/env bash

set -e -u -x

echo "About to run  automated tests..."

echo "Loading environment..."
set -a
source /var/www/.env
source /var/www/.secrets
set +a

if [ "$GIGADB_ENV" == "dev" ];then
	echo "First, backup the main database..."
	exec 3>&1
	exec 1> /dev/null
	pg_dump $GIGADB_DB -U $GIGADB_USER -h $GIGADB_HOST -F custom  -f /var/www/sql/before-run.pgdmp
	exec 1>&3
fi

echo "Running acceptance tests"
if [[ "$GIGADB_ENV" == "dev" ]];then
#	bin/behat --tags "@ok&&~@facebook&&~orcid" -v --stop-on-failure
    bin/behat --tags "@wip" -v --stop-on-failure
else
	# we are on CI with remote runner, affilate login tests don't work becasause Google and Twitter block it
	bin/behat --tags "@ok&&~@affiliate-login&&~@javascript" -v --stop-on-failure
fi

echo "...all automated tests have run"

if [ "$GIGADB_ENV" == "dev" ];then
	echo "Lastly, restoring the main database..."
	exec 3>&1
	exec 1> /dev/null
	pg_restore -h $GIGADB_HOST  -U $GIGADB_USER -d $GIGADB_DB --clean --no-owner -v /var/www/sql/before-run.pgdmp
	exec 1>&3
fi
```
3. Run the behat test  
`docker-compose run --rm test`  

### How to connect postgreSQL in PhpStorm
1. Click Database top right of PhpStorm screen.  
2. Data Source chose `postgreSQL` and input following information:  
    - Host: localhost
    - Port: 54321
    - User: gigadb
    - pw:
    - URL: `jdbc:postgresql://localhost:54321/gigadb`

### How to restore gigadb database for admin log in
1. Log in psql container  
`PGPASSWORD=vagrant psql -h localhost -p 54321 -U gigadb postgres`  
2. Terminate runing `gigadb`  
```sql
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'gigadb';
```
3. Drop gigadb  
```sql
drop DATABASE gigadb;
```
4.Create gigadb  
```sql
create DATABASE gigadb;
``` 
5. Restore `gigadb` from `bootstrap.sql`  
`kencho@MacBook-Pro:% psql -h localhost -U gigadb -p 54321 gigadb < ops/configuration/postgresql-conf/bootstrap.sql`

### How to retrieve production-like database
1. Log in psql container  
`PGPASSWORD=vagrant psql -h localhost -p 54321 -U gigadb postgres`  
2. Create database `production_like`  
`postgres=# create database production_like;`  
3. Restore production-like database  
`kencho@MacBook-Pro:% pg_restore -h localhost -p 54321 -U gigadb -d production_like --clean --no-owner -v sql/production_like.pgdmp`  

### How to convert production database into different version, issue [#731](https://github.com/gigascience/gigadb-website/issues/731), [PR190](https://github.com/rija/gigadb-website/pull/190)

1. First version, which involves too many manipulation of the database, and the binary backup has been indexed which are specific to a database server 
```bash
#!/usr/bin/env bash

# Load environment variables
source ./.env
source ./.secrets
  
latest=$(date -v-1d +"%Y%m%d")
# docker-compose executable
if [[ $GIGADB_ENV != "dev" && $GIGADB_ENV != "CI" ]];then
	DOCKER_COMPOSE="docker-compose --tlsverify -H=$REMOTE_DOCKER_HOST -f ops/deployment/docker-compose.production-envs.yml"
else
 DOCKER_COMPOSE="docker-compose"
fi

echo "Spin up the database container"
docker-compose up -d --build database
 
echo "Go into docker container and store the postgreSQL version"
version=$($DOCKER_COMPOSE run --rm test bash -c "psql --version | cut -d' ' -f 3 | tr -d '\n'")
  
echo "Download the production database using file-url-updater"
cd gigadb/app/tools/files-url-updater/
docker-compose run --rm updater ./yii dataset-files/download-restore-backup --latest --norestore
cd ../../../../
echo "Create production database for the version upgrade"
$DOCKER_COMPOSE run --rm test bash -c "psql -h database -U gigadb -c 'create database gigadbv3_production'"

echo "Load the production database into PostgreSQL server"
$DOCKER_COMPOSE run --rm test bash -c "PGPASSWORD=$GIGADB_PASSWORD pg_restore -v -U gigadb -h database -p 5432 -d gigadbv3_production /var/www/gigadb/app/tools/files-url-updater/sql/gigadbv3_${latest}.backup"

echo "Create folder for database dump if not existed"
if [[ ! -d sql/psql-v96 ]];then
mkdir sql/psql-v96
fi

echo "Dump the production database"
#$DOCKER_COMPOSE run --rm test bash -c "PGPASSWORD=$GIGADB_PASSWORD pg_dump -v -U gigadb -h database -p 5432 -d gigadbv3_production -f /var/www/sql/psql-v96/gigadbv3_${latest}_${version}.sql"
$DOCKER_COMPOSE run --rm test bash -c "PGPASSWORD=$GIGADB_PASSWORD pg_dump -v -U gigadb -h database -p 5432 -Fc -d gigadbv3_production -f /var/www/sql/psql-v96/gigadbv3_${latest}_${version}.pgdmp"

if [[ -f sql/psql-v96/gigadbv3_"$latest"_"$version".pgdmp ]];then
echo "Finished convert production database to postgreSQL version" "$version"
else
echo "No upgraded database dump found, conversion fail!"
fi

echo "Load the upgraded dump into PostgreSQL server"
$DOCKER_COMPOSE run --rm test bash -c "PGPASSWORD=$GIGADB_PASSWORD pg_restore -v -U gigadb -h database -p 5432 --clean -d gigadbv3_production /var/www/sql/psql-v96/gigadbv3_${latest}_${version}.pgdmp"

if [[ $? -eq 0 ]];then
echo "The upgraded dump could be restored!"
else
echo "The upgraded dump could not be restored, please check!"
fi

echo "Drop production database after upgraded dump has been restored"
$DOCKER_COMPOSE run --rm test bash -c "psql -h database -U gigadb -c 'drop database gigadbv3_production'"

echo "Stop database container"
docker stop deployment_database_1
```

2. Second version, make use of  `files-url-updater` to restore the production database and dump it in text format. 
```bash
#!/usr/bin/env bash

# Load environment variables
source ./.env
source ./.secrets

latest=$(date -v-1d +"%Y%m%d")

# docker-compose executable
if [[ $GIGADB_ENV != "dev" && $GIGADB_ENV != "CI" ]];then
	DOCKER_COMPOSE="docker-compose --tlsverify -H=$REMOTE_DOCKER_HOST -f ops/deployment/docker-compose.production-envs.yml"
else
	DOCKER_COMPOSE="docker-compose"
fi

echo "Download and load the production database in to postgreSQL server using file-url-updater"
cd gigadb/app/tools/files-url-updater/
version=$($DOCKER_COMPOSE run --rm pg9_3 bash -c "psql --version | cut -d' ' -f 3 | tr -d '\n'")
$DOCKER_COMPOSE run --rm updater ./yii dataset-files/download-restore-backup --latest

echo "Export production data as text (only the strictly necessary data is exported)"
$DOCKER_COMPOSE run --rm updater pg_dump -h pg9_3 -U gigadb  --clean --create --schema=public --no-privileges --no-tablespaces gigadb -f sql/gigadbv3_"$latest"_v"$version".backup

if [[ $? -eq 0  && -f sql/gigadbv3_"$latest"_v"$version".backup ]];then
  echo "Finished convert production database to postgreSQL version" "$version"
else
  echo "No upgraded database dump found, conversion fail!"
fi
```


### Reference
1. [Run specific behat test](https://github.com/gigascience/gigadb-website/issues/356)
2. [gigaDB github](https://github.com/gigascience/gigadb-website/tree/develop)


[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)


