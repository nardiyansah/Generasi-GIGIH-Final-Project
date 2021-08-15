# Generasi GIGIH Final Project Backend: Social Media API

This repo contain code for generasi GIGIH Final Project in Backend track. The problem for this project is to make API for simple social media. Like other social media, user can make a post with hashtag and attachment, also user can comment and many detail for the API you can see in API documentation.

## Prerequisite to run application locally

To run this app you need to install some dependency below:
* install Ruby, for developing this app I use ruby 2.7
* install sinatra
```sh
gem install sinatra
```
* install mysql2, in some OS mysql2 need build gem native extension and in linux we can install by `sudo apt-get install ruby2.7-dev`
```sh
gem install mysql2
```
* import the database that I have provided. file `social_media_db.sql`
* setting the environtment variable. please make sure the value of environtmen variable is match with your database environtment.
```sh
export DB_HOST=localhost
export DB_USER=root
export DB_PASS=
export DB_NAME=social_media_db
```
* run this command to start the app
```sh
ruby web.rb
```

## ERD scheme

For the database I build schema like in the picture. I provide an imported sql with name `social_media_db.sql`.
![](https://github.com/nardiyansah/Generasi-GIGIH-Final-Project/blob/main/social%20media.png)
