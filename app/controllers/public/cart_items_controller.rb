class Public::CartItemsController < ApplicationController
  # カート内商品
  def index
    @cart_items = CartItem.all
  end

  # カート内商品追加
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       cart_item.number += params[:cart_item][:number].to_i cart_item.save
       redirect_to cart_items_path
    elsif @cart_item.save
       redirect_to cart_items_path
    else
       render :index
    end
  end

  # 商品単価(税込)
  def with_tax_price
    (price * 1.1).floor
  end

  # 小計
  def subtotal
    item.with_tax_price * amount
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end