class OrderDetail < ApplicationRecord
  belongs_to :order#, optional: true
  # belongs_to :customer, optional: true
  belongs_to :item
  
  enum making_status: { cannot_be_manufactured: 0, waiting_for_production: 1, production: 2, completion_of_production: 3 }
end
