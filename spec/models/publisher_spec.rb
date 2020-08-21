require 'rails_helper'

RSpec.describe Publisher, type: :model do
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
      expect(@publisher.books.length).to eq(Book.where(publisher_id: @publisher.id).count)
    end

    it "books in shops" do
      expect(@publisher.shops.length).to eq(BooksShop.where(book_id: Book.where(publisher_id: @publisher.id).pluck(:id)).pluck(:shop_id).uniq.count)
    end
  end

  describe "shows" do
    it "summaries for shops that sell its books" do
      summary = @publisher.shop_summary

      expect(summary.class).to eq(Array)
      expect(summary.length).to eq(@publisher.shops.length)
      book_ids = summary.map {|shop| shop[:books_in_stock].collect {|book| book[:id]}}.flatten.uniq
      expect(book_ids - @publisher.books.pluck(:id)).to eq([])
    end
  end
end
