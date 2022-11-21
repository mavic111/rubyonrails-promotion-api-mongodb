# README

Ruby on Rails API with MongoDB as the database for promotion website.

There are three models:

- Payment
- Platform
- Promotion

They have one to many association in pairs, Payment-Promotion and Platform-Promotion

Details:

- Ruby Version: 3.1.2
- Database: MongoDB
- ORM: Mongoid

Configuration:

You may configure the Mongoid URI in config/mongoid.yml directly or by creating local_env.yml file.

How to run the server:

`rails s`

How to run rspec test

`bundle exec rspec`
