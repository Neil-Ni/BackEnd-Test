class Publisher < ApplicationRecord
  has_many :books
  has_many :shops, through: :books
end
