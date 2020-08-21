require 'rails_helper'

RSpec.describe "ShopsControllers", type: :request do
  before(:each) do
    @publisher = create(:publisher)
    3.times {create(:shop)}
    3.times {@publisher.books << create(:book)}
    Book.all.each do |book|
      Shop.all.each do |shop|
        rand(2..4).times {shop.books << book}
      end
    end
    @shop = Shop.first
    @book = @shop.books.first
  end

  describe "PUT #update" do
    it "sells books" do
      put shop_path(@shop.id), params: {book_id: @book.id, count: @shop.inventory_count(@book.id)}
      expect(response).to have_http_status(200)
    end

    it "rejects purchases when stock doesn't meet demand" do
      original_inventory = @shop.inventory_count(@book.id) 
      put shop_path(@shop.id), params: {book_id: @book.id, count: original_inventory + 1}
      expect(response).to have_http_status(400)
    end
  end
end
