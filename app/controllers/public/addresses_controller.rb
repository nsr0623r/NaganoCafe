class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  # 配送先登録/一覧画面
  def index
    @address = Address.new
    @addresses = Address.all
  end

  # 配送先編集画面
  def edit
    @address = Address.find(params[:id])
  end

  # 配送先の登録
  def create
    @address = Address.new(address_params)
    @address.save
    redirect_to addresses_path
  end

  # 配送先の更新
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  # 配送先の削除
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
