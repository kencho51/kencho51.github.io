+++
description = "Steps to add Utterances to Hugo blog"
title = "How to add a comment functionality using uterances"
date = 2020-06-15T11:25:56+08:00
tags = ["Uterances", "Hugo"]
author = "Ken Cho"

+++
### What is Utterances?
- A lightweight comments widget built on GitHub issues. 
- Use GitHub issues for blog comments.
- Open source.
- Allow Markdown syntax.

### Configuration
1. Create an empty Github repo.  
2. Install [utterances](https://github.com/apps/utterances) app on that repo
3. In the utterances app, only select the repo just created for comment.  
4. Update `config.toml` as below:  
```html
[params.utteranc]
enable = true
repo = "owner/comments_for_hugo"
issueTerm = "pathname"
theme = "github-light"
```
5. Create `contents/` folders in `layouts` directory.  
6. Create `single.html` in the `layouts/*`.  
7. Add the following script to `/layouts/*/single.html`
```html
<script src="https://utteranc.es/client.js"
        repo="owner/comments_for_hugo"
        issue-term="pathname"
        label="comments"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>
```
8. Utterances comments functionality is installed.



### Reference
1. [Utterances](https://utteranc.es/)
2. [How to add Utterances in config.toml](https://tihu.me/post/2020/2020-01-17-comment/)
