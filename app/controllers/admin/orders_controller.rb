class Admin::OrdersController < ApplicationController
  # 管理者：注文詳細
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
  end
  
  # 管理者：注文ステータス更新
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
    
    if @order.status == "入金確認"
      @order_details.each do |order_detail|
        order_detail.making_status = "製作待ち"
        order_detail.update
      end
    end
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
end
