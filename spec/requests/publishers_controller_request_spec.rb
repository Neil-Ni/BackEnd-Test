require 'rails_helper'

RSpec.describe PublishersController, type: :request do
  before(:each) do
    @publisher = create(:publisher)
    3.times {create(:shop)}
    3.times {@publisher.books << create(:book)}
    Book.all.each do |book|
      Shop.all.each do |shop|
        rand(2..4).times {shop.books << book}
      end
    end
  end

  describe "GET #show" do
    it "returns a shop inventory of its books" do
      get publisher_path(@publisher.id)

      expect(response).to be_successful
    end

    it "returns a JSON object" do
      get publisher_path(@publisher.id)
      data = JSON.parse(response.body)
      expect(data.class).to eq(Hash)
      expect(data[:shops].count).to eq(@publisher.shops.count)
    end
  end
end
