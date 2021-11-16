+++
description = "Everything about PostgreSQL database"
title = "Postgresql"
date = 2020-06-09T10:25:23+08:00
tags = ["postgreSQL", "SQL", "database"]
author = "Ken Cho"

+++
### What is PostgreSQL?
![img](/image/postgresql_logo.png)
>PostgreSQL is an enterprise-class open source database management system. 
>It supports both SQL for relational and JSON for non-relational queries.
>PostgreSQL supports advanced data types and advance performance optimization.

### Key features
- Compatible with various platforms using all major languages and middleware
- It offers a most sophisticated locking mechanism
- Support for multi-version concurrency control
- Compliant with the ANSI SQL standard
- Full support for client-server network architecture
- Log-based and trigger-based replication SSL
- Standby server and high availability
- Object-oriented and ANSI-SQL2008 compatible
- Support for JSON allows linking with other data stores like NoSQL which act as a federated hub for polyglot databases

### MySQL vs PostgreSQL
| MySQL | PostgreSQL |
|:-------|:------------|
|The MySQL project has made its source code available under the terms of the GNU License, and other proprietary agreements.	| PostgreSQL is released under PostgreSQL License.|
|It's now owned by Oracle Corporation and offers several paid editions.	| It's free and open-source software. That means you will never need to pay anything for this service.|
|MySQL is ACID compliant only when using with NDB and InnoDB Cluster Storage engines. | PostgreSQL is completely ACID compliant.|
|MySQL performs well in OLAP and OLTP systems where only read speed is important.	| PostgreSQL performance works best in systems which demand the execution of complex queries.|
|MySQL is reliable and works well with BI (Business Intelligence) applications, which are difficult to read	| PostgreSQL works well with BI applications. However, it is more suited for Data Warehousing and data analysis applications which need fast read-write speeds.|

### Advantages
1. Can run dynamic websites and web apps.  
2. Write-ahead logging makes it a highly fault-tolerant database.
3. Source code is freely available under an open source license.
4. Supports geographic objects so you can use it for location-based services and geographic information systems.  
5. Supports geographic objects so it can be used as a geospatial data store for location-based services and geographic information systems.
6. Low maintenance administration for both embedded and enterprise use.

### Disadvantages
1. Changes made for speed improvement requires more work than MySQL as PostgreSQL focuses on compatibility.
2. Many open source apps support MySQL, but may not support PostgreSQL.
3. On performance metrics, it is slower than MySQL.

### Download and install
1. Download and install `postgrlSQL`  
`brew doctor`  
`brew update`  
`brew install postgresql`
2. Download and install `Pgcli`, for `Postgres with auto-completion and syntax highlighting.`  
`brew install pgcli`
3. The path of `psql`  
`brew info libpq`
4. To include in in `zshrc`  
`echo 'export PATH="/usr/local/opt/libpq/bin:$PATH"' >> ~/.zshrc`

### [Postgre.app](https://postgresapp.com/downloads.html) 
Postgre.app is a full-featured PostgreSQL installation packaged as a standard Mac app. 


### Configure the $PATH for [CLI](https://postgresapp.com/documentation/cli-tools.html) (Optional)
`sudo mkdir -p /etc/paths.d &&
 echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp`
 
 ### [Changing](https://thecodinginterface.com/blog/postgresql-changing-data-directory/) the default directory of PostgreSQL (Optional)
 `kencho=# SHOW data_directory;`
 >/Users/kencho/Library/Application Support/Postgres/var-12
 
### Datatypes
1. Characters  

 |Name|Description|
 |:---|:---|
 |varchr(n)|Allows you to declare variable-length with a limit|
 |char(n)|Fixed-length, blank padded|
 |text|User can use this data type to declare a variable with unlimited length|
 
2. Numeric  
- Integers
- Floating-pointing numbers

3. Binary  
- Binary strings allow storing odds of value zero
- Non- printable octets

4. Network Address Type
- cider: IPv4 and IPv6 networks
- Inet: IPv4 and IPv5 host and networks
- macaaddr: MAC addresses

5. Text Search Type

6. Date/Time 
PostgreSQL timestamp offers microsecond precision instead of second precision. Date and time input is accepted in various format, including traditional Postgres, ISO 8601. SQL-compatible etc.

7. Boolean
- True, `1`
- False, `0`
- null

8. Geometric 

9. Enumerated  
Enumerated Data types in PostgreSQL is useful for representing rarely changing information such as country code or branch id. 
The Enumerated data type is represented in a table with foreign keys to ensure data integrity. Here is the example code:
```postgresql
#Hair color is fairly static in a demographic database
CREATE TYPE hair_color AS ENUM
('brown','black','red','grey','blond')
```
10. Range

11. UUID
Universally Unique Identifies (UUID) is a 128-bit quantity, these identifiers are an ideal choice as it offers uniqueness within a single database.  
Example:  
`d5f28c97-b962-43be-9cf8-ca1632182e8e`

12. XML 
 PostgreSQL allows you to store XML data in a data type, but it is nothing more than an extension to a text data type.  
 But the advantage is that it checks that the input XML is well-formed.
 
13. Json
 - Json  
 - Jsonb  
 ```postgresql
 CREATE TABLE employee (
   id integer NOT NULL,
   age  integer NOT NULL,
   data jsonb
 );
```

14. Pseudo-types  
PostgreSQL has many special-purpose entries that are called pseudo-types. 
You can't use pseudo-type as a column data type. 
There are used to declare or function's argument or return type.  
Each of the available pseudo-types is helpful in situations where a function's behavior docs do not correspond to simply taking or returning a value of a specific SQL data type.

### Best practice using data types
- Use "text" data type unless you want to limit the input
- Never use "char."
- Integers use "int." Use bigint only when you have really big numbers
- Use "numeric" almost always
- Use float data type if you have IEEE 754 data source

### Export/save table or query
1. Check current position  
`\! pwd`  
2. List folders  
`\! ls`  
3. Export the Full tables with header   
`COPY albums TO '/Users/dave/Downloads/albums.csv' DELIMITER ',' CSV HEADER;`  
4. Export the query to CSV with header   
`\copy [Table/Query] to [Relative Path] csv header`

### PostgreSQL backup
1. One-time single database backup    
`pg_dump` to back up a single database. It must be run as a user with read permissions to the database you intend to back up.
1.1 Log in as `postgre` user  
`su - postgres`  
1.2 Dump the contents of a database to a file  
`pg_dump dbname > dbname.bak`  
1.3 Restore the database using `psql`  
`psql newdb < dbname.bak`  

2. Backup single database remotely  
`pg_dump -h 198.51.100.0 -p 5432 dbname > dbname.bak`

3. Backup all databases  
`pg_dump`only creates a backup of one database at a time, it does not store information about database roles or other cluster-wide configuration.
`pg_dumpall` can store information about database roles and other cluster-wide configuration.  
3.1 Create backup file
`pg_dumpall > pg_backup.bak`  
3.2 Restore all databases from the backup  
`psql -f pg_backup.bak psotgre`  

### Automate backup with a cron task (say,  backed up at midnight every Sunday)
1. Log is as the `postgre` user  
`su - postgre`  
2. Create a directory to store the automatic backups
`mkdir -p /postgre/backups`  
3. Edit the crontab to create a cron task
`crontab -e`
4. The cron task as 
`0 0 * * 0 pg_dump -U postgres dbname > ~/postgres/backups/dbname.bak > /postgres/log/pg_dump.log`  

### Database backup formats
- *.bak: compressed binary format
- *.sql: plaintext dump  
- *.tar: tarball  

### How to know if the PostgreSQL backup is good?
A. Logical backup: The backup is stored in a human-readable format like SQL.  
B. Physical backup: The backup contains binary data.  

1. backup the database with logs
`pg_dumpall > /path/to/dump.sql > postgres/log/pg_dump.log` 

2. Then to verify the databse.bak is in the backup directory  
```bash
$ grep '^[\]connect' /path/to/dump.sql |awk '{print $2}'
 
template1
 
postgres
 
world
```  
3. Finally, restore the backup and check manually, it is the most secure way to confirm  
```bash
# restore the backup
$ psql -f /path/to/dump.sql postgres

# access it and check it
$ psql 
postgres=# \l
```

### Handling large databases
Some operating systems have maximum file size limits that cause problems when creating large pg_dump output files. 
Fortunately, pg_dump can write to the standard output, so you can use standard Unix tools to work around this potential problem.

1.1 Use compressed dump  
`pg_dump dbname | gzip > filename.gz`  
1.2. Reload with  
`gunzip -c filename.gz | psql dbname`
or  
`cat filename.gz | gunzip | psql dbname`  

2.1 Use `splite`, split the output into smaller files that are acceptable in size to the underlying file system.  
`pg_dump dbname | split -b 1m - filename`  
2.2 Reload with  
`cat filename* | psql dbname`  

### Connected to gigadb database container
1. Connect to gigadb database container locally  
`PGPASSWORD=vagrant psql -h localhost -p 54321 -U gigadb postgres`  
2. Create database  
`postgre=# CREATE DATADASE dbname;`  
3. Restore `dump` database  
`kencho % pg_restore -h localhost -p 54321 -U gigadb -d production_like --clean --no-owner -v sql/production_like.pgdmp`  


### Reference
1. [Introduction to PostgreSQL](https://www.guru99.com/introduction-postgresql.html)
2. [PostgreSQL download](https://www.postgresql.org/download/)
3. [10 Command-line Utilities in PostgreSQL](https://www.datacamp.com/community/tutorials/10-command-line-utilities-postgresql)
4. [cheatsheet](https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546)
5. [Postgres Guide](http://postgresguide.com/utilities/psql.html)
6. [How to exort PostgreSQL Data to a CSV or Excel File](https://dataschool.com/learn-sql/how-to-export-data-to-csv-or-excel/)
7. [PostgreSQL backup stratgy](https://www.linode.com/docs/databases/postgresql/how-to-back-up-your-postgresql-database/)
8. [Cron task](https://www.geeksforgeeks.org/crontab-in-linux-with-examples/)
9. [How Do I Know if My PostgreSQL Backup is Good?](https://severalnines.com/database-blog/how-do-i-know-if-my-postgresql-backup-good)
10. [Chapter 24. Backup and Restore](https://www.postgresql.org/docs/9.1/backup.html)
11. [Automated Testing of PostgreSQL Backups](https://pgdash.io/blog/testing-postgres-backups.html)
12. [SQL Tutorial](https://sqlzoo.net/)