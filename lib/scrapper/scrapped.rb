# encoding: UTF-8
require "singleton"

require "./scrapped_0.rb"
(2..27).each do |i|
  puts "requiring: #{i}"
  require "./scrapped_#{i}.rb"
end

class Scrapped
  include ::Singleton

  def all_airports
    airports = {}

    ((2..27).to_a + [0]).each do |method_id|
      airports.merge!(send("airp_#{method_id}"))
      puts "loaded #{method_id}: #{airports.keys.length}"
    end

    # validate the airport
    airports.each do |iata, airp|
      raise "must have IATA: #{iata}" if (airp[:iata].nil?)
      raise "iata as key '#{iata}', and iata inputted '#{airp[:iata]}', must be equal" unless iata.upcase.to_s == airp[:iata].upcase.to_s
      raise "must have name: #{iata}" if (airp[:name].nil?)
      raise "must have country: #{iata}" if (airp[:country].nil?)
      raise "must have city: #{iata}" if (airp[:city].nil?)
      raise "must have location: #{iata}" if (airp[:location].nil?)
    end

    airports
  end

  def airport_of(code)
    data = all_airports[code.to_s.upcase]
    return data unless data.nil?
    data = all_airports[code.to_s.upcase.to_sym]
    return data unless data.nil?
    nil
  end
end