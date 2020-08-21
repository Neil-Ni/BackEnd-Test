class Shop < ApplicationRecord
  has_many :books_shops
  alias_attribute :stock, :books_shops
  has_many :books, -> {distinct}, through: :books_shops
  has_many :publishers, -> {distinct}, through: :books

  def publisher_data(publisher_id)
    {id: self.id,
     name: self.name,
     books_sold_count: stock.where(sold: true).count,
     books_in_stock: books_in_stock(publisher_id)}
  end

  def books_in_stock(publisher_id)
    stock_counts(publisher_id) unless @counts
    books.where(publisher_id: publisher_id,).uniq.map {|book| {id: book.id, title: book.title, copies_in_stock: @counts[publisher_id][book.id]}}
  end

  def stock_counts(publisher_id)
    return @counts[publisher_id] if @counts
    @counts = Hash.new
    books_shops.where(book_id: books.where(publisher_id: publisher_id).pluck(:id).uniq).each do |book|
      @counts[publisher_id] ||= Hash.new(0)
      @counts[publisher_id][book.book_id] += 1
    end
    @counts[publisher_id]
  end

  def inventory_count(book_id)
    books_shops.where(book_id: book_id, sold: false).count
  end

  def sell(book_id, count = 1)
    unpurchased_books = self.books_shops.where(book: book_id, sold: false).limit(count)
    return false if unpurchased_books.count != count || count < 1
    unpurchased_books.update_all(sold: true)
    return true
  end
end
