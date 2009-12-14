class Order < ActiveRecord::Base
  set_table_name 'ORDERS'
  has_many :order_items
end
