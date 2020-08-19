class Shop < ApplicationRecord
  has_many :books_shops
  alias_attribute :stock, :books_shops
  has_many :books, through: :books_shops
  has_many :publishers, through: :books

  def books_sold
    stock.where(sold: true)
  end

  def books_in_stock
    in_stock = []
    books.each {|book| in_stock << {id: book.id, title: book.title, copies_in_stock: copies_in_stock(book.id).count}}
  end

  def copies_in_stock(book_id)
    stock.where(book_id: book_id, sold: false)
  end

  def sell(book_id)
    book = self.books_shops.find_by(book: book_id)
    if book
      book.sold = true
      book.save
    else
      return false
    end
  end
end
