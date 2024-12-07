class MovieGateway
  BASE_URL = "https://api.themoviedb.org"

  def self.conn
    Faraday.new(url: BASE_URL)
  end

  def self.fetch_top_rated_movies(api_key = Rails.application.credentials.tmdb[:key])
    response = conn.get("/3/movie/top_rated", { api_key: api_key })
    parse_response(response)
  end

  def self.search_movies(query, api_key = Rails.application.credentials.tmdb[:key])
    response = conn.get("/3/search/movie", { api_key: api_key, query: query })
    parse_response(response)
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)[:results].first(20).map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
