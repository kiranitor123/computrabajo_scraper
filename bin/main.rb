#!/usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'byebug'

def scrapper
  url = 'https://www.trabajopolis.bo/bolsa-de-trabajo-empleos-en-bolivia/Cochabamba/?searchId=142899.1723&action=search&page=1&listings_per_page=10'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  job_list = parsed_page.css('tr.priorityListing')
  pages_in = job_list.count
  page = 1

  all_jobs = parsed_page.css('div.numberResults')[0].text.split(' ')[0].gsub(',', '').to_i
  last_page = (all_jobs.to_f / pages_in.to_f).round
  jobslists = []
  job_list.each do |jobs|
    job = {
      title: jobs.css('span.anuncio-estandar-titulo').text,
      company: jobs.css('span.anuncio-estandar-empresa').text,
      location: jobs.css('span.anuncio-estandar-ciudad').text,
      date: jobs.css('span.date').text,
      ulr: jobs.css('a')[0].attributes['href'].value
    }
    jobslists << job
  end
  byebug
end

scrapper
