require 'erb'
require 'pry'

class SiteGenerator

  def make_index!
    open('_site/index.html', 'a') do |f|
      f << "<!DOCTYPE html><html><head><title>Movies</title></head><body><ul>"
    end

    Movie.all.each do |movie|
      open('_site/index.html', 'a') do |f|
        f << "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>"
      end
    end

    open('_site/index.html', 'a') do |f|
      f << "</ul></body></html>"
    end
  end

  def to_html

  end
#
  def generate_pages!
    template = File.read('lib/templates/movie.html.erb')
    erb = ERB.new(template)
    Movie.all.map do |movie|
      File.open("_site/movies/#{movie.url}", "w+") do |f|
        f.puts erb.result(binding)
      end
    end
  end

end
