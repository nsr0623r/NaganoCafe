class Admin::CustomersController < ApplicationController
  # 顧客一覧画面
  def index
    @customers = Customer.all
    # @customer = Customer.find(params[:id])
  end

  # 顧客詳細画面
  def show
    @customer = Customer.find(params[:id])
  end

  # 顧客編集画面
  def edit
    @customer = Customer.find(params[:id])
  end

  # 顧客情報の更新
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end

  #顧客の退会確認画面
  def unsubscribe
  end

  #顧客の退会処理(ステータスの更新)
  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
end
