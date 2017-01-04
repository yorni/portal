class AddInvoiceCodeToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :invoice_number, :string, limit: 12
  end
end
