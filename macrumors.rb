require 'open-uri'
require 'nokogiri'
require 'debugger'

require 'term/ansicolor'
include Term::ANSIColor

class MacRumors
  def self.news(devices = ['MacBook_Pro', 'MacBook_Air'])
    doc = Nokogiri::HTML(open('http://buyersguide.macrumors.com/'))

    result = {}

    devices.each do |device|
      result[device] = find_rumors(doc, device)
    end

    result
  end

  def self.find_rumors(doc, device)
    rumors = []
    el = doc.css("a[name=#{device}]").first
    el = el.next while el[:class] != 'guide'
    
    rumor_divs = el.css('.rumor')
    rumor_divs.each do |rumor|
      a = rumor.css('a')
      next unless /last/.match(rumor[:class]).nil?
      rumors << a.text()
    end
    rumors
  end
end

def main
  puts 'Loading...'
  news = MacRumors.news
  puts ''
  news.each do |device, rumors|
    puts blue(bold(device))
    rumors.each do |rumor|
      puts green(bold("  - #{rumor}"))
    end
    puts ''
  end
end

main if __FILE__ == $0
