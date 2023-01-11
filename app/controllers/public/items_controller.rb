class Public::ItemsController < ApplicationController
  # 顧客：商品一覧
  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  # 顧客：商品詳細
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

end
