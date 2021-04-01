#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/webscraper'
require_relative '../lib/writer_file'

puts 'Wellcome to computrabajo scraper'
puts 'Select a state to get job information:'
puts '1: Santa Cruz'
puts '2: La Paz'
puts '3: Cochabamba'
puts '4: El Alto'
puts '*: all'

option = gets.chomp.to_i

selection = case option
            when 1
              '/empleos-en-santa-cruz-en-santa-cruz-de-la-sierra?p='
            when 2
              '/empleos-en-la-paz-en-la-paz?p='
            when 3
              '/empleos-en-cochabamba-en-cochabamba?p='
            when 4
              '/empleos-en-la-paz-en-el-alto?p='
            else
              '/ofertas-de-trabajo/?p='
            end

p 'Now need to wait until the process finish'

scrapper = Scrapper.new(selection)
writter = WriteFile.new

writter.html_jobs(scrapper.all_jobs)

p 'Thanks for using this scraper :)'
