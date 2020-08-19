class Publisher < ApplicationRecord
  has_many :books
  has_many :shops, through: :books

  def shop_summary
    shops.map {|shop| shop.publisher_data(self.id)}
  end
end
