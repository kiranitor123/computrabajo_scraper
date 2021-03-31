require 'nokogiri'
require 'httparty'

class Scrapper
  attr_reader :url, :jobs_lists, :page_init, :pages_in, :last_page
  def initialize
    @url = 'https://www.trabajopolis.bo/bolsa-de-trabajo-empleos-en-bolivia/Cochabamba/?searchId=142899.1723&action=search&page=1&listings_per_page=10'
    unparsed_page = HTTParty.get(url)
    @parsed_page ||=Nokogiri::HTML(unparsed_page)
    @jobs_lists = []
    @all_jobs = @parsed_page.css('div.numberResults')[0].text.split(' ')[0].gsub(',', '').to_i
    init_pages
  end

  def all_jobs
    get_all_jobs
    @jobs_lists
  end

  private

  def init_pages
    job_list = @parsed_page.css('tr.priorityListing')
    job_list_normal = @parsed_page.css('tr.evenrow')
    @pages_in = job_list.count + job_list_normal.count
    @page_init = 1
    @last_page = (@all_jobs / pages_in.to_f).round
  end

  def get_jobs(job_list)
    job_list.each do |jobs|
      job = {
        title: jobs.css('span.anuncio-estandar-titulo').text,
        company: jobs.css('span.anuncio-estandar-empresa').text,
        location: jobs.css('span.anuncio-estandar-ciudad').text,
        date: jobs.css('span.date').text,
        url: jobs.css('a')[0].attributes['href'].value
      }
      @jobs_lists << job
    end
  end

  def get_all_jobs
    current_page = @page_init
    while current_page <= @last_page
      pagination_url = "https://www.trabajopolis.bo/bolsa-de-trabajo-empleos-en-bolivia/Cochabamba/?searchId=142899.1723&action=search&page=#{current_page}&listings_per_page=10"
      pagination_unparse_page = HTTParty.get(pagination_url)
      pagination_parsed_page ||= Nokogiri::HTML(pagination_unparse_page)
      get_jobs(pagination_parsed_page.css('tr.priorityListing'))
      get_jobs(pagination_parsed_page.css('tr.evenrow'))
      current_page += 1
    end
  end
end
