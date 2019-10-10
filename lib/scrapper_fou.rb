# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

def open_html
  Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
end

def create_names_array(page)
  all_crypto_names = page.xpath('//td[@class="text-left col-symbol"]')
  all_crypto_names_array = []
  all_crypto_names.each do |crypto_name|
    all_crypto_names_array << crypto_name.text
  end
  all_crypto_names_array
end

def create_prices_array(page)
  all_crypto_prices = page.xpath('//a[@class="price"]')
  all_crypto_prices_array = []
  all_crypto_prices.each do |crypto_price|
    all_crypto_prices_array << crypto_price.text
  end
  all_crypto_prices_array
end

def remove_usd_symbol(prices_array)
  prices_array.each do |arr|
    arr.slice!(0)
  end
  prices_array
end

def create_array_of_hashes(all_crypto_names_array, all_crypto_prices_array)
  all_crypto_names_array.zip(all_crypto_prices_array).map { |k, v| { k => v.to_f } }
end

def perform
  page_crypto = open_html
  names_crypto = create_names_array(page_crypto)
  prices_crypto = remove_usd_symbol(create_prices_array(page_crypto))
  all_crypto = create_array_of_hashes(names_crypto, prices_crypto)
  print all_crypto
  puts all_crypto.size
end

perform
