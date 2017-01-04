class SupplierOrder < ActiveRecord::Base
  belongs_to :branch
  belongs_to :supplier
  has_many :so_products
end
