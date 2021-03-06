# Generasi GIGIH Final Project Backend: Social Media API

![](https://github.com/nardiyansah/Generasi-GIGIH-Final-Project/blob/main/assets/generasi%20gigih.png)
This repo contains code for generasi GIGIH Final Project in the Backend track. The problem for this project is to make an API for simple social media. Like other social media, users can make a post with hashtags and one attachment, also users can comment and many details for the API you can see in the API documentation.

## Prerequisite to run application locally

To run this app you need to install some dependencies below:
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
* setting the environtment variable. please make sure the value of the environment variable matches your database environment.
```sh
export DB_HOST=localhost
export DB_USER=root
export DB_PASS=
export DB_NAME=social_media_db
```
* clone this repo and run this command to start the app
```sh
ruby web.rb
```

## Test

for testing I use rspec and simplecov. Please make sure you already installed it.
```sh
gem install rspec
```
```sh
gem install simplecov
```
to run the test you can run by command below. (actually i prefer to use format document in rspec)
```sh
rspec -f d
```
to test endpoint you can go to API documentation and import the url from there or you can import the collection from exported collection in `postman collection` folder.

## API Documentation

I create API documentation with postman API documentation tool. You can visit the link below to see the detail about API

[API Documentation](https://documenter.getpostman.com/view/12017937/Tzz7QdnQ)

In postman I use some global variable. Please make sure you provide it in your postman.

### Global variables

name | initial value | type
---- | ------------- | ----
base_url | http://34.131.84.223:4567 (url GCP machine) | string
user_id | 1 | int
tag | tag | string
post_id | 1 | int

## ERD scheme

For the database I build schema like in the picture. I provide an imported sql with name `social_media_db.sql`.

![](https://github.com/nardiyansah/Generasi-GIGIH-Final-Project/blob/main/assets/social%20media.png)

### Note for erd & database

I write some notes for you easier to understand my erd and database schema.
* for field `created_time` I use the type `TIMESTAMP`. I think this type is easier for me if I want to group data by time.
* field `attachment` stores the path where the attachment file is stored. For the name of the file, I use the name of tempfile. Just to make it easier for me, I don't create a function to generate a unique name for the attachment file. For now the extension that can be save for attachment file is `.jpg`, `.png`, `.gif`, `.mp4` and other extension outside picture and video format.
* field `tag` contains the hashtag in lowercase.

### Coverage

![](https://github.com/nardiyansah/Generasi-GIGIH-Final-Project/blob/main/assets/coverage.png)

### strange thing I found when developing this app

* when i want to send many hashtags and attachment, i got just one hashtag. After surfing the internet, i found the strange way. Add `[]` in the end of parameter name (it's so funny ????). this the references https://dev.to/jesusislord3/getting-arrays-in-the-params-hash-for-sinatra-4agh
