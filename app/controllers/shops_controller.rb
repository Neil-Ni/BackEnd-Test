class ShopsController < ApplicationController
  def update
    shop = Shop.find(params[:id])
    sold = shop.sell(params[:book_id], params[:count])
    render json: {success: sold}
  end
end
