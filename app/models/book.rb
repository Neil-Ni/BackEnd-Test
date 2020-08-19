class Book < ApplicationRecord
  belongs_to :publisher
  has_many :books_shops
  alias_attribute :stock, :books_shops
  has_many :shops, through: :books_shops
end
