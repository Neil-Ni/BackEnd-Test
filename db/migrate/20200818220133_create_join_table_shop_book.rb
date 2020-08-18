class CreateJoinTableShopBook < ActiveRecord::Migration[6.0]
  def change
    create_join_table :shops, :books do |t|
      # t.index [:shop_id, :book_id]
      # t.index [:book_id, :shop_id]
      t.boolean :sold, default: false, index: true
    end
  end
end
