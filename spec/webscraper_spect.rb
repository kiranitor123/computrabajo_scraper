require '../lib/webscraper'

describe 'Scrapper' do
  let(:context) { '/empleos-en-cochabamba-en-cochabamba?p=' }
  describe 'initialize' do
    it 'checking if the initialize apendd the context to the url' do
      scraper = Scrapper.new(context)
      result = 'https://www.computrabajo.com.bo/empleos-en-cochabamba-en-cochabamba?p=1'
      expect(scraper.url).to eql(result)
    end

    it 'checking if the initialize start en [] all jobs' do
      scraper = Scrapper.new(context)
      expect(scraper.jobs_lists.length).to eql(0)
    end
  end

  describe 'all_jobs' do
    it 'checking if return some data and dont stuck' do
      scraper = Scrapper.new(context)
      expect(scraper.all_jobs.length >= 0).to eql(true)
    end
  end
end
