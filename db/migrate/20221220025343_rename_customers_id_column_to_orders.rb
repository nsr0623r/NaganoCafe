class RenameCustomersIdColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :customers_id, :customer_id
  end
end
