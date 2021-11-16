+++
description = "Application Programming Interface"
title = "What is API?"
date = 2020-08-20T13:38:28+08:00
tags = ["API"]
author = "Ken Cho"

+++  
### A metaphor of API
>Think of an API like a menu in a restaurant. The menu provides a list of dishes you can order, 
>along with a description of each dish. When you specify what menu items you want, the restaurant’s 
>kitchen does the work and provides you with some finished dishes. You don’t know exactly how the restaurant prepares 
>that food, and you don’t really need to.

>An API is very much the same thing as a UI, except that it is geared for consumption by software instead of humans.



### How API works
![img](/image/api.png)
`An API is not a database. It is an access point to an app that can access a database.`

### Why would we need an API?
You (as in, your application, or your client, this could be a web browser) wants to access another app’s data or functionality.
For example, to access all posts with a specific hastag from a IG.

You could write an email and ask for all these posts. The problems are:  
    1. You may not get any replied.  
    2. Even get replied, you have to find a way to import the data into your application.  
    3. Even imported, the information is not up to date.  

So a better solution would be:
    - Provide a way for user to query the application to get that data.
    
So, API is more like providing options to potential users, they can get information from your `application` themselves.
And the requests to retrieve or write data are generally done without frontend, but by sending an HTTP request to a server.

### How to build an API?
1. Find the API provider, for example:
    - [Spotify](https://developer.spotify.com/)
    - [YouTube](https://developers.google.com/youtube/v3)
    - [Medium](https://blog.medium.com/welcome-to-the-medium-api-3418f956552)
2. Read through the documentation to make sure the API is workable.  
3. Understand the data structure.  
4. Call the API from your own application and process the data.  





### Reference
1. [What is an API? In English, please.](https://www.freecodecamp.org/news/what-is-an-api-in-english-please-b880a3214a82/)
2. [What is an API](https://www.howtogeek.com/343877/what-is-an-api/)
3. [What exactly is an API](https://medium.com/@perrysetgo/what-exactly-is-an-api-69f36968a41f)
4. [What Are APIs and How Do They Work?](https://www.programmableweb.com/api-university/what-are-apis-and-how-do-they-work)

[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)


