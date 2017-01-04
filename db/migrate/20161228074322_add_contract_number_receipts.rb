class AddContractNumberReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :contract_number, :string, limit: 12
    remove_column :receipts, :contract_id
    remove_column :receipts, :supplier_id
  end
end
