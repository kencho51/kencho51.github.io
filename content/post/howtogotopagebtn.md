+++
description = "Pagination - Go to page button"
title = "How to make go to page feature"
date = 2020-08-18T12:15:31+08:00
tags = ["Yii", "JavaScript","#437"]
author = "Ken Cho"

+++  
### Problem
1. To add a go to page feature in navigating file table. 
2. Details refer to this issue [View files from large db #437](https://github.com/gigascience/gigadb-website/issues/437)

### How
1. Create a `Go to page` button
    - match the button style with the whole webpage
    - create `btn_click` class for this onclick button
    - create input box for `number`, and assign `id=pageTarget`
```html
<style>
    .btn_click {
        border: solid 1px #0eb23c;
        color: #0fad59;
        padding: 4px 6px 3px 6px;
        text-decoration: none;
        background-color: Transparent;
        outline:none;
    }
    input {
        width: 3%;
    }
    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    .text_box {
        color: #0fad59;
        background: #fff;
        border: solid 1px #0eb23c;
        outline:none;
    }
</style>
<button class="btn_click" onclick="goToPage()"><strong>Go to page</strong></button>
<input type="number" id="pageTarget" class="text_box">
<a class="color-background"><strong> of <?= $files->getDataProvider()->getPagination()->getPageCount()?></strong></a>
```

2. Create a `goToPage()` function in `JavaScript`
    - `document.getElementById('pageTarget').value` gets the value of the input box
    - `<?php echo $model->identifier?>` gets the paper ID number
    - `<?php echo $files->getDataProvider()->getPagination()->getPageCount()?>` gets the max page count
    - some requirements:
        - disable input box arrows
        - when userInput > max, return to max
        - when userInput < min, return to min
    - `window.location.pathname` will get current page `url`, will crash when `go to page 2 and then press 1`
        - so to create an array with default values: 
        - `let targetUrlArray = ["", "dataset", "view", "id", pageID];`
    
```javascript
    function goToPage() {
        var targetPageNumber = document.getElementById('pageTarget').value;
        var pageID = <?php echo $model->identifier?>;
        //To validate page number
        var userInput = parseInt(targetPageNumber);
        var max = <?php echo $files->getDataProvider()->getPagination()->getPageCount() ?>;
        //To output total pages
        // console.log(max);
        var min = 1;
        if (userInput >= min && userInput <= max) {
            console.log("Valid page number!");
        }else if (userInput > max) {
            targetPageNumber = max;
            console.log("Error, return to " + max);
        } else if (userInput < min) {
            targetPageNumber = min;
            console.log("Error, return to " + min);
        }
        // var targetUrlArray = Array.apply(null, Array(5)).map(function(_,i) { return window.location.pathname.split("/")[i]});]
        // Create array with default values
        let targetUrlArray = ["", "dataset", "view", "id", pageID];
        targetUrlArray.push('Files_page', targetPageNumber);
        window.location = window.location.origin + targetUrlArray.join("/");
        // Uncomment will show the target url in console.
        // console.log(window.location.origin + targetUrlArray.join("/"))
    }
```
### Behat test
`PhantomJS` has been discontinued, so it cannot simulate `pressing` action on `Go to page` button.
In order to do so, `behat.yml` and `docker-compose.yml` need to be updated.  
##### A. behat.yml, to replace `PhantomJS` with `Chrome`
```yaml
default:
  suites:
    default:
      filters:
      contexts:
        - AffiliateLoginContext
        - GigadbWebsiteContext
        - AuthorMergingContext
        - AuthorUserContext
        - ClaimDatasetContext
        - DatasetsOnProfileContext
        - DatasetViewContext
        - DatasetAdminContext
        - NormalLoginContext
        - Behat\MinkExtension\Context\MinkContext
  extensions:
      Behat\MinkExtension:
          base_url: "http://gigadb.dev/"
          goutte: ~
          selenium2:
            wd_host: "http://chrome:4444/wd/hub"
            browser: chrome
            capabilities:
              chrome:
                switches:
                  - "--headless"
                  - "--disable-gpu"
```
##### B. Add 'Chrome' docker image in docker-compose file
```yaml
  chrome:
    image: selenium/standalone-chrome:3.141.59-oxygen # latest version with Chrome 74
    shm_size: '1gb' # to avoid a known issue
    ports:
      # - "5900:5900" #for VNC access
      - "4444:4444" #for webdriver access
    networks:
      - web-tier
    extra_hosts:
      - "gigadb.test:172.16.238.10"
      - "gigadb.dev:172.16.238.10"           
    environment: # to run headless, set false and comment out port 5900 above and make sure to pass --headless arg in acceptance.suite.yml
      START_XVFB: "false"
```
##### C. Stop `PhantomJS` service and Start `Chrome` service
`docker-compose stop phantomjs`  
`docker-compose up -d chrome`

##### D. To run specific behat test
`docker-compose run --rm test bin/behat --tags @wip --stop-on-failure`

1. Press the `Go to page` button and go to page 2  
```gherkin
	@wip @files @javascript @pr437
	Scenario: Files - Pagination
		Given I am not logged in to Gigadb web site
		And I am on "/dataset/101001"
		And I follow "Files"
		And I have set pageSize to "5" on "files_table_settings"
		And I fill in "pageTarget" with "2"
		And I press "Go to page"
		When I follow "1"
		And I take a screenshot named "file_tab_p1"
		Then I should see "Files" tab with table
		| File Name              							| Description  	                                                                    | Data Type       	| Size  		| File Attributes | link |
		| Anas_platyrhynchos.cds 							| predicted coding sequences from draft genome, confirmed with RNAseq data.	        | Coding sequence  	| 21.50 MiB     |                 | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/Anas_platyrhynchos.cds |
		| Anas_platyrhynchos.gff 							| genome annotations	                                                            | Annotation 		| 10.10 MiB 	|                 | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/Anas_platyrhynchos.gff |
		| Anas_platyrhynchos.pep 							| amino acid translations of coding sequences                                       | Protein sequence 	| 7.80 MiB  	|                 | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/Anas_platyrhynchos.pep |
		| Anas_platyrhynchos_domestica.RepeatMasker.out.gz 	| repeat masker output 	                                                            | Other 			| 7.79 MiB  	|                 | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/Anas_platyrhynchos_domestica.RepeatMasker.out.gz |
		| duck.scafSeq.gapFilled.noMito 					| draft genome assembly                                                             | Sequence assembly	| 1.03 GiB 		|                 | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/duck.scafSeq.gapFilled.noMito |
```

2. To enable `hit return` function  
```php
    /**
     * @Then I manually hit return
     */
    public function iManuallyHitReturn()
    {
        $xpath = '//*[@id="pageTarget"]';
        $this->minkContext->getSession()->getDriver()->getWebDriverSession()->element('xpath', $xpath)->postValue(['value' => ["\r\n"]]);
    }
```

3. Hit `return` and go to page 2  
```gherkin
	@wip @files @javascript @pr437
	Scenario: Files - Pagination
		Given I am not logged in to Gigadb web site
		And I am on "/dataset/101001"
		And I follow "Files"
		And I have set pageSize to "5" on "files_table_settings"
		When I fill in "pageTarget" with "2"
		And I manually hit return
#		And I take a screenshot named "file_tab_enter"
		Then I should be on "/dataset/view/id/101001/Files_page/2"
		And I should see "Files" tab with table
		| File Name              							| Description  	                                                                    | Data Type       	| Size  		| File Attributes | link |
		| pre_03AUG2015_update 								| folder containing originally submitted data files, prior to update Aug 3rd 2015.	| Directory 		| 50.00 MiB 	|                 | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/pre_03AUG2015_update |
		| readme.txt 										|				                                                                    | Readme 			| 337 B 		|                 | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/readme.txt |
```



### Reference
1. [Config files](https://gist.github.com/rija/84b87dfccbcc9efb9c288502f2a01602)
2. [xpath information](https://github.com/Behat/MinkExtension/issues/257)
3. [PR #495](https://github.com/gigascience/gigadb-website/pull/495)

[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)


