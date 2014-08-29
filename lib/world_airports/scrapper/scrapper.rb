require "watir"
require "pp"
require "nokogiri"
require "selenium-webdriver"

@@airports = {}

def scrape
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 600

  # capab = Selenium::WebDriver::Remote::Capabilities.phantomjs("phantomjs.page.settings.javascriptEnabled" => false)
  @browser = Watir::Browser.new :phantomjs, http_client: client

  scrape_flightstats
  puts "#{@@airports.length} :: #{@@airports.keys}"
  scrape_wikipedia
  puts "#{@@airports.length} :: #{@@airports.keys}"

  idx = 1
  ("a".."z").each do |ap_initial|
    # only process which initial is the same
    idx += 1

    airports_by_initials = {}
    @@airports.each_pair do |iata, hash|
      next unless iata.to_s[0].upcase == ap_initial.upcase
      airports_by_initials[iata.to_s.upcase] = hash
    end

    airports_by_initials_str = PP.pp(airports_by_initials, "")
    File.write("scrapped_#{idx}.rb",
%Q{# encoding: UTF-8
def airp_#{idx}
  #{airports_by_initials_str}
end
})
  end

  @browser.close
end

def scrape_wikipedia
  @browser.goto "http://en.wikipedia.org/wiki/List_of_airports"

  links_to_scrape = @browser.p(xpath: "//p[strong[@class='selflink' and contains(text(), 'List') and contains(text(), 'airport')]]")
  links_to_scrape = links_to_scrape.as.to_a
  links_to_scrape.map! { |a| a.attribute_value("href") }

  links_to_scrape = links_to_scrape[1..-1]

  airports ||= {}

  links_to_scrape.each.with_index(1) do |link, idx|
    puts "SCRAPING #{link}"
    @browser.goto link
    sleep 8

    pg = Nokogiri::HTML @browser.html
    table = pg.xpath "//table[thead[tr[th[text()='IATA']]]]"

    cur_airp = {}
    i = 0
    table.css("tr").each do |airport_row|
      next if airport_row["class"] =~ /sortbottom/
      next if airport_row.css("td").empty?

      iata = airport_row.css("td")[0].text.strip
      icao = airport_row.css("td")[1].text
      name = airport_row.css("td")[2].text
      loc = airport_row.css("td")[3].text
      city = loc.split(",")[0].strip
      country = loc.split(",")[-1].strip

      puts iata if i == 0
      i += 1 if i == 0
      next if iata.length > 3

      cur_airp[iata.upcase] = {
        iata: iata.upcase,
        name: name,
        icao: icao,
        city: city,
        country: country,
        location: loc
      }
    end
    airports.merge!(cur_airp)
  end

  @@airports.merge!(airports)
end

def scrape_flightstats
  puts "scraping flightstat"

  airports = {}

  @browser.goto "http://www.flightstats.com/go/Airport/airportsOfTheWorld.do"
  links_to_scrape = @browser.as(xpath: "//div[@class='uiComponentBody']/p/a[contains(@href, 'country')]")
  links_to_scrape = links_to_scrape.to_a
  links_to_scrape.map! { |a| a.attribute_value("href").gsub(/;jsessionid.+\?/i, "?") }

  puts "LINKS TO SCRAPE: #{links_to_scrape}"

  def scrape_flightstat_table
    puts "scraping the table"
    airports = {}
    pg = Nokogiri::HTML @browser.html
    begin
      sleep 5
      country = pg.xpath("//div[@class='uiComponent674'][1]/h2")[0].text.split[-1].strip
      rows = pg.xpath("//table[@class='tableListingTable']/tbody/tr[td[4][text() and string-length(text()) > 0]]")
    rescue => e
      puts e.message
      retry
    end

    i = 0
    rows.each do |row|
      tds = row.css("td")
      name = tds[1].text.strip
      city = tds[2].text.strip
      iata = tds[3].text.strip
      icao = tds[4].text.strip

      next if iata.length > 3
      airports[iata] = {
          iata: iata,
          name: name,
          city: city,
          icao: icao,
          country: country,
          location: "#{city}, #{country}"
      }
      puts iata if i == 0
      i += 1 if i == 0
    end
    puts "GOT #{airports.keys.length} AIRPORTS: #{airports.keys[0..4]} and others"

    airports
  end

  links_to_scrape.each do |link|
    puts "scrapping: #{link}"
    begin
      @browser.goto link
    rescue => e
      puts e.message
      retry
    end

    # check if there's further link
    further_links = @browser.a(xpath: "//div[@class='uiComponentBody']/a")
    if further_links.present?
      further_links = @browser.as(xpath: "//div[@class='uiComponentBody']/a")
      further_links = further_links.to_a
      further_links.map! { |l| l.attribute_value("href") }

      further_links.each do |fl|
        @browser.goto fl
        airports = scrape_flightstat_table
      end
    else
      airports = scrape_flightstat_table
    end

    @@airports.merge!(airports)
  end
end