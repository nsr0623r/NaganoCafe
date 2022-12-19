class Public::OrdersController < ApplicationController
  # 注文情報入力画面(支払方法・配送先の選択)
  def new
    @order = Order.new
    @address = Address.all
    @customer = current_customer
  end

  # 注文情報確認画面
  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code_string = current_customer.postal_code_string
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code_string = @address.postal_code_string
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.customer_id = current_customer.id
    end
    @cart_items = current_customer.cart_items
    @order_new = Order.new
    render :confirm
  end

  # 注文完了画面
  def complete
  end

  # 注文確定処理
  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to order_complete_path
    else
      render :new
    end
  end
  
  # 注文履歴画面
  def index
  end

  # 注文履歴詳細画面
  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment, :postal_code_string, :address, :name, :customer_id, :order_status)
  end
end
