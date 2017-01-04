class CreateReceiptProducts < ActiveRecord::Migration
  def change
    create_table :receipt_products do |t|
      t.belongs_to :receipt, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true
      t.decimal :count_plan, precision: 8, scale: 2
      t.decimal :count_fact, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
