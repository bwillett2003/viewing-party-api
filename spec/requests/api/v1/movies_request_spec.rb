require "rails_helper"

RSpec.describe "Top Rated Movies Endpoint" do
  describe "happy path" do
    it "can retrieve the first 20 top rated movies" do
      stubbed_response = File.read("spec/fixtures/tmdb_top_rated_search.json")

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.tmdb[:key]}&language=en-US&page=1")
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
  end
end