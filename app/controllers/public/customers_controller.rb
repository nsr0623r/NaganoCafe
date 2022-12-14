class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  # 顧客のマイページ
  def show
    @customer = current_customer
  end

  # 顧客の登録情報編集画面
  def edit
    @customer = current_customer
  end

  # 顧客の登録情報更新
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to my_page_customer_path
    else
      render :edit
    end
  end

  # 顧客の退会確認画面
  def unsubscribe
  end

  # 顧客の退会処理(ステータスの更新)
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
end
