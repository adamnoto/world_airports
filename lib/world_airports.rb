# encoding: UTF-8
require "world_airports/version"
require "scrapper/scrapped"

module WorldAirports
  class WorldAirports::Airport
    attr_accessor :name
    attr_accessor :location
    attr_accessor :iata
    attr_accessor :icao
    attr_accessor :city
    attr_accessor :country
  end

  def self.iata(iata_code)
    airport_dt = Scrapped.instance.airport_of iata_code
    airport = WorldAirports::Airport.new

    if airport_dt
      airport.name = airport_dt[:name]
      airport.location = airport_dt[:location]
      airport.icao = airport_dt[:icao]
      airport.iata = airport_dt[:iata].upcase
      airport.country = airport_dt[:country]
      airport.city = airport.location.split(",")[0]

      return airport
    end

    nil
  end
end
