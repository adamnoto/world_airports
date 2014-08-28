# WorldAirports

world_airports is a lightweight ruby gem that allow you to get several information such as airport name, location, city and country based on an IATA code.

## Installation

Add this line to your application's Gemfile:

    gem 'world_airports'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install world_airports

## Usage

    require 'world_airports'
    WorldAirports.iata("CGK")
    
The code above will return a class of WorldAirports::Airport, on which instance you can invoke these methods:

    name
    location
    iata
    icao
    city
    country
    
ICAO is not guaranteed to be available for all the data, but other fields are.

## Contributing

Please don't hesitate to contact me, I have twitter @adamvim, for anything: reporting bug, missing airport, etc.

Otherwise:

1. Fork it ( https://github.com/[my-github-username]/world_airports/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request