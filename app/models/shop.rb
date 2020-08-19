class Shop < ApplicationRecord
  has_many :books_shops
  alias_attribute :stock, :books_shops
  has_many :books, through: :books_shops
  has_many :publishers, through: :books

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
