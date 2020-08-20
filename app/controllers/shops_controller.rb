class ShopsController < ApplicationController
  def update
    shop = Shop.find(params[:id])
    sold = shop.sell(params[:book_id], params[:count].to_i)
    if sold
      head 200
    else
      head 400
    end
  end
end
