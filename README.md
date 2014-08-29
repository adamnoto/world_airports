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

## Recent enchancements

29 August 2014:
Adding some new 1000+ airports: AKV, AOQ, AGM, ACA, AGU, AJS, AZG, ACN, AZP, AWK, AFO, ...ZTM, ZTB, ZFN, ZWL, ZAC, ZMH, ZAA, ZBM, ZFW, ZFA, ZGF, ZHP, ZUC, ZJG, ZGR, ZNU, ZNG, ZFB, ZPO, ZSW, ZQS, ZSP, ZFL, ZST, ZJN, ZTS, ZIH, ZLO, ZCL, ZMM, ZMD, ZOS, ZPC, ZCO, ZAL, ZUD, ZLR, ZIC, ZBL, ZBO, ZNE, ZGL, ZVG, ZTA, ZQN, ZGU, ZSA, ZSS, ZUE, ZKM, ZWA, ZVA, ZZU, ZLG, ZND, ZAR, ZSE, ZIG, ZEC, ZLX, ZNZ, ZKB, ZGM, ZYR, ZAD, ZAG, ZDN, ZBE, ZAO, ZQW, ZWN, ZTH, ZBK, ZXQ, ZZO, ZIX, ZKP, ZAZ, ZRH, ZTR, ZAJ, ZTU, ZXT, ZYL, ZHM, ZGC, ZQZ, ZHA, ZAT, ZHY, ZUH, ZYI, ZMY, ZER, ZRM, ZEG, ZRI, ZKL, ZBR, ZAH, ZVK, ZBY, ZIZ, ZEN, ZAM, ZUL, ZDY, ZCN, ZNC, ZPH, ZPQ, ZWS, ZZV, SNO, PHS, TLI, WNI, NST, NAW, DTB, SQG, SOQ, SWQ, TMC, TTE, PSU, RTI, SXK, YKR, RRZ, PLW, PGK, PKN, PUM, PSJ, DQJ, WUB, TGG, OTI, PKY, FLZ. Read the complete list of new airports in the history file.