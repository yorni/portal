class Order < ActiveRecord::Base
  belongs_to :institution
  has_many :order_products, dependent: :destroy
end
