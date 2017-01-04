class AddDateSaToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :date_sa, :date
  end
end
