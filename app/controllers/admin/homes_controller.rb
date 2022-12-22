class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @order_details = OrderDetail.where(order_id: params[:id])
  end
end
