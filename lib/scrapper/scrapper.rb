require "watir"
require "pp"

def scrape
  b = Watir::Browser.new :chrome

  b.goto "http://en.wikipedia.org/wiki/List_of_airports"

  links_to_scrape = b.p(xpath: "//p[strong[@class='selflink' and contains(text(), 'List') and contains(text(), 'airport')]]")
  links_to_scrape = links_to_scrape.as.to_a
  links_to_scrape.map! { |a| a.attribute_value("href") }

  links_to_scrape

  airports ||= {}

  links_to_scrape.each.with_index(1) do |link, idx|
    puts "SCRAPING #{link}"
    b.goto link

    table = b.table(xpath: "//table[thead[tr[th[text()='IATA']]]]")
    next unless table.present?

    cur_airp = {}
    table.trs.each do |airport_row|
      next if airport_row.class_name =~ /sortbottom/
      iata = airport_row.tds[0].text.strip
      icao = airport_row.tds[1].text
      name = airport_row.tds[2].text
      loc = airport_row.tds[3].text
      city = loc.split(",")[0].strip
      country = loc.split(",")[-1].strip

      next if iata.length > 3

      cur_airp[iata.upcase] = {
        iata: iata,
        name: name,
        icao: icao,
        city: city,
        country: country,
        location: loc
      }

      pped = PP.pp(cur_airp, "")
      File.write("scrapped_#{idx}.rb", %Q{
      # encoding: UTF-8
      def airp_#{idx}
        #{pped}
      end
      })
    end
    airports.merge!(cur_airp)
  end

  airports
end