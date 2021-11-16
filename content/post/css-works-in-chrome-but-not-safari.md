+++
description = "Css Works in Chrome but Not Safari"
title = "Why CSS works in Chrome but not Safari?"
date = 2021-03-11T15:03:47+08:00
tags = ["CSS", "Safari", "Chrome"]
author = "Ken Cho"

+++  
### Observation for [PR #521](https://github.com/gigascience/gigadb-website/pull/521)
1. Safari
![img.png](/image/safari-before.png)
2. Chrome
![img.png](/image/chrome.png)
3. After manual add in styles in Safari browser
![img.png](/image/safari-after.png)

### Problem
1. The `dropdown button`, `dropdown box` and `dropdown list` were not wrapped inside a `<div></div>` 

```html
<div class="color-background color-background-block dataset-color-background-block">
     <p><?= $mainSection->getReleaseDetails()['authors'] ?> (<?=$mainSection->getReleaseDetails()['release_year']?>): <?= $mainSection->getReleaseDetails()['dataset_title'].' '.($mainSection->getReleaseDetails()['publisher'] ?? '<span class="label label-danger">NO PUBLISHER SET</span>').'. '; ?><a href="https://doi.org/10.5524/<?php echo $model->identifier;?>">https://doi.org/10.5524/<?php echo $model->identifier;?></a></p>
     <p><a class="doi-badge" href="#"><span class="badge">DOI</span><span class="badge">10.5524/<?php echo $model->identifier;?></span></a><button onclick="showCitation()" class="drop-citation-btn" >Cite Dataset<span class="caret"></span></button></p>
     <div id="citationDropdown" class="citation-content">
         <a id="citeText" href='http://data.datacite.org/text/x-bibliography/10.5524/<?php echo $model->identifier;?>' target="_blank">Text</a>
         <a id="citeRis" href='http://data.datacite.org/application/x-research-info-systems/10.5524/<?php echo $model->identifier;?>' target="_self">RIS</a>
        <a id="citeBibTeX" href='http://data.datacite.org/application/x-bibtex/10.5524/<?php echo $model->identifier;?>' target="_self">BibTeX</a>
    </div>
</div>
```

### Solution
1. Wrap all dropdown stuff inside `dataset-block-wrapper`  
```html
<div class="color-background color-background-block dataset-color-background-block">
    <p><?= $mainSection->getReleaseDetails()['authors'] ?> (<?=$mainSection->getReleaseDetails()['release_year']?>): <?= $mainSection->getReleaseDetails()['dataset_title'].' '.($mainSection->getReleaseDetails()['publisher'] ?? '<span class="label label-danger">NO PUBLISHER SET</span>').'. '; ?><a href="https://doi.org/10.5524/<?php echo $model->identifier;?>">https://doi.org/10.5524/<?php echo $model->identifier;?></a></p>
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
</div>
```

2. Update the `CSS`
```less
#dropdown-div {
  margin : 0;
  float : left ;
}
.dropdown-box {
  position: absolute;
}
.drop-citation-btn {
  width: 110px;
  color: white;
  font-size: 13px;
  font-weight: normal;
  border: none;
  cursor: pointer;
  background-color: #099242;
  padding: 5px 10px;
  border-radius: 4px 4px 4px 4px;
  display: inline-block;
  position: relative;
  text-decoration: none;
}
.drop-citation-btn:hover {
  color: white;
  text-decoration: none;
}
.drop-citation-btn:focus {
  outline: none;
}
#dropdown-div ul {
  list-style: none;
  position: relative;
  float: none;
  margin-top: 5px;
  min-width: 100px;
  border: 1px solid #099242;
  border-radius: 4px 4px 4px 4px;
  font-size: 13px;
}
#dropdown-div li a:hover {background-color: #F3FAF6;}
```


### Reference
1. [Cross browser testing](https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Cross_browser_testing/Introduction)
2. [Handling common HTML and CSS problem](https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Cross_browser_testing/HTML_and_CSS)

[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

