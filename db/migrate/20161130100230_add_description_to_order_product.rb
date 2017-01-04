class AddDescriptionToOrderProduct < ActiveRecord::Migration
  def change
    add_column :order_products, :description, :string, limit: 100
  end
end
