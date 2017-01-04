class SoProduct < ActiveRecord::Base
  belongs_to :institution
  belongs_to :product
  belongs_to :supplier_order
end
