#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/webscraper'
require_relative '../lib/writer_file'

scrapper = Scrapper.new
writter = WriteFile.new


writter.html_jobs(scrapper.all_jobs)
