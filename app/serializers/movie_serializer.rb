class MovieSerializer
  def self.serialize(movies)
    movies.map do |movie|
      {
        id: movie.id,
        type: "movie",
        attributes: {
          title: movie.title,
          vote_average: movie.vote_average
        }
      }
    end
  end
end
