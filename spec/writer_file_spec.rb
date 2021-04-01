require_relative '../lib/writer_file'

describe 'WriteFile' do
  let(:filename) { 'search.html' }
  describe 'initialize' do
    it 'checking if create a new file' do
      writer = WriteFile.new
      writer.html_jobs([])
      expect(File.file?(filename)).to be true
    end
  end

  describe 'html_jobs' do
    it 'checking if exist the document after put the data' do
      writer = WriteFile.new
      writer.html_jobs([])
      expect(File.exist?(filename)).to be true
    end
  end
end
