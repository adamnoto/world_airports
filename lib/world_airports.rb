require "world_airports/version"
require "scrapped"

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
    airport_dt = scrapped_airports[iata_code.to_s.upcase]
    airport = WorldAirports::Airport.new

    airport.name = airport_dt[:name]
    airport.location = airport_dt[:location]
    airport.icao = airport_dt[:icao]
    airport.iata = airport_dt[:iata]
    airport.country = airport_dt[:country]
    airport.city = airport.location.split(",")[0]

    airport
  end
end
