require 'rails_helper'

RSpec.describe Shop, type: :model do
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
    it "books" do
      expect(@shop.books.pluck(:id).sort).to eq(BooksShop.where(shop_id: @shop.id).pluck(:book_id).uniq.sort)
    end

    it "books in stock" do
      in_stock = @shop.publisher_data(@publisher.id)
      expect(in_stock.keys).to eq([:id, :name, :books_sold_count, :books_in_stock])
      expect(in_stock[:books_sold_count]).to eq(@shop.stock.where(sold: true).count)
    end

    it "publishers" do
      expect(@shop.publishers.pluck(:id)).to eq(@shop.books.pluck(:publisher_id).uniq.sort)
    end
  end

  describe "it" do
    it "sells a book" do
      count = @shop.inventory_count(@book.id)
      sold = @shop.sell(@book.id)
      expect(sold).to be(true)
      expect(@shop.inventory_count(@book.id)).to eq(count - 1)
    end

    it "sells multiple books" do
      count = @shop.inventory_count(@book.id)
      sold = @shop.sell(@book.id, 2)
      expect(sold).to be(true)
      expect(@shop.inventory_count(@book.id)).to eq(count - 2)
    end

    it "doesn't sell more books than it has" do
      count = @shop.inventory_count(@book.id)
      sold = @shop.sell(@book.id, count + 1)
      expect(sold).to be(false)
      expect(@shop.inventory_count(@book.id)).to eq(count)
    end
  end
end
