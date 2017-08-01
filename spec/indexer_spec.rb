require 'indexer.rb'

describe Indexer do

  let(:indexer) { Indexer.new }
  csv =  __dir__ + '/indexer_test.csv'

#	CSV.foreach(csv, col_sep: "|", quote_char: "|", headers: true) do |row|
#  	let(:page_indexer) { PageIndexer.new(row) }
#	end

  describe 'initializes the indexer' do
    it 'exists' do
      expect(indexer).to be_truthy
    end
  end

  describe 'reads the seedata file' do
    it 'reads a csv file' do
      indexer.process_csv(csv)
      expect(indexer.web_pages).not_to be_empty
    end
    
    it 'processes a web page from a csv file for :headers' do
      indexer.process_csv(csv)
      expect(indexer.web_pages.first[:headers]).to eq ({"raven"=>1})
    end
    
  end
  
end
