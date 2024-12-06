require "rails_helper"

RSpec.describe "TMDB API" do
  describe "index" do
    it "can retrieve the first 20 top rated movies" do
      stubbed_response = File.read("spec/fixtures/tmdb_top_rated_search.json")

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.tmdb[:key]}")
        .to_return(status: 200, body: stubbed_response)

      get "/api/v1/movies"

      json = JSON.parse(response.body, symbolize_names: true)
      
      json[:data].each do |movie|
        expect(movie).to have_key(:id)
        expect(movie[:id]).to be_a(String)

        expect(movie).to have_key(:type)
        expect(movie[:type]).to eq("movie")

        expect(movie).to have_key(:attributes)
        expect(movie[:attributes]).to have_key(:title)
        expect(movie[:attributes][:title]).to be_a(String)
        
        expect(movie[:attributes]).to have_key(:vote_average)
        expect(movie[:attributes][:vote_average]).to be_a(Float)
      end
    end

    xit "can retrieve movies based on seach query from the request" do
      stubbed_response = File.read("spec/fixtures/tmdb_params_search.json")

      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=Lord%20of%20the%20Rings")
        .to_return(status: 200, body: stubbed_response)
      
      get "/api/v1/movies", params: { query: "Lord of the Rings"}

      json = JSON.parse(response.body, symbolize_names: true)

      binding.pry
    end
  end
end