# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

def open_url_val_d_oise
  page = Nokogiri::HTML(open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
  return page
end

def get_townhall_urls(page)
  all_townhall_urls = page.xpath("//a[@class='lientxt']/@href")
  all_townhall_urls_array = []
  all_townhall_urls.each do |each_townhall_url|
  	all_townhall_urls_array << ('https://www.annuaire-des-mairies.com/' + each_townhall_url.text)
  end
  return all_townhall_urls_array
end

def get_townhall_names(townhall_url)
  all_townhall_names_array = []
  townhall_url.each do |each_complete_townhall_url|
  	page = Nokogiri::HTML(open(each_complete_townhall_url.to_s))
  	all_townhall_names = page.xpath('/html/head/title')
  	all_townhall_names_array << all_townhall_names.text[/ - Commune de (.*?) -/, 1]
  end
  return all_townhall_names_array
end

def get_townhall_emails(townhall_url)
  all_townhall_emails_array = []
  townhall_url.each do |each_complete_townhall_url|
  	page = Nokogiri::HTML(open(each_complete_townhall_url.to_s))
  	all_townhall_emails = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
  	all_townhall_emails_array << all_townhall_emails.text
  end
  return all_townhall_emails_array
end

def create_final_array(names, emails)
  names.zip(emails).map { |k, v| { k => v } }
end

def perform
url_val_d_oise = open_url_val_d_oise
urls_townhalls = get_townhall_urls(url_val_d_oise)
names_townhalls = get_townhall_names(urls_townhalls)
emails_townhalls = get_townhall_emails(urls_townhalls)
all_data = create_final_array(names_townhalls, emails_townhalls)
puts all_data
puts all_data.size
end

perform