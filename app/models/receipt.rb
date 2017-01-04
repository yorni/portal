class Receipt < ActiveRecord::Base
  belongs_to :institution
 # belongs_to :supplier
  belongs_to :supplier_order
  belongs_to :contract
  has_many :receipt_products
end
