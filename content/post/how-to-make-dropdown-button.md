+++
description = "Steps to make a dropdown button"
title = "How to Make Dropdown Button"
date = 2021-05-21T12:20:14+08:00
tags = ["javascript", "bootstrap"]
author = "Ken Cho"

+++  
### Task
1. To implement a `dropdown box` with different citation source, description at [Issue #83]([PR #521](https://github.com/gigascience/gigadb-website/issue/83)
2. [PR #521](https://github.com/gigascience/gigadb-website/pull/521)

### Steps
1. Create dropdown in `bootstrap` way
```html
<div id="dataset-block-wrapper">
    <div id="dropdown-div">
        <div class="dropdown-box">
            <button id="CiteDataset" class="drop-citation-btn dropdown-toggle" type="button" data-toggle="dropdown">Cite Dataset<span class="caret"></span></button>
            <?php
            $text = file_get_contents('https://data.datacite.org/text/x-bibliography/10.5524/' . $model->identifier);
            $clean_text = strip_tags(preg_replace("/&#?[a-z0-9]+;/i", "", $text));
            ?>
            <script>
                function showText() {
                    var textWindow = window.open();
                    textWindow.document.write(`<?php echo $clean_text; ?>`);
                }
            </script>
            <ul class="dropdown-menu" aria-labelledby="CiteDataset">
                <li><a id="Text" onclick="showText()" target="_blank">Text</a></li>
                <li><a id="citeRis" href='https://data.datacite.org/application/x-research-info-systems/10.5524/<?php echo $model->identifier;?>' target="_self">RIS</a></li>
                <li><a id="citeBibTeX" href='https://data.datacite.org/application/x-bibtex/10.5524/<?php echo $model->identifier;?>' target="_self">BibTeX</a></li>
            </ul>
        </div>
    </div>
</div>
```

2. Create dropdown in `javascript` way
```html
<div id="dropdown-div">
    <div>
    <a id="CiteDataset" onclick="showCitation()" class="drop-citation-btn" >Cite Dataset<span class="caret"></span></a>
        <div id="citationDropdown" class="citation-content">
             <?php
             $text = file_get_contents('https://data.datacite.org/text/x-bibliography/10.5524/' . $model->identifier);
             $clean_text = strip_tags(preg_replace("/&#?[a-z0-9]+;/i", "", $text));
             textWindow.document.write(`<?php echo $clean_text; ?>`);
             </script>
             <ul>
                 <li><a id="Text" onclick="showText()" target="_blank">Text</a></li>
                 <li><a id="citeRis" href='https://data.datacite.org/application/x-research-info-systems/10.5524/<?php echo $model->identifier;?>' target="_self">RIS</a></li>
                 <li><a id="citeBibTeX" href='https://data.datacite.org/application/x-bibtex/10.5524/<?php echo $model->identifier;?>' target="_self">BibTeX</a></li>
             </ul>
        </div>
    </div>
</div>

<script>
    /* When the user clicks on the button, toggle between hiding and showing the dropdown content */
    function showCitation() {
        document.getElementById("citationDropdown").classList.toggle("show");
    }

    // Close the dropdown if the user clicks outside of it
    window.onclick = function(event) {
        if (!event.target.matches('.drop-citation-btn')) {
            var dropdowns = document.getElementsByClassName("citation-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }

    //Write the clean text to a new window
    function showText() {
        var text = `<?php echo $clean_text; ?>`
        console.log(text);
        var textWindow = window.open();
        textWindow.document.write(text);
    }
</script>
```

### Thoughts
1. Since html comes with bootstrap with default `dropdown` features, it is better use it, as it is cleaner and less code.  
2. But good to know how to implement dropdown in `javascript`   

### Pass the `acceptance test`

```php
/**
     * @Then I go to new tab and should see :arg1
     */
    public function iGoToNewTabAndShouldSee($arg1)
    {
        $session = $this->minkContext->getSession();
        $numberOfTab = $session->getWindowNames();
        if (sizeof($numberOfTab) < 2) {
            print ("Expected to see at least 2 windows opened.");
            exit;
        }
        $session->switchToWindow($numberOfTab[1]);

        PHPUnit_Framework_Assert::assertTrue($session->getPage()->hasContent($arg1));
    }

    /**
     * @When I click :arg1
     * To trigger onclick event
     */
    public function iClick($arg1)
    {
        $element = $this->minkContext->getSession()->getPage()->find('css', "a[id='$arg1']" );
        $element->click();
    }
```

```gherkin
@ok @javascript @citation-box
	Scenario: To see the citation box and and the citation source
		Given I am not logged in to Gigadb web site
		And I am on "/dataset/101001"
		When I press "Cite Dataset"
		Then I should see "Text"
		And I should see "RIS"
		And I should see "BibTeX"

	@ok @javascript @citation-box
	Scenario: To show the citation text from CrossCite after clicking the Formatted Text button in the citation box
		Given I am not logged in to Gigadb web site
		And I am on "/dataset/101001"
		And I press "Cite Dataset"
		When I click "Text"
		Then I go to new tab and should see "Huang, Y., Li, Y., Burt, D. W., Chen, H., Zhang, Y., Qian, W., Kim, H., Gan, S., Zhao, Y., Li, J., Yi, K., Feng, H., Zhu, P., Li, B., Liu, Q., Fairley, S., Magor, K. E., Du, Z., Hu, X., … Li, N. (2013). Genome sequence of the duck (Anas platyrhynchos) [Data set]. GigaScience Database. https://doi.org/10.5524/101001"

	@ok @javascript @citation-box
	Scenario: To get RIS file after clicking the RIS in the citation box
		Given I am not logged in to Gigadb web site
		And I am on "/dataset/101001"
		And I press "Cite Dataset"
		When I click on the "RIS" button
		Then the response should contain "101001"
		# 200: the request completed successfully
		And the response should contain "200"

	@ok @javascript @citation-box
	Scenario: To get BibTeX file after clicking the BibTeX in the citation box
		Given I am not logged in to Gigadb web site
		And I am on "/dataset/101001"
		And I press "Cite Dataset"
		When I click on the "BibTeX" button
		Then the response should contain "101001"
		# 200: the request completed successfully
		And the response should contain "200"
```

### Reference
1. What is Tabnabbing? How to solve it? [here](https://medium.com/@shatabda/security-tabnabbing-what-how-b038a70d300e)

[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

