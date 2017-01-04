class AddFieldsReceipts < ActiveRecord::Migration
  def change
    add_reference :receipts, :supplier_order, index: true
    add_reference :receipts, :contract, index: true
  end
end
