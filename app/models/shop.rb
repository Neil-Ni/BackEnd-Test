class Shop < ApplicationRecord
  has_many :books_shops
  alias_attribute :stock, :books_shops
  has_many :books, through: :books_shops
  has_many :publishers, through: :books

  def publisher_data(publisher_id)
    stock_counts(publisher_id)
    {id: self.id,
     name: self.name,
     books_sold_count: stock.where(sold: true).count,
     books_in_stock: books_in_stock(publisher_id)}
  end

  def books_in_stock(publisher_id)
    books.where(publisher_id: publisher_id).uniq.map {|book| {id: book.id, title: book.title, copies_in_stock: @counts[book.id]}}
  end

  def stock_counts(publisher_id)
    return @counts if @counts
    @counts = Hash.new(0)
    books_shops.where(book_id: books.where(publisher_id: publisher_id).pluck(:id).uniq).each {|book| @counts[book.book_id] += 1}
  end

  def sell(book_id, count = 1)
    unpurchased_books = self.books_shops.where(book: book_id, sold: false).limit(count)
    if unpurchased_books.count == count
      unpurchased_books.update_all(sold: true)
      return true
    else
      return false
    end
  end
end
