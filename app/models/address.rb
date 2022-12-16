class Address < ApplicationRecord
  belongs_to :customer, optional: true
  
  def address_display
    '〒' + postal_code_string + ' ' + address + ' ' + name
  end
end
