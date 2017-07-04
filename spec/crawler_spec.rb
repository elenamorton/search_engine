require 'crawler.rb'

describe Crawler do

  seeds = [ 'file://' + __dir__ + '/fake_page.html']
  let(:crawler) {Crawler.new(seeds)}

  it "exist" do
    expect(crawler).to be_truthy
  end

  it "initializes with the seeds" do
    expect(crawler.seeds).to eq(['file://' + __dir__ + '/fake_page.html'])
  end

  it "fetches the urls in the domain site of each seeds" do
		crawler.fetch_data
    expect(crawler.urls).to eq(['http://www.google.com', 'http://www.youtube.com', 'http://www.bbc.co.uk'])
  end

	it "fetches the keywords from the domain of each seed" do
		crawler.fetch_data
		expect(crawler.keywords).to eq(['test', 'fake page', 'Search'])
	end

  it "fetches the text within html paragraph tags" do
    crawler.fetch_data
    expect(crawler.paragraph).to eq("Lorem ipsum dolor sit amet consectetur adipiscing elit Quisque et tortor elementum Nulla ullamcorper interdum nisl a fermentum metus suscipit at")
  end
end
