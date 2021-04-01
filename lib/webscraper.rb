require 'nokogiri'
require 'httparty'
require 'byebug'
class Scrapper
  attr_reader :url, :jobs_lists, :page_init, :pages_in, :last_page

  URL = 'https://www.computrabajo.com.bo'.freeze

  def initialize(keyword)
    @url = URL + keyword + 1.to_s
    p @url
    @keyword = keyword
    unparsed_page = HTTParty.get(@url)
    @parsed_page ||= Nokogiri::HTML(unparsed_page)
    @jobs_lists = []
    @all_jobs = @parsed_page.css('div.breadtitle_mvl').text.split(' ')[0].gsub(',', '').to_i
    init_pages
  end

  def all_jobs
    scraper_jobs
    @jobs_lists
  end

  private

  def init_pages
    job_list = @parsed_page.css('div.bRS.bClick')
    @pages_in = job_list.count
    @page_init = 1
    @last_page = (@all_jobs / pages_in.to_f).ceil
  end

  def job_listing(job_list)
    job_list.each do |jobs|
      job = {
        title: jobs.css('h2.tO').text,
        company: jobs.css('div.w_100.fl.mtb5.lT').text.split(' ').join(' '),
        description: jobs.css('p').text,
        date: jobs.css('span.dO').text,
        url: URL + jobs.css('a')[0].attributes['href'].value
      }
      @jobs_lists << job
    end
  end

  def scraper_jobs
    current_page = @page_init
    while current_page <= @last_page
      pagination_url = URL + @keyword + current_page.to_s
      pagination_unparse_page = HTTParty.get(pagination_url)
      pagination_parsed_page ||= Nokogiri::HTML(pagination_unparse_page)
      job_listing(pagination_parsed_page.css('div.bRS.bClick'))
      current_page += 1
    end
  end
end
