require "rails_helper"

RSpec.describe MovieGateway do
  describe "get movies from fetch_top_rated_movies" do
    it "can get list for top rated and returns json response" do
      stubbed_response = File.read("spec/fixtures/tmdb_top_rated_search.json")

      stub_request(:get, "#{MovieGateway::BASE_URL}/3/movie/top_rated")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key] })
        .to_return(status: 200, body: stubbed_response)

      movies = MovieGateway.fetch_top_rated_movies

      expect(movies).to be_an Array
      expect(movies.count).to eq(20)
      expect(movies.first).to be_a(Movie)

      first_movie = movies.first
      expect(first_movie.id).to be_a(Integer)
      expect(first_movie.title).to be_a(String)
      expect(first_movie.vote_average).to be_a(Float)
    end
  end

  describe "get movies from .search_movies" do
    it "can get list of movies based on search query" do
      stubbed_response = File.read("spec/fixtures/tmdb_params_search.json")

      stub_request(:get, "#{MovieGateway::BASE_URL}/3/search/movie")
        .with(query: { api_key: Rails.application.credentials.tmdb[:key], query: "Lord of the Rings" })
        .to_return(status: 200, body: stubbed_response)

      movies = MovieGateway.search_movies("Lord of the Rings")
      
      expect(movies).to be_an Array
      expect(movies.count).to eq(19)
      expect(movies.first).to be_a(Movie)

      first_movie = movies.first
      expect(first_movie.id).to be_an(Integer)
      expect(first_movie.title).to eq("The Lord of the Rings: The Fellowship of the Ring")
      expect(first_movie.vote_average).to be_a(Float)
      expect(first_movie.vote_average).to eq(8.4)
    end
  end
end