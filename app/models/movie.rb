class Movie < ActiveRecord::Base


def self.get_ratings
  @find_ratings=[]
  Movie.all.each do |m|
    @find_ratings<<m.rating
    @r=Hash.new
  end
  return @find_ratings.sort.uniq
end

end
