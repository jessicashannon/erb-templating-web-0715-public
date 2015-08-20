require 'pry'
class Movie
  attr_accessor :title, :release_date, :director, :summary
  @@Movies = []

  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date
    @director = director
    @summary = summary
    @@Movies << self
  end

  def url
    url_title = @title.downcase.gsub(" ","_") + ".html"
  end

  def self.all
    @@Movies
  end

  def self.new_from_row(*row_array)
    new_movie = Movie.new(*row_array)
  end

  def self.reset_movies!
    @@Movies.clear
  end

  def self.recent
    recent_movies = []
    @@Movies.each do |movie|
      if movie.release_date >= 2012
        recent_movies << movie
      end
    end
    recent_movies
  end

  def self.make_movies!
    txt = open("spec/fixtures/movies.txt").read
    movie_lump = txt.split("\n")
    movie_unlumped = movie_lump.map {|movie| movie.split(" - ")}
    movie_unlumped.each do |movie_array|
      @@Movies << Movie.new(movie_array[0], movie_array[1].to_i, movie_array[2], movie_array[3])
    end
    @@Movies.uniq!
  end

end
