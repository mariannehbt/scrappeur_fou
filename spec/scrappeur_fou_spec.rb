   # frozen_string_literal: true

require_relative '../lib/scrapper_fou.rb'

page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))

describe 'the open_html method' do
  it 'open the URL of the scrapped website' do
    expect(open_html).not_to be_nil
  end
end

describe 'the create_names_array method' do
  it 'scrappes all crypto names and add them in an array' do
    expect(create_names_array(page).class).to eq(Array)
  end
  it 'scrappes at least 2000 crypto names' do
    expect(create_names_array(page).size).to be > 2000
  end
  it 'names are non nul & non nil' do
    expect(create_names_array(page).sample(5)).not_to be_nil && eq(0)
  end
end

describe 'the create_prices_array method' do
  it 'scrappes all crypto prices and add them in an array' do
    expect(create_prices_array(page).class).to eq(Array)
  end
  it 'scrappes at least 2000 crypto prices' do
    expect(create_prices_array(page).size).to be > 2000
  end
  it 'prices are non nul & non nil' do
    expect(create_prices_array(page).sample(5)).not_to be_nil && eq(0)
  end
end

describe 'the remove_usd_symbol method' do
  it 'removes all $ symbols from prices' do
    expect(remove_usd_symbol(create_prices_array(page)).include?('$')).to eq(false)
  end
end

describe 'the create_array_of_hashes method' do
  it 'merges crypto names & prices and add them in an array' do
    expect(create_array_of_hashes((create_names_array(page)), remove_usd_symbol(create_prices_array(page))).class).to eq(Array)
  end
  # it 'converts prices into float' do
  #   expect(create_array_of_hashes((create_names_array(page)), remove_usd_symbol(create_prices_array(page))).sample.values.class).to eq(Float)
  # end
end
