class Publisher < ApplicationRecord
  has_many :books
  has_many :shops, through: :books

  def shop_summary
    shops.map {|shop| shop.publisher_data(self.id)}.sort {|a, b| b[:books_sold_count] <=> a[:books_sold_count]}
  end
end
