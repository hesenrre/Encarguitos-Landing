class WelcomeController < ApplicationController
  def index
    @order = Order.new
  end

  def create
    order = Order.new(params[:order])
    respond_to do |format|
      ok = order.save
      format.json {render :json => {:success => ok }}
      format.js {render :success => ok}
    end
  end
end
