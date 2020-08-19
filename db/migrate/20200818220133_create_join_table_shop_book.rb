class CreateJoinTableShopBook < ActiveRecord::Migration[6.0]
  def change
    create_join_table :shops, :books do |t|
      t.primary_key :id
      t.index [:shop_id, :book_id]
      t.index [:book_id, :shop_id]
      t.bigint :sold, default: false
    end
  end
end
