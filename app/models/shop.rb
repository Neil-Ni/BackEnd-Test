class Shop < ApplicationRecord
  has_many :books_shops
  alias_attribute :stock, :books_shops
  has_many :books, through: :books_shops
  has_many :publishers, through: :books

  def publisher_data(publisher_id)
    {id: self.id,
     name: self.name,
     books_sold_count: stock.where(sold: true).count,
     books_in_stock: books_in_stock(publisher_id)}
  end

  def books_in_stock(publisher_id = nil)
    if publisher_id
      books.where(publisher_id: publisher_id).uniq.map {|book| {id: book.id, title: book.title, copies_in_stock: stock.where(book_id: book.id).count}}
    else
      books.uniq.map {|book| {id: book.id, title: book.title, copies_in_stock: stock.where(book_id: book.id).count}}
    end
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
