class Api::V1::MoviesController < ApplicationController
  def index
    if params[:query].present?
      movies = MovieGateway.search_movies(params[:query])
    else
      movies = MovieGateway.fetch_top_rated_movies
    end

    render json: { data: MovieSerializer.serialize(movies) }
  end
end
