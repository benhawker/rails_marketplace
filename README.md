![Travis Build](https://travis-ci.org/benhawker/rails_marketplace.svg?branch=master)
[![Coverage Status](https://coveralls.io/repos/benhawker/rails_marketplace/badge.svg?branch=master&service=github)](https://coveralls.io/github/benhawker/rails_marketplace?branch=master)

=======
A Marketplace application built with Rails 4.2 for learning purposes.


Development and Testing instructions
========

* RVM, Ruby Version, Update Gems, Xcode Command-Line Tools
```
rvm install 2.2.1
rvm list
rvm use ruby-2.2.1
rvm gemset create rails_marketplace_app
rvm --ruby-version use 2.2.1@arace_launch_app
xcode-select --install
gem install bundler
gem install nokogiri -v '1.6.6.2'
bundle install -V
```

* Install Homebrew and ImageMagick
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install imagemagick
```

* Run tests
```
rake db:create db:migrate RAILS_ENV="test"
rspec
```

* Run server
```
rake db:create db:migrate RAILS_ENV="development"
rails s
```

* PostgreSQL
```
psql -l
psql rails_marketplace_development
\d
select * from users;
delete from users;
\q
```
>>>>>>> 5c5d90f727303b567089c1077a720a4167e09e57
