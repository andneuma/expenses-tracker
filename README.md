## Installation

* clone the repository

* get ruby version

* get MySQL

## Setup

#### Package requirements
Install neccessary packages (gems) inside the project folder using
```
sudo gem install bundler

bundle install
```
#### Basic Mailer scheduling
Provide account information for mail accounts used for sending app emails in environment configuration files `/config/environments/*.rb`. Make sure that no secret keys, passwords, etc. are stored here. Use environment variables via `export <VARNAME>="<CONTENT>"` instead.
If you want to use [figaro](https://github.com/laserlemon/figaro) initialize it via `figaro install` which creates `/config/application.yml` which you can modify to your needs.

The application makes use of `wheneverize` gem for *scheduling* cron job _digest emails_.

You can modify the default settings (weekly digest of expense lists on sunday evening) in `/config/schedule.rb`

Update your cron job list with

`whenever --update-crontab` and check whether everything went fine with ExpenseListsHelper

`whenever` or `crontab -l`

_If you're using RVM and your cronjobs won't get executed try_
```
rvm use <ruby_version>
bundle install
```

#### Development
Create and initialize database with

`RAILS_ENV=development bundle exec rake db:create db:migrate`

Start the App in `:development` environment using

`rails s -e development`

You can access the site locally in the browser via `127.0.0.1:3000` or `localhost:3000`

#### Configure Production environment

For a small amount of users you can try to use the standard webserver supplied by Rails (WEBrick).

Setup the database for production via `RAILS_ENV=production bundle exec rake db:create db:migrate`

You can now start the server via `rails s -e production -p 80 -b 0.0.0.0`

Be sure that no other webserver is blocking port 80, the website is available via `https://<server-hostname>`

#### Create User accounts
As app admin create user accounts directly inside the rails console

`User.new(name: '<some_name>', email: 'some_email', password: '<some_passwd>, password_confirmation: '<some_passwd>').save`

Users can edit these settings after login via the web interface providing their email address and the password.
