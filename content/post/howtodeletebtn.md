+++
description = "User experience - Delete feature"
title = "How to add delete button"
date = 2020-09-23T14:01:01+08:00
tags = ["Yii", "JavaScript","#457"]
author = "Ken Cho"

+++  
### Problem
1. Add `Delete` button in `AdminFile/update` under `New Attribute`  
2. Create `actionDeleteAttr`  
3. Pass `Behat` tests  

### How
1. Add `Delete` button in `/protected/adminFile/_form.php`  
```html
<tbody>
    <?php foreach($model->fileAttributes as $fa) { ?>
    <tr class="row-edit-<?= $fa->id ?>">
        <td>
            <?= $fa->attribute->attribute_name ?>
        </td>
        <td>
            <?= $fa->value ?>
        </td>
        <td>
            <?= $fa->unit ? $fa->unit->name : '' ?>
        </td>
        <td><a role="button" class="btn btn-edit js-edit" data="<?= $fa->id ?>">Edit</a></td>
        <td><a role="button" class="btn js-delete" name="delete_attr" data="<?= $fa->id ?>">Delete</a></td>
    </tr>
    <?php } ?>
</tbody>

<script>
$('.js-delete').click(function (e) {
    e.preventDefault();
    id = $(this).attr('data');
    console.log(id);
    row = $('.row-edit-' + id);
    console.log(row);
    if (id) {
        $.post('/adminFile/deleteAttr', { 'id': id }, function(result) {
            if (result) {
                // console.log(result);
            }
        }, 'json');
    }
    window.location.reload();
})
</script>
```
2. Create `actionDeleteAttr` in `/controller/AdminFileController.php`  
```php
public function actionDeleteAttr()
{
    if (!Yii::app()->request->isPostRequest)
        throw new CHttpException(404, "The requested page does not exist.");

    if (isset($_POST['id'])) {
        $attribute = FileAttributes::model()->findByPk($_POST['id']);
        if ($attribute) {
            $attribute->delete();
            Yii::app()->end();
        }
    }
}
```

3. Create `admin-file.feature`  
```gherkin
@admin-file @issue-457
  Feature: An admin user can edit and delete attribute in admin file page
    As an admin user
    I can edit/delete attribute
    So that I can associate various attributes to files

  Background:
    Given Gigadb web site is loaded with production-like data


  @ok @issue-457 @javascript
  Scenario: Guest user cannot visit admin file update page
    Given I am not logged in to Gigadb web site
    When I go to "/adminFile/update/"
    Then I should see "Login"

  @ok @issue-457 @javascript
  Scenario: Sign in as admin and visit admin file update page and see New Attribute, Edit, Delete buttons
    Given I sign in as an admin
    When I am on "/adminFile/update/id/13973"
    Then I should see a button "New Attribute"
    And I should see a button input "Edit"
    And I should see a button input "Delete"

  @ok @issue-457 @javascript
  Scenario: Sign in as admin to delete attribute
    Given I sign in as an admin
    And I am on "/adminFile/update/id/13973"
    And I should see a button input "Delete"
    When I press "Delete"
    And I wait "3" seconds
    Then I should not see a button "Delete"
```
4. Run `behat test` with Database set up  
4.1 only `accptance test`
```bash
#!/usr/bin/env bash

set -e -u

./tests/acceptance
#./tests/unit_functional
#./tests/coverage
```
4.2 change tag to `@wip`  
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

5. Run `behat test`  
`docker-compose run --rm test`  


### Important!
1. Run `behat test` with setting up the database is required to pass `I sign in as an admin`.  

### Reference
1. PR [Delete button #503](https://github.com/gigascience/gigadb-website/pull/503)

[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)


