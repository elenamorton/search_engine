require 'csv'
require_relative 'page_indexer'

DATA_FILE = 'seeddata.csv'
COLUMN_SEPARATOR = '|'

class Indexer
  attr_reader :web_pages

  def initialize
    @web_pages = []
  end

  def process_csv(filename = DATA_FILE)
    CSV.foreach(filename, col_sep: COLUMN_SEPARATOR, quote_char: "|", headers: true) do |row|
      page_indexer = PageIndexer.new(row)
      page_hash = page_indexer.process_page
			@web_pages << page_hash
		end
  end
end
