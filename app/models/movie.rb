class Movie < ActiveRecord::Base
    def self.ratings_array
    all_ratings = []
    self.all.each{|film| all_ratings.push(film.rating) if not all_ratings.include? film.rating}
    all_ratings.sort! 
    end
end
