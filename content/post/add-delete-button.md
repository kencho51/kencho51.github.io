+++
description = "How to add a delete button and pass tests"
title = "Add Delete Button for file attribute page"
date = 2021-02-22T12:49:28+08:00
tags = ["factory method", "csv migration"]
author = "Ken Cho"

+++  
### Problem - [Add-delete-button-#457](https://github.com/gigascience/gigadb-website/pull/503)  
1. Create `Delete` button function in the `admin file page`
![img](/image/delete_button.png)

2. `DatasetLog` and `CurationLog` to log the events.  
3. Pass the `unit test` and `acceptance test`.  

### How
1. Create `Delete` button in `/view/adminFile/_form.php`
```html
<td><a role="button" class="btn js-delete" name="delete_file_attr" data="<?= $fa->id ?>">Delete</a></td>

</script> 

$('.js-delete').click(function (e) {
    e.preventDefault();
    id = $(this).attr('data');
    row = $('.row-edit-' + id);
    if (id) {
        $.post('/adminFile/deleteFileAttribute', { 'id': id }, function(result) {
            if (result) {
                // console.log(result);
            }
        }, 'json');
    }
    window.location.reload();
})
</script>
```
2. Create action `deleteFileAttribute` in `AdminFileController.php`
```php
    public function accessRules()
    {
        return array(
            array('allow', // admin only
                    'actions'=>array('linkFolder','admin','delete','index','view','create','update','update1', 'editAttr', 'uploadAttr', 'deleteFileAttribute'),
                    'roles'=>array('admin'),
            ),
                            array('allow',
                                    'actions' => array('create1'),
                                    'users' => array('@'),
                            ),
                            array('allow',  // allow all users
                                'actions' => array('downloadCount'),
                                'users'=>array('*'),
                            ),
            array('deny',  // deny all users
                    'users'=>array('*'),
            ),
        );
    }


    /**
     * Yii's method for routing urls to an action. Override to use custom actions
     */
    public function actions()
    {
        return array(
            'deleteFileAttribute'=>'application.controllers.adminFile.DeleteFileAttributeAction',
        );
    }

```

3. Create `DeleteFileAttributeAction.php` in `/controllers/adminFile`, because `AdminFileController.php` is very big, so better be implemented in separate class
```php
<?php
/**
 * This action will delete file attributes in admin file update page
 */

class DeleteFileAttributeAction extends CAction
{
    public function run()
    {
        if (!Yii::app()->request->isPostRequest)
            throw new CHttpException(404, "The requested page does not exist.");

        if (isset($_POST['id'])) {
            $attribute = FileAttributes::model()->findByPk($_POST['id']);

            if ($attribute) {
                $out = $attribute->file->dataset_id;
                $fileName = $attribute->file->name;
                $fileModel = get_class($attribute);
                $fileId = $attribute->file->id;
                $modelId = $attribute->id;
                $model = Dataset::model()->findByPk($out);
                if ($model->upload_status === "Published") {
                    DatasetLog::createDatasetLogEntry($out, $fileName, $fileModel, $modelId, $fileId);
                } else {
                    CurationLog::createCurationLogEntry($out, $fileName); //Pass in dataset_id returned from File object.
                }
                $attribute->delete();
                Yii::app()->end();
            }
        }
    }
}
```

4. `Factory method` in `/protected/models/DatasetLog.php` to log `Published` dataset
```php
  /**
     * Factory method to call for common attributes
     * @param int $id
     * @param string $fileName
     * @param string $fileModel
     * @param int $modelId
     * @param int $fileId
     * @return DatasetLog
     */
    public static function makeNewInstanceForDatasetLogBy (int $id, string $fileName, string $fileModel, int $modelId, int $fileId): DatasetLog
    {
        $datasetlog = new DatasetLog();
        $datasetlog->created_at = date("Y-m-d H:i:s");
        $datasetlog->dataset_id = $id;
        $datasetlog->message = $fileName;
        $datasetlog->model = $fileModel;
        $datasetlog->model_id = $modelId;
        $datasetlog->url = Yii::app()->createUrl('/adminFile/update', array('id'=>$fileId));
        return $datasetlog;
    }

    /**
     * Retrieves attributes and store them in dataset_log table when triggered.
     * @param int $id
     * @param string $fileName
     * @param string $fileModel
     * @param int $modelId
     * @param int $fileId
     * @return bool
     */
    public static function createDatasetLogEntry(int $id, string $fileName, string $fileModel, int $modelId, int $fileId): bool
    {
        $datasetlog = self::makeNewInstanceForDatasetLogBy($id, $fileName, $fileModel, $modelId, $fileId);
        $datasetlog->message = $fileName. ": file attribute deleted";
        return $datasetlog->save();
    }
```
5. Pass the `unit test` for `datasetLog`
```php
<?php

class DatasetLogTest extends CDbTestCase
{
    public function testDataSetLogEntryFactory()
    {
        // With reference to the entry in dataset_log fixture
        $datasetId = 1;
        $fileName = "File Tinamus_guttatus.fa.gz";
        $fileModel = "File";
        $modelId = 16945;
        $fileId = 16945; //mockup ID
        $datasetlog = DatasetLog::makeNewInstanceForDatasetLogBy($datasetId, $fileName, $fileModel, $modelId, $fileId);
        $this->assertNotNull($datasetlog);
        $this->assertTrue(is_a($datasetlog, DatasetLog::class));
        $this->assertEquals($datasetId, $datasetlog->dataset_id);
        $this->assertEquals($fileName, $datasetlog->message);
        $this->assertEquals($fileModel, $datasetlog->model);
        $this->assertEquals($modelId, $datasetlog->model_id);
        $this->assertEquals("./bin/adminFile/update/id/$fileId", $datasetlog->url);
        $this->assertTrue($datasetlog->isNewRecord);
    }

    // Includde Dataset fixture to avoid unique duplicate key value violation with dataset_log_pkey
    protected $fixtures=array(
        'datasets'=>'Dataset',
    );

    public function testCreateDatasetLogEntry()
    {
        $datasetId = 1;
        $fileName = "File Tinamus_guttatus.fa.gz";
        $fileModel = "File";
        $modelId = 16945;
        $fileId = 16945; //mockup ID
        $saveNewEntry = DatasetLog::createDatasetLogEntry($datasetId, $fileName, $fileModel, $modelId, $fileId);
        $this->assertTrue(is_bool($saveNewEntry) === true, "bool is returned");
        $this->assertTrue(true===$saveNewEntry, "No new entry is saved to dataset log table");

        // To assert the delete message will be generated as expected
        $datasetlog = DatasetLog::model()->findByPk($datasetId);
        $this->assertEquals("File Tinamus_guttatus.fa.gz: file attribute deleted", $datasetlog->message, "Delete message was generated in different format");
    }
}
```
6. `Factory method` in `/protected/models/CurationLog.php` to log `non Published` dataset
```php
    /**
     * Factory method to make a new instance and factor out the common code
     *
     * @param int $id
     * @param string $creator
     * @return CurationLog
     */
    public static function makeNewInstanceForCurationLogBy(int $id, string $creator): CurationLog
    {
        $curationlog = new CurationLog();
        $curationlog->creation_date = date("Y-m-d");
        $curationlog->last_modified_date = null;
        $curationlog->dataset_id = $id;
        $curationlog->created_by = $creator;
        return $curationlog;
    }

    public static function createlog($status,$id) {

        $curationlog = self::makeNewInstanceForCurationLogBy($id, "System");
        $curationlog->action = "Status changed to ".$status;
        return $curationlog->save();
    }

    public static function createlog_assign_curator($id,$creator,$username) {

        $curationlog = self::makeNewInstanceForCurationLogBy($id, $creator);
        $curationlog->action = "Curator Assigned"." $username";
        return $curationlog->save();
    }

    /**
     * Retrieves attributes and store them in curation_log table when triggered
     * @param $id
     * @param string $fileName
     * @return bool
     */
    public static function createCurationLogEntry(int $id, string $fileName): bool
    {
        $curationlog = self::makeNewInstanceForCurationLogBy($id, "System");
        $curationlog->action = $fileName.": file attribute deleted";
        return $curationlog->save();
    }
```

7. Pass the `unit test` for `CurationLog`
```php
<?php

class CurationLogTest extends CDbTestCase
{
    public function testMakeNewInstance()
    {
        $datasetId = 1;
        $creator = "System";
        $curationLog = CurationLog::makeNewInstanceForCurationLogBy($datasetId, $creator);
        $this->assertNotNull($curationLog);
        $this->assertTrue(is_a($curationLog, CurationLog::class));
        $this->assertEquals($datasetId, $curationLog->dataset_id);
        $this->assertEquals($creator, $curationLog->created_by);
        $this->assertTrue($curationLog->isNewRecord);
    }
}
```

8. Create `I should see a file attribute table` in `DatasetViewContext.php`
```php
    /**
     * @Then I should see a file attribute table
     */
    public function iShouldSeeATable(TableNode $table)
    {
        foreach ($table as $row) {
            PHPUnit_Framework_Assert::assertTrue(
                $this->minkContext->getSession()->getPage()->hasContent($row['Attribute Name'])
            );
            PHPUnit_Framework_Assert::assertTrue(
                $this->minkContext->getSession()->getPage()->hasContent($row['Value'])
            );
            PHPUnit_Framework_Assert::assertTrue(
                $this->minkContext->getSession()->getPage()->hasContent($row['Unit'])
            );
        }
    }
```
9. Pass the `acceptance test`
```gherkin
@admin-file @issue-457
  Feature: A curator can manage file attributes in admin file update page
    As a curator,
    I want to manage file attributes from the update form
    So that I can associate various attributes to files

  Background:
    Given Gigadb web site is loaded with production-like data
    And an admin user exists

  @ok
  Scenario: Guest user cannot visit admin file update page
    Given I am not logged in to Gigadb web site
    When I go to "/adminFile/update/"
    Then I should see "Login"

  @ok
  Scenario: Go to a published dataset found in production-like database
    Given I am not logged in to Gigadb web site
    When I go to "dataset/100056"
    And I should see "Termitomyces sp. J132 fungus genome assembly data."
    And I follow "History"
    Then I should see "History" tab with text "File Termitomyces_assembly_v1.0.fa.gz updated"
    And I should see "History" tab with text "File Termitomyces_gene_v1.0.cds.fa updated"
    And I should see "History" tab with text "File Termitomyces_gene_v1.0.cds.fa updated"
    And I should see "History" tab with text "File Termitomyces_gene_v1.0.gff updated"
    And I should see "History" tab with text "File Termitomyces_gene_v1.0.gff updated"
    And I should see "History" tab with text "File Termitomyces_gene_v1.0.pep.fa updated"
    And I should see "History" tab with text "File Termitomyces_gene_v1.0.pep.fa updated"

  @ok @Published
  Scenario: Sign in as admin and visit admin file update page and see New Attribute, Edit, Delete buttons
    Given I sign in as an admin
    When I am on "/adminFile/update/id/13973"
    Then I should see a button "New Attribute"
    And I should see a file attribute table
      | Attribute Name | Value | Unit |
      | last_modified  | 2013-7-15 |  |
    And I should see a button input "Edit"
    And I should see a button input "Delete"

  @ok @javascript @Published
  Scenario: Sign in as admin, delete an attribute of a published dataset and check history tab
    Given I sign in as an admin
    And I am on "/adminFile/update/id/13973"
    And I should see "last_modified"
    When I press "Delete"
    And I go to "dataset/100056"
    Then I should see "Termitomyces sp. J132 fungus genome assembly data."
    And I follow "History"
    And I should see "History" tab with text "Termitomyces_assembly_v1.0.fa.gz: file attribute deleted"

  @ok @javascript @Published
  Scenario: Sign in as admin, no delete button should be seen after delete action has been triggered
    Given I sign in as an admin
    And I am on "/adminFile/update/id/13973"
    And I should see a file attribute table
    | Attribute Name | Value | Unit |
    | last_modified  | 2013-7-15 |  |
    And I should see a button input "Delete"
    When I press "Delete"
    And I wait "3" seconds
    Then I should not see "last_modified"
    And I should not see "2013-7-15"
    And I should not see a button "Delete"

  @ok @javascript @NonPublished
  Scenario: Go to a non published dataset found in production-like database, create then delete a keyword attribute
    Given I sign in as an admin
    And I am on "/adminFile/update/id/95354"
    And I should see "test Bauhinia"
    And I press "Delete"
    And I should not see "test Bauhinia"
    #Go to the last page of dataset log
    When I go to "datasetLog/admin/DatasetLog_page/74"
    Then I should not see "100245"
    And I should not see "FCHCGJYBBXX-HKBAUpcgEAACRAAPEI-201_L2_2.fq.gz: file attribute added"
    And I should not see "FCHCGJYBBXX-HKBAUpcgEAACRAAPEI-201_L2_2.fq.gz: file attribute deleted"

```
### Learn
1. Tables relationship  
| dataset | file | file_attribute |
| ------- | -----| -------------- |
| **id** | ~~id~~ | id |
| identifier | **dataset_id** | ~~file_id~~ |
| upload_status | | value |

2.1 Update file_attribute table in `data/dev/production_like` 
```csv
id,file_id,attribute_id,value,unit_id
5441,95354,455,test Bauhinia,
```
2.2 Update the `production_like.pgdmp`, [PR548](https://github.com/gigascience/gigadb-website/pull/548) 
`ops/scripts/make_pgdmp_production_like.sh`


### Hints from Rija
>I must have forgotten what you said 😞
Right now I am working on to pass the `curation_log` test, here is my scenario:
```
  Background:
    Given Gigadb web site is loaded with production-like data

   @wip @issue-#457 @javascript
    Scenario: Go to a non published dataset found in production-like database
        Given I sign in as an admin
        And I go to "/adminFile/update/id/xxx"
        And I should see some file attributes
        When I press "Delete"
        And I should not see file attributes
        And I go to "dataset/YYY"
        And I follow "History"
        Then I should not see some file attributes
```
>But I think the above scenario is not a proper way to test.
>Because,  I could not identify the correct `xxx` and `YYY`. And even I found the `xxx`, this step `And I go to "dataset/YYY"` will not pass as error `The dataset does not exist` will be found.

>So, can I have your suggestion on how to pass the `curation_log` test?

----

Among a dataset's attributes in the database table there are ``id``, and ``identifier``.

Controller actions that alter the dataset expect to have the internal id ``id`` as parameter (that's your xxx) as that's the most appropriate one to uniquely identify a row in a database table.

In ``/adminFile/update/id/xxx``, ``/id/`` is how yii framework knows that we are looking for a dataset whose ``id`` attribute is ``xxx``

``identifier`` is for the DOI and is the public identifier for the dataset, that's why it is used in the view as the dataset url is meant to be shared publicly (that's your ``yyy``).

So when you pick a dataset as example, select both attributes from the table.
```
gigadb=# select id, identifier, title from dataset;
id  | identifier |  title
...
 189 | 100133     | Reference data for phage M13 dsDNA generated with the Oxford Nanopore MinION.
 204 | 100143     | Software and supporting material for "SMAP: a streamlined methylation pipelinefor bisulphite sequencing".
 210 | 100155     | Supporting data for "Sparse whole-genome sequencing identifies two loci for major depressive disorder".
...
```

Regarding your second point: datasets that are not published cannot be accessible publicly, so going to the public url ``/dataset/yyy`` would result in that error.

You've got couple of approaches:

You could add Given steps to change the upload status temporarily away from published, but then you would need to find a way to revert the change after the test has run.

Or you could have the Then steps to check this page:
(http://gigadb.gigasciencejournal.com:9170/datasetLog/admin/)
or more precisely manually navigate to the last page, and use that in a Then step.
It's not the most robust (the last page may change if we add/remove example datasets from production-like), but it's the easiest.

A better approach  is to use the test database instead of production-like then checking`` /datasetLog/admin/``'s first page would be enough, but you will need some Given steps to add some file attributes first to a dataset as I think the test database doesn't have any.

An improved alternative to that latter pre-condition would be to update the test data for the test database to have some file attributes in it so you don't have to add extra Given steps (I've pasted bash code to do that easily in @pli888's PR 532, you'd just have to update the corresponding CSV file beforehand)


### Reference


[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

