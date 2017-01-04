class Supplier < ActiveRecord::Base
  has_many :supplier_orders
end
