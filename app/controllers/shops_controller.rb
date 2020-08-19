class ShopsController < ApplicationController
  def update
    shop = Shop.find(params[:id])
    sold = shop.sell(params[:book_id], params[:count])
    render json: {success: sold} ### sub out for error code?
  end
end
