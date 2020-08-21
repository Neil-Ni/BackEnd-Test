require 'rails_helper'

RSpec.describe Book, type: :model do
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

  describe "has" do
    it "shops" do
      expect(@book.shops.pluck(:id).sort).to eq(BooksShop.where(book_id: @book.id).pluck(:shop_id).sort)
    end

    it "publishers" do
      expect(@book.publisher).to eq(Publisher.find(@book.publisher_id))
    end
  end
end
