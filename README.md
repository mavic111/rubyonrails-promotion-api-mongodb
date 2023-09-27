# README

Ruby on Rails API with MongoDB as the database for promotion website.

There are three models:

- Payment
- Platform
- Promotion

They have one to many association in pairs, Payment-Promotion and Platform-Promotion

Details:

- Ruby Version: 3.2.2
- Database: MongoDB
- ORM: Mongoid

Configuration:

You may configure the Mongoid URL first in config/local_env.yml file.

## Create database collections

```bash
rails db:mongoid:create_collections
```

## Run the server

```bash
rails s
```

## Run rspec test

```bash
bundle exec rspec
```

## Create secret key base

```
rails secret
```
