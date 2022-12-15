class Public::CartItemsController < ApplicationController
  # カート内商品
  def index
    @cart_items = current_customer.cart_items.all
  end

  # カート内商品追加
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       cart_item.amount += params[:cart_item][:amount].to_i
       cart_item.save
       redirect_to cart_items_path
    elsif @cart_item.save
          @cart_items = current_customer.cart_items.all
          render :index
    else
      render :index
    end
  end

  # カート内商品更新
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  # 商品単価(税込)
  def with_tax_price
    (price * 1.1).floor
  end

  # 小計
  def subtotal
    item.with_tax_price * amount
  end

  # カート内商品：全削除
  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  # カート内商品：対象商品の削除
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end