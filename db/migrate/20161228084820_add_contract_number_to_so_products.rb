class AddContractNumberToSoProducts < ActiveRecord::Migration
  def change
    add_column :so_products, :contract_number, :string, limit: 12
    remove_column :so_products, :contract_id
  end
end
