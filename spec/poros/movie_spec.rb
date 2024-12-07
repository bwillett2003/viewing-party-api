require 'rails_helper'

RSpec.describe Movie, type: :poro do
  describe 'attributes' do
    it 'initializes with id, title, and vote_average' do
      data = { id: 1, title: 'Test Movie', vote_average: 8.5 }
      movie = Movie.new(data)

      expect(movie.id).to eq(1)
      expect(movie.title).to eq('Test Movie')
      expect(movie.vote_average).to eq(8.5)
    end
  end
end
