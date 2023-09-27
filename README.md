## Rails Promotion

Ruby on Rails API with MongoDB as the database for promotion website.

There are three models:

- Payment
- Platform
- Promotion

They have one to many association in pairs, Payment-Promotions and Platform-Promotions

## Features

- CRUD endpoints
- Pagination with limit and offset
- Abusive request throttling

## Stack

- Ruby Version: 3.2.2
- Rails Version: 7.0.8
- Database: MongoDB
- ORM: Mongoid

## Configuration

You may configure the Mongoid URL first in config/local_env.yml file.

#### Create database collections

```bash
rails db:mongoid:create_collections
```

#### Run the server

```bash
rails s
```

#### Run rspec test

```bash
bundle exec rspec
```

#### Create secret key base

```
rails secret
```
