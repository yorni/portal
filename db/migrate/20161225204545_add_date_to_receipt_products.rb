class AddDateToReceiptProducts < ActiveRecord::Migration
  def change
    add_column :receipt_products, :date, :date
  end
end
