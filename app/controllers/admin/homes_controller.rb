class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all.page(params[:page]).per(10).order('created_at DESC')
    # @order = Order.find(params)
    @order_details = OrderDetail.where(order_id: params[:id])
  end
end
