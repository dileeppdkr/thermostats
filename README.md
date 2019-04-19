# README

Web API for storing readings from IoT thermostats and reporting a simple statistics on them.

Things you may want to cover:

## Ruby version
	ruby '2.3.1'
## System dependencies
	gem 'sidekiq', '3.3.3'
	gem 'redis'
	gem 'redis-namespace'
	gem 'redis-rails'
	gem 'redis-rack-cache'
## Installation 
	Installing RVM:

    1  sudo apt-get update
    2  sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev
    3  sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
    4  curl -L https://get.rvm.io | bash -s stable
    5  source ~/.rvm/scripts/rvm
    6  echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc

    Installing Ruby :

    7  rvm install
    8  rvm update 2.0.0
    9  rvm use 2.0.0 --default
    10  ruby -v

   Installing Rails:
	11  gem install rails ~> 5.2.3

## Usage:
	git checkout https://github.com/dileeppdkr/thermostats.git
	cd thermostats
	rails s
 API:


 Expected output:
 
## Test:
	rspec spec