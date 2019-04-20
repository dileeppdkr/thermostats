# README

Web API for storing readings from IoT thermostats and reporting a simple statistics on them.

Things you may want to cover:

## Ruby version
	ruby '2.3.1'
## System dependencies
	gem 'rails', '~> 5.2.3' 
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
	bundle install
	rails s
 API's:
	#Create Thermostats (Post thermostats)
	curl -X POST \
		http://localhost:3000/thermostats \
		-H 'Content-Type: application/x-www-form-urlencoded' \
		-H 'Postman-Token: 45816116-d251-4e3c-a972-6e97b29040e1,c26166d3-d73a-416d-8b63-088ca49a591d' \
		-H 'cache-control: no-cache,no-cache' \
		-d 'location=BTM%20sector%202'

	Response:
	{
	  "thermostats": {
	      "id": 30,
	      "household_token": "c48453eb-0df4-45ca-909e-c7357fac96f6",
	      "location": "BTM sector 2"
	  }
	}

	#Create Readings for a thermostat (Post reading)
	curl -X POST \
		http://localhost:3000/readings \
		-H 'Content-Type: application/x-www-form-urlencoded' \
	  -H 'Postman-Token: c13766c4-047e-4531-8d19-8c275e102333' \
	  -H 'cache-control: no-cache' \
	  -d 'household_token=aaad3985-9a70-4959-85b8-eb3700cf1b1a&temperature=34.4&humidity=11&battery_charge=1053'

	Response:
	{
	  "sequence_id": 29
	}

	#GET Reading 
	curl -X GET \
	'http://localhost:3000/readings/26?household_token=6306a49e-d604-4860-8a0a-3188671e7a26' \
	-H 'Postman-Token: 56f2f698-23c2-4c11-b895-fba65622f4d1' \
	-H 'cache-control: no-cache'

	Response:
	{
	  "id": 26,
	  "thermostat_id": 23,
	  "temperature": 43.4,
	  "humidity": 26,
	  "battery_charge": 1453
	}

	#GET Stats
	curl -X GET \
	'http://localhost:3000/readings?household_token=aaad3985-9a70-4959-85b8-eb3700cf1b1a' \
	-H 'Postman-Token: e58494d2-0b44-4caf-95a1-5b2e6f77550a' \
	-H 'cache-control: no-cache'

	Response:
	{
	  "thermostat_data": [
	      {
	          "temperature": {
	              "avg": 46.4,
	              "min": 34.4,
	              "max": 52.4
	          }
	      },
	      {
	          "humidity": {
	              "avg": 20.33,
	              "min": 11,
	              "max": 25
	          }
	      },
	      {
	          "battery_charge": {
	              "avg": 1186.33,
	              "min": 1053,
	              "max": 1253
	          }
	      }
	  ]
	}

 
## Test:
	rspec spec