class ShopsController < ApplicationController
  def update
    shop = Shop.find(params[:id])
    sold = shop.sell(params[:book_id], params[:count].to_i)
    head (sold ? 200 : 400)
    end
  end
end
