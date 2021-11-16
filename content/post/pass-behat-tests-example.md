+++
description = "How to pass a behat test"
title = "Pass Behat Tests Example"
date = 2021-01-08T10:30:26+08:00
tags = ["Behat", "TDD"]
author = "Ken Cho"

+++  
## Case 1 - Actual output contains line break, [PR547](https://github.com/gigascience/gigadb-website/pull/547)

### Problem
In `DatasetViewContext.php`:
```php
/**
 * @Then there is a :arg1 meta tag :arg2 with value :arg3
 */
public function thereIsAMetaTagWithValue($arg1, $arg2, $arg3)
{
    $metaNode = $this->minkContext->getSession()->getPage()->find('xpath', "//meta[@$arg1='$arg2' and @content='$arg3']");
    PHPUnit_Framework_Assert::assertNotNull($metaNode);
}

```
In `dataset-metadata-link-preview.feature`:
```gherkin
@wip @issue-513
    Scenario: Can be parsed by preview tools that use HTML meta-tags (e.g: search engines)
    Given I am not logged in to Gigadb web site
    When I am on "/dataset/100002"
    Then there is a meta tag "description" with value "The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth. We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb."
```

The error is:
```bash
Failed asserting that null is not null.
```

### Troubleshooting

```php
/**
 * @Then the page description meta tag should be :arg1
 */
public function thePageDescriptionMetaTagShouldBe($arg1)
{
    $metaNode = $this->minkContext->getSession()->getPage()->find('xpath', "//meta[@name='description']");
    $content = $metaNode->getAttribute('content');
    PHPUnit_Framework_Assert::assertNotNull($content);
    PHPUnit_Framework_Assert::assertEquals($arg1, $content, "The description is not the same!");
}

```

In `dataset-metadata-link-preview.feature`:
```gherkin
  Background:
    Given Gigadb web site is loaded with "gigadb_testdata.pgdmp" data

  @wip @issue-513
    Scenario: Can be parsed by preview tools that use HTML meta-tags (e.g: search engines)
    Given I am not logged in to Gigadb web site
    When I am on "/dataset/100002"
    Then the page description meta tag should be "The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth. We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb."
```

Here is the error after running the test:
```bash
The description is not the same!
Failed asserting that two strings are equal.
--- Expected
+++ Actual
@@ @@
- 'The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth. We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb.'
+ 'The Adelie penguin (Pygoscelis adeliae) is an iconic penguin of moderate stature and a tuxedo of black and white feathers. The penguins are only found in the Antarctic region and surrounding islands. Being very sensitive to climate change, and due to changes in their behavior based on minor shifts in climate, they are often used as a barometer of the Antarctic. 
+ With its status as one of the adorable and cuddly flightless birds of Antarctica, they serve as an example for conservation, and as a result they are now categorised at low risk for endangerment. The sequence of the penguin can be of use in understanding the genetic underpinnings of its evolutionary traits and adaptation to its extreme environment; its unique system of feathers; its prowess as a diver; and its sensitivity to climate change. We hope that this genome data will further our understanding of one of the most remarkable creatures to waddle the planet Earth.
+ We sequenced the genome of an adult male from Inexpressible Island, Ross Sea, Antartica (provided by David Lambert) to a depth of approximately 60X with short reads from a series of libraries with various insert sizes (200bp- 20kb). The assembled scaffolds of high quality sequences total 1.23 Gb, with the contig and scaffold N50 values of 19 kb and 5 mb respectively. We identified 15,270 protein-coding genes with a mean length of 21.3 kb.'
│
│  http://gigadb.dev/dataset/100002
│
└─ @AfterStep # GigadbWebsiteContext::debugStep()

```
The problem is the `description` of dataset `100002` is too long and separated in 3 lines, so the `metaNode` could not find its content.

### Solution 1
Replace the dataset with description has no `line break`.
```gherkin
@ok
    Scenario: Can be parsed by preview tools that use HTML meta-tags (e.g: search engines)
    Given I am not logged in to Gigadb web site
    When I am on "/dataset/100004"
    Then there is a "name" meta tag "title" with value "GigaDB Dataset - DOI 10.5524/100004 - Data and software to accompany the paper: Applying compressed sensing to genome-wide association studies."
    And there is a "name" meta tag "description" with value "The aim of a genome-wide association study (GWAS) is to isolate DNA markers for variants affecting phenotypes of interest. Linear regression is employed for this purpose, and in recent years a signal-processing paradigm known as compressed sensing (CS) has coalesced around a particular class of regression techniques. CS is not a method in its own right, but rather a body of theory regarding signal recovery when the number of predictor variables (i.e., genotyped markers) exceeds the sample size. The paper shows the applicability of compressed sensing (CS) theory to genome-wide association studies (GWAS), where the purpose is to ﬁnd trait-associated tagging markers (genetic variants). Analysis scripts are contained in the compressed CS file. Mock data and scripts are found in the compressed GD file. The example scripts found in the CS repository require the GD files to be unpacked in a separate folder. Please look at accompanying readme pdfs for both repositories and annotations in the example scripts before using."


```
### Solution 2
1. strip the `line break, white space, etc` using `str_replace` in `DatasetContext.php`  
```php
public function thereShouldBeAMetaTagWithMultiplines($arg1, $arg2, \Behat\Gherkin\Node\PyStringNode $expectedValue )
{
    $actualNode = $this->minkContext->getSession()->getPage()->find('xpath', "//meta[@$arg1='$arg2']");
    [$expectContent, $actualContent] = str_replace(["\r","\n","\r\n","\t","\v","\0"," "], "", [$expectedValue->getRaw(), $actualNode->getAttribute('content')]);
    PHPUnit_Framework_Assert::assertEquals($expectContent, $actualContent, 'The content is different!');
}

```
```gherkin
@ok
    Scenario: Can be parsed by preview tools that use HTML meta-tags (e.g: search engines)
    Given I am not logged in to Gigadb web site
    When I am on "/dataset/100004"
    Then there should be a "name" meta tag "title" with value "GigaDB Dataset - DOI 10.5524/100004 - Data and software to accompany the paper: Applying compressed sensing to genome-wide association studies."
    And there should be a "name" meta tag "description" with value "The aim of a genome-wide association study (GWAS) is to isolate DNA markers for variants affecting phenotypes of interest. Linear regression is employed for this purpose, and in recent years a signal-processing paradigm known as compressed sensing (CS) has coalesced around a particular class of regression techniques. CS is not a method in its own right, but rather a body of theory regarding signal recovery when the number of predictor variables (i.e., genotyped markers) exceeds the sample size. The paper shows the applicability of compressed sensing (CS) theory to genome-wide association studies (GWAS), where the purpose is to ﬁnd trait-associated tagging markers (genetic variants). Analysis scripts are contained in the compressed CS file. Mock data and scripts are found in the compressed GD file. The example scripts found in the CS repository require the GD files to be unpacked in a separate folder. Please look at accompanying readme pdfs for both repositories and annotations in the example scripts before using."

```


### Reference
1. [behat-seo-contexts](https://github.com/marcortola/behat-seo-contexts/blob/master/src/Context/MetaContext.php)
2. [behat-common](https://github.com/treehouselabs/behat-common/blob/master/src/TreeHouse/BehatCommon/SeoContext.php)
3. [The Essential Meta Tags for Social Media](https://css-tricks.com/essential-meta-tags-social-media/)
4. [Open Graph Protocol](https://ogp.me/)
5. [What You Need to Know About Open Graph Meta Tags for Total Facebook and Twitter Mastery](https://neilpatel.com/blog/open-graph-meta-tags/)

## Case 2 TBC

[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

