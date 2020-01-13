# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 5.2.4.1

* System dependencies

* Configuration

* Database creation mysql2

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key: true|
|name|string|null: false, index: true|
|email|string|null: false, unique: true|
|password|string|null: false|
|authority|boolean|default: false|

### Association

- has_many :groups
- has_many :tasks

## groupsテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key: true|
|name|string|null: false|
|authority|boolean|default: false|
|user|references|null: false, foreign_key: true|

### Association

- has_many   :tasks
- bolongs_to :users

## tasksテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key: true|
|title|string||
|priority|integer|index: true|
|description|string||
|place|string||
|target_dt|date|index: true|
|warning_st_days|integer||
|warning_dt|date|index: true|
|completed|boolean|default: false|
|complete_at|datetime||
|group|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association

- belongs_to :groups
