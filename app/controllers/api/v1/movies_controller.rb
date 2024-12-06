class Api::V1::MoviesController < ApplicationController
  def index
    if params[:query].present?
      search_movies
    else
      top_rated_movies
    end
  end

  private

  def top_rated_movies
    conn = Faraday.new(url: "https://api.themoviedb.org/3")
    
    response = conn.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.tmdb[:key]}")
    
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

  def search_movies
    conn = Faraday.new(url: "https://api.themoviedb.org/3")
  
    response = conn.get("/3/search/movie", { api_key: Rails.application.credentials.tmdb[:key], query: params[:query] })
  
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