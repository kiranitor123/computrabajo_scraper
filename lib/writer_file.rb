class WriteFile
  attr_reader :file

  URL1 = '<h3><a href="'.freeze
  URL2 = '"style="color:black;">'.freeze
  URL3 = '</a></h3>'.freeze
  def initialize
    @file = File.open('search.html', 'w')
    build_html
  end

  def html_jobs(jobs)
    amount = "<h2> Amount : #{jobs.length} </h2>"
    @file.puts amount
    jobs.each { |job| update_html(job) }
    end_html
  end

  private

  def update_html(job)
    title = "<h2> Title : #{job[:title]} </h2>"
    company = "<h2> Company : #{job[:company]} </h2>"
    description = "<p> description : #{job[:description]} </p>"
    date = "<span> Date : #{job[:date]} </span>"
    url = "#{URL1} #{job[:url]} #{URL2} Link_job #{URL3}"
    @file.puts title
    @file.puts company
    @file.puts description
    @file.puts date
    @file.puts url
  end

  def end_html
    File.open('temp/end.txt').each do |line|
      @file.puts line
    end
    close_file
  end

  def build_html
    File.open('temp/begin.txt').each do |line|
      @file.puts line
    end
  end

  def close_file
    @file.close
  end
end
