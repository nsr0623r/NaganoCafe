class RenamePostalCodeStringColumnToAddresses < ActiveRecord::Migration[6.1]
  def change
    rename_column :addresses, :postal_code_string, :postal_code
  end
end
