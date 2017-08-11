#!/usr/bin/env ruby

require 'csv'
require_relative 'crawler'
require_relative 'ranking'
require_relative 'indexer'

crawler = Crawler.new(['http://bbc.co.uk', 'https://en.wikipedia.org/wiki/Web_crawler', 'http://www.makersacademy.com'])
crawler.fetch_data

indexer = Indexer.new
indexer.process_csv

#welcome to user
ascii_spider = File.read('./ascii_spider')
puts ascii_spider

#gets input from User
puts "Enter search keyword"
@query = gets.downcase.chomp
puts "You have entered: " + @query
puts ""

list = []

#creates Rankers, stores them in array
indexer.web_pages.each do |page_hash|
	ranker = Ranker.new(page_hash, @query)
	ranker.calculate_total_score
	list << ranker unless ranker.word_score.zero?
end

#sorts list (highest score at top)
sorted_list = list.sort_by do |ranker|
  -ranker.word_score
end

#returns info from CSV file relevant to seed in ranker
puts "Results:"
sorted_list.map do |ranker|
	CSV.foreach(DATA_FILE, col_sep: "|", quote_char: "|", headers: true) do |row|
		row[4] = "Description not available" if row[4] == "0"
    	puts "#{row[1]} \n #{row[4]}" if row[0] == ranker.hash[:id].keys[0]
	end
end
