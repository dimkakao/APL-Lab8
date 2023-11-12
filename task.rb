require 'open-uri'
require 'nokogiri'
require 'csv'

url = 'https://www.hospitalsafetygrade.org/all-hospitals'
html = URI.open(url)
doc = Nokogiri::HTML(html)

choice = ''
while choice != ',' && choice != ';'
  puts 'Choose delimiter 1 - \',\' 2 - \';\''
  choice = gets.chomp.to_s
end

CSV.open('hospitals.csv', 'w', col_sep: choice + ' ') do |csv|
  csv << ['ID ', 'Hospital Name']

  doc.css('div.column1 li').each_with_index do |li, index|
    hospital_name = li.text
    puts 'Hospital Name ' + hospital_name
    csv << [index + 1, hospital_name]
  end
end