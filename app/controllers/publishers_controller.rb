class PublishersController < ApplicationController
  def show
    publisher = Publisher.find(params['id'])
    render json: {shops: publisher.shop_summary}
  end
end
