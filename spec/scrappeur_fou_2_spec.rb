# frozen_string_literal: true

require_relative '../lib/scrapper_fou_2.rb'

page = Nokogiri::HTML(open('https://www.annuaire-des-mairies.com/val-d-oise.html'))

describe 'the open_url_val_d_oise method' do
  it 'open the URL of the scrapped website' do
    expect(open_url_val_d_oise).not_to be_nil
  end
end

describe 'the get_townhall_urls method' do
  it 'scrappes all townhall urls and add them in an array' do
    expect(get_townhall_urls(page).class).to eq(Array)
  end
  it 'scrappes exactly 185 townhall urls' do
    expect(get_townhall_urls(page).size).to eq(185)
  end
  it 'townhall urls are non nul & non nil' do
    expect(get_townhall_urls(page).sample(5)).not_to be_nil && eq(0)
  end
end

describe 'the get_townhall_names method' do
  it 'scrappes all townhall names and add them in an array' do
    expect(get_townhall_names(page).class).to eq(Array)
  end
  it 'scrappes exactly 185 townhall names' do
    expect(get_townhall_names(page).size).to eq(185)
  end
  it 'townhall names are non nul & non nil' do
    expect(get_townhall_names(page).sample(5)).not_to be_nil && eq(0)
  end
end


describe 'the get_townhall_email method' do
  it 'scrappes all townhall emails and add them in an array' do
    expect(get_townhall_emails(page).class).to eq(Array)
  end
  it 'scrappes exactly 185 townhall emails' do
    expect(get_townhall_emails(page).size).to eq(185)
  end
  it 'townhall emails are non nul & non nil' do
    expect(get_townhall_emails(page).sample(5)).not_to be_nil && eq(0)
  end
end

describe 'the create_final_array method' do
  it 'merges townhall names & emails and add them in an array' do
    expect(create_final_array(get_townhall_names(page)), get_townhall_emails(page)).class).to eq(Array)
  end
