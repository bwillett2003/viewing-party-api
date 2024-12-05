class Api::V1::MoviesController < ApplicationController
  def index
    conn = Faraday.new(url: "https://api.themoviedb.org/3")
    
    response = conn.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.tmdb[:key]}&language=en-US&page=1")
    
    json = JSON.parse(response.body, symbolize_names: true)

    movies = json[:results].first(20).map do |movie|
      {
        id: movie[:id].to_s,
        title: movie[:title],
        vote_average: movie[:vote_average]
      }
    end
    
    render json: { data: MovieSerializer.serialize(movies) }
  end
end