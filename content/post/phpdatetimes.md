+++
description = "Dates and Times with PHP"
title = "PHP date times"
date = 2020-07-03T12:03:08+08:00
tags = ["PHP", "date", "time"]
author = "Ken Cho"
+++
### What is timestamp?
A timestamp is the number of seconds from `January 1, 1970 at 00:00`.

```php
<?php

//output number of seconds from Jan 1, 1970 at 00:00.
echo time();

echo date("d/m/y")."\n";
$now = getdate();
echo $now["hours"]+8;
//print_r ($now);

// 'z' is indexed from 0, so it is necessary to add 1.
$numDays = date("z", mktime(0,0,0,12,31,2020))+1;

$numWeeks = date("W", mktime(0,0,0,12,31,2020));
echo "There are $numDays days and $numWeeks weeks in 2020.\n";

```

### How to display the current date/time?
```php
<?php
// get current date and time
// getdate() returns an array of values
// notice that the 0th  element of the array returned by getdate() contains a UNIX timestamp
$now = getdate();

// turn it into strings

$currentTime = $now["hours"]+6 . ":" . $now["minutes"] .":" . $now["second"];
$currentDate = $now["mday"] . "." . $now["mon"] . "." . $now["year"];

// result: "It is now 12:37:47 on 30.10.2006"
echo "It is now $currentTime on $currentDate";
```

### What are the formats of displaying?

##### Important Full Date and Time
|Parameters|Description|
|:---------|:-----------|
|r| Displays the full date, time and timezone offset. It is equivalent to manually entering date(“D, d M Y H:i:s O”)|

##### Time
|Parameters|Description|
|:---------|:-----------|
|a| am or pm depending on the time|
|A| AM or PM depending on the time|
|g| Hour without leading zeroes. Values are 1 through 12|
|G| Hour in 24-hour format without leading zeroes. Values are 0 through 23|
|h| Hour with leading zeroes. Values 01 through 12|
|H| Hour in 24-hour format with leading zeroes. Values 00 through 23|
|i| Minute with leading zeroes. Values 00 through 59|
|s| Seconds with leading zeroes. Values 00 through 59|

##### Day
|Parameters|Description|
|:---------|:-----------|
|d| Day of the month with leading zeroes. Values are 01 through 31|
|j| Day of the month without leading zeroes. Values 1 through 31|
|D| Day of the week abbreviations. Sun through Sat|
|l| Day of the week. Values Sunday through Saturday|
|w| Day of the week without leading zeroes. Values 0 through 6|
|z| Day of the year without leading zeroes. Values 0 through 365|

##### Month
|Parameters|Description|
|:---------|:-----------|
|m| Month number with leading zeroes. Values 01 through 12|
|n| Month number without leading zeroes. Values 1 through 12|
|M| Abbreviation for the month. Values Jan through Dec|
|F| Normal month representation. Values January through December|
|t| The number of days in the month. Values 28 through 31|

#### Year
|Parameters|Description|
|:---------|:-----------|
|L|1 if it’s a leap year and 0 if it isn’t|
|Y|A four digit year format|
|y|A two digit year format. Values 00 through 99|

### Other Formatting
|Parameters|Description|
|:---------|:-----------|
|U| The number of seconds since the Unix Epoch (January 1, 1970)|
|O| This represents the Timezone offset, which is the difference from Greenwich Meridian Time (GMT). 100 = 1 hour, -600 = -6 hours|


### How to turn a UNIX timestamp into a human-readable string?
```php
<?php

// get date

// result: "30 Oct 2006" (example)

echo date("d M Y"). " <br>";

// get time

// result: "12:38:26 PM" (example)

echo date("h:i:s A"). " <br>";

// get date and time

// result: "Monday, 30 October 2006, 12:38:26 PM" (example)

echo date ("l, d F Y, h:i:s A") . " <br>";

// get time with timezone

// result: "12:38:26 PM UTC"

echo date ("h:i:s A T") . " <br>";

// get date and time in ISO8601 format

// result: "2006-10-30T12:38:26+00:00"

echo date ("c");

?>
```

### How to convert between mm and hh:mm formats?
```php
<?php

// define number of minutes

$mm = 156;

// convert to hh:mm format

// result: "02h 36m"

echo sprintf("%02dh %02dm", floor($mm/60), $mm%60);

?>

<?php

// define hours and minutes

$hhmm = "02:36";

// convert to minutes

// result: "156 minutes"

$arr = explode(":", $hhmm);

echo $arr[0]*60 + $arr[1] . " minutes";

?>
```

### How to convert local time to Greenwich Mean Time (GMT)?
```php
<?php

// convert current local time (IST) to GMT

// result: "15:06:25 30-Oct-06 GMT" (example)

echo gmdate("H:i:s d-M-y T") . "<br>";

// convert specified local time (IST) to GMT

// result: "23:00:00 01-Feb-05 GMT" (example)

$ts = mktime(4,30,0,2,2,2005);

echo gmdate("H:i:s d-M-y T", $ts);

?>
```

### How to obtain the local time in another time zone, given its GMT offset?

```php
<?php

// set default time zone to destination

// result: "00:11:26 31-10-06 SST"

date_default_timezone_set('Asia/Singapore');

echo date("H:i:s d-m-y") . " SST \n";

// set default time zone to destination

// result: "08:11:26 30-10-06 PST"

date_default_timezone_set('US/Pacific');

echo date("H:i:s d-m-y") . " PST \n";

?>
```





### Reference
1. [PHP dates and times](http://www.w3programmers.com/php-working-with-dates-and-times/)
